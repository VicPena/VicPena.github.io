# read in tweets
# URL "http://vicpena.github.io/workshops/2021/tweets.csv"

# take a look at dataset

# count number of tweets by verified / unverified users

# find average follower counts for verified / unverified users

# count number of tweets classified as complaints / not complaints

# plot results


# tokenize the tweets

# top 10 word frequencies


# filter out stop_words


# repeat table w/ top 10 word freq

# filter out some extra "words'

# plot top 10 most frequent words

# plot top 10 most frequent words by complaint label

# do the same, but for verified vs unverified 


##############
# wordclouds #
##############
library(wordcloud)

# find word clouds for complaints / noncomplaints




######################
# Sentiment analysis #
######################

# merge tokenized data with loughran dictionary

# tabulate sentiments

# plot sentiments


# tabulate sentiments for complaints / noncomplaints 

# plot sentiments for complaints / noncomplaints

# plot sentiments for verified / unverified users


# tabulate top 3 words by sentiment

# plot top 3 words by sentiment


# plot top 3 words by sentiment for complaints / noncomplaints separately


##################
# Topic modeling #
##################

# create dtm

# run topic model for different number of topics
# select "best" in terms of perplexity

# plot with top 10 words by topic


#############################
# modeling complaint_labels #
#############################

# goal: building a model
# to predict if a tweet is a complaint or not


library(readr)
tweets <- read_csv("http://vicpena.github.io/workshops/2021/tweets.csv")
library(tidytext)
library(SnowballC) # used for stemming 

glimpse(tweets)

# split data into training and test set
library(rsample)
set.seed(123) # this ensures that we get the same random split
split = initial_split(tweets, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)

# fit models with our training set 
# and then test the predictive performance on a test set that was not used to
# build the models

# tokenize the data
train_tok = train %>% unnest_tokens(word, tweet_text) 
# get rid of stop_words (uninformative)
train_tok = train_tok %>%  anti_join(stop_words) 

# find sentiments of tweets, using bing dict
train_tok = train_tok %>% inner_join(get_sentiments("bing"))
train_tok
# find % positivity by tweet_id
# convert sentiment into factor
train_tok = train_tok %>% mutate(sentiment = as.factor(sentiment))
sent = train_tok %>% group_by(X1) %>% count(sentiment, .drop = FALSE) %>% mutate(pos_perc = 100*n/sum(n))
# filter positivity
sent = sent %>% ungroup %>% filter(sentiment == "positive")
sent

# merge with complaint_label
comp = train_tok %>% select(X1, complaint_label)
sent = sent %>% left_join(comp, by = 'X1')


# find average positivty of tweets by complaint_label
sent %>% group_by(complaint_label) %>% summarize(avgPos = mean(pos_perc))
# convert complaint_label to factor, so that we can run models on it
sent = sent %>% mutate(complaint_label = as.factor(complaint_label))
sent = unique(sent)
mod_log = glm(complaint_label ~ pos_perc, family = "binomial", data = sent)
table(sent$complaint_label) # 1 in logistic reg is non-complaint because R uses alphabetical order


# I'm going to get new tweets
# I can certainly use sentiment analysis on these tweets
# building a model that is able to predict whether something is a complaint
# based upon the % positive words

# If this model is going to be useful, I should see that complaints have
# higher negativity rates (or smaller positivity rates) than non-complaints



test_tok = test %>% unnest_tokens(word, tweet_text) 
test_tok = test_tok %>%  anti_join(stop_words) 

# find sentiments of tweets, using bing dict
test_tok = test_tok %>% inner_join(get_sentiments("bing"))
# find % positivity by tweet_id
# convert sentiment into factor
test_tok = test_tok %>% mutate(sentiment = as.factor(sentiment))
test_sent = test_tok %>% group_by(X1) %>% count(sentiment, .drop = FALSE) %>% mutate(pos_perc = 100*n/sum(n))
# filter positivity
test_sent = test_sent %>% ungroup %>% filter(sentiment == "positive")

# merge with complaint_label
comp = test_tok %>% select(X1, complaint_label)
test_sent = test_sent %>% left_join(comp, by = 'X1')

test_sent = unique(test_sent)

# add in predictions in "complaint / non-complaint" terms, transform to factor as needed
preds = predict(mod_log, newdata = test_sent, type = "response") # predicted probabilities of NONCOMPLAINTS
test_preds = test_sent %>% mutate(preds = preds)
ggplot(test_preds) +
  aes(x = preds) +
    geom_histogram() +
    facet_wrap(~complaint_label)

test_preds = test_preds %>% mutate(preds_outcome = ifelse(preds > 0.51, "Non-Complaint", "Complaint"))
test_preds
# install.packages("caret")
library(caret)
confusionMatrix(as.factor(test_preds$preds_outcome), as.factor(test_preds$complaint_label), positive = "Complaint")
# accuracy: % of times that I classify correctly
# sensitivy: % of times that I classify true positives correctly
#            % of times that I classify true complaints correctly
# specificty: % of times that I classify true negatives correctly
#             % of times that I classify true complaints correctly

# summarize results in confusion matrices


