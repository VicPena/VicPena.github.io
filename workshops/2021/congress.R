# US congress data
library(tidyverse)
library(tidytext)
library(SnowballC)
# A dataset containing information about bills from the US congress
# Link: https://raw.githubusercontent.com/VicPena/VicPena.github.io/master/workshops/2021/congress.csv

# ID: identifier for bill
# cong: session of congress in which bill first appeared
# h_or_sen: indicates whether bill was introduced in the House or Senate
# label: major subject of bill
# text: description of bill


# tokenize, 
# get rid of stop_words, and stem

# bind tf_idfs by label

# plot top 3 words according to tf_idf by bill label

#############################################
# build predictive model to predict "label" #
#############################################

# split data into train and test
library(rsample)
set.seed(123) # this ensures that we get the same random split
split = initial_split(congress, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)

# add bill ID to training set
train = train %>% mutate(ID2 = 1:nrow(train))

# tokenize train set, get rid of stop words
# and stem


# find average sentiment of text
# using afinn dictionary


# find top2 words accrording to tf_idf by label
topw = train_tokens %>% group_by(label) %>%
  count(word) %>% bind_tf_idf(word, label, n) %>%
  slice_max(tf_idf, n = 2) %>%
  ungroup() %>%
  select(word)

# create matrix that has 
# indicators of whether top words by label appear in each
# bill
pred_mat = matrix(nrow = nrow(train), ncol = nrow(topw))
colnames(pred_mat) = topw$word
for (i in 1:nrow(train)) {
  aux  = train_tokens %>% filter(ID2 == i)
  pred_mat[i,] = topw$word %in% aux$word
}

# join with sentiment data
train2  = train %>% left_join(train_sent, by = "ID") %>% mutate(label = factor(label))
train2 = cbind(train, 1*pred_mat)

# predict label given avgSentiment, h_or_sen 
library(randomForest)
fit = train2 %>% select(-ID, -cong, -billnum, -major, -text, -ID2)
mod = randomForest(as.factor(label) ~ ., data = fit)

# predict test set
test = test %>% mutate(ID2 = 1:nrow(test))


test_tokens = test %>%
  unnest_tokens(word, text) %>%
  filter( !str_detect(word, "\\d") ) %>%
  anti_join(stop_words) %>%
  mutate(word = wordStem(word))

test_sent = test_tokens %>% 
  left_join(get_sentiments("afinn")) %>% 
  replace_na(list(value =0)) %>%
  group_by(ID) %>%
  summarize(avgSentiment = mean(value, na.rm = TRUE))


pred_mat = matrix(nrow = nrow(test), ncol = nrow(topw))
colnames(pred_mat) = topw$word
for (i in 1:nrow(test)) {
  aux  = test_tokens %>% filter(ID2 == i)
  pred_mat[i,] = topw$word %in% aux$word
}
test2  = test %>% left_join(test_sent, by = "ID") %>% mutate(label = factor(label))
test2 = cbind(test2, 1*pred_mat)

test2  = test2 %>% left_join(test_sent, by = "ID") %>% mutate(label = factor(label))

pred = predict(mod, newdata = test2)

library(caret)
confusionMatrix(pred, test2$label)
# acc is not great, but this is certainly 
# better than guessing at random, or simply
# guessing the most prevalent category 
# the outcome has 20 outcomes... this is a hard
# classification problem
