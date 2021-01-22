# US congress data
library(tidyverse)
library(tidytext)
library(SnowballC)
# A dataset containing information about bills from the US congress
# Link: https://raw.githubusercontent.com/VicPena/VicPena.github.io/master/workshops/2021/congress.csv
# source: https://cfss.uchicago.edu/notes/supervised-text-classification/
library(readr)
congress <- read_csv("https://raw.githubusercontent.com/VicPena/VicPena.github.io/master/workshops/2021/congress.csv")

# ID: identifier for bill
# cong: session of congress in which bill first appeared
# h_or_sen: indicates whether bill was introduced in the House or Senate
# label: major subject of bill
# text: description of bill


# tokenize, 
# get rid of stop_words, and stem
congress_tokens = congress %>%
                    unnest_tokens(word, text) %>%
                    anti_join(stop_words) %>%
                    mutate(word = wordStem(word)) %>%
                    filter( !str_detect(word, "\\d"))

# filter out numbers using a regular expression
# \\d : detects digits



# bind tf_idfs by label
# we start creating a table with word freqs by labels
# tf_idf: corpus of documents
# corpus: all the bills 
# documents: bills themselves
congress_tfidf = congress_tokens %>% group_by(label) %>% count(word) %>% bind_tf_idf(word, label, n)congress_tfidf

# plot top 3 words according to tf_idf by bill label
plot_tfidf = congress_tfidf %>% slice_max(tf_idf, n = 3)

ggplot(plot_tfidf) +
  aes(x = reorder_within(word, tf_idf, label), y = tf_idf, fill = label) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  coord_flip() +
  facet_wrap(~ label, ncol = 4, scales = "free")   


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
train_tokens = train %>%
  unnest_tokens(word, text) %>%
  filter( !str_detect(word, "\\d") ) %>%
  anti_join(stop_words) %>%
  mutate(word = wordStem(word))

# afinn: dictionary
# find the average sentiment of the bill descriptions
# I want to use that as a predictor to predict the label of a bill

finn_stemmed = get_sentiments("afinn") %>% mutate(value = wordStem(value))

train_sent = train_tokens %>%
                  left_join(get_sentiments("afinn")) %>%
                    replace_na(list(value = 0)) %>%
                      group_by(ID2) %>%
                          summarize(avgSentiment = mean(value))


# get the top 2 words according to tf_idf by label
topw = train_tokens %>% group_by(label) %>% count(word) %>%
      bind_tf_idf(word, label, n) %>%
          slice_max(tf_idf, n = 2) %>% 
              ungroup %>%
                select(word)

pred_mat = matrix(nrow = nrow(train), ncol = nrow(topw))
colnames(pred_mat) = topw$word
for (i in 1:nrow(train)) {
  aux  = train_tokens %>% filter(ID2 == i)
  pred_mat[i,] = topw$word %in% aux$word
}

train_sent
train2 = train %>% left_join(train_sent, by = "ID2")
train2 = cbind(train2, 1*pred_mat)

# built a predictor using sentiment analysis 
# built another one using tf-idf

# multinomial logistic regression
# outcome: label
# predictors: sentiment, "word appearance indictors"

# random forest
# outcome: label
# predictors: sentiment, "word appearance indictors"
library(randomForest)
glimpse(train2)
fit = train2 %>% select(-ID, -cong, -billnum, -major, -text, -ID2)
glimpse(fit)
mod = randomForest(as.factor(label) ~ . , data = fit)
# if I were to guess at random
# the error rate would be
# 1 - 1/20
1-1/20
# I'm going to add as predictors in my model
# dummy variables that indicate whether these words are within the text description
# predict on the test set
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

test_sent

pred_mat = matrix(nrow = nrow(test), ncol = nrow(topw))
colnames(pred_mat) = topw$word
for (i in 1:nrow(test)) {
  aux  = test_tokens %>% filter(ID2 == i)
  pred_mat[i,] = topw$word %in% aux$word
}
test2  = test %>% left_join(test_sent, by = "ID") %>% mutate(label = factor(label))
test2 = cbind(test2, 1*pred_mat)

pred = predict(mod, newdata = test2)

library(caret)
confusionMatrix(pred, test2$label)
# accuracy of the model in the test set is 
# ~37%
# 37% of the time, my model is classifying correctly
# if I were to guess at random I would get it right ~ 5%
# a step beyond guessing at random would be simply predict
# the most prevalent (frequent) category for all bills
# the frequency of the most prevalent category is the No Information Rate (NIR)
# in this case, if I were to say that all bills have the most frequent label
# I'd would get it right 15% of the time, which is way smaller than 37%
# I have evidence to claim that the accuracy of my model is better than simply
# using NIR




# acc is not great, but this is certainly 
# better than guessing at random, or simply
# guessing the most prevalent category 
# the outcome has 20 outcomes... this is a hard
# classification problem
