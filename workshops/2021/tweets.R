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

library(tidytext)
library(readr)
tweets <- read_csv("http://vicpena.github.io/workshops/2021/tweets.csv")


# split data into training and test set
library(rsample)
set.seed(123) # this ensures that we get the same random split
split = initial_split(tweets, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)


# build model on train set

# find sentiments of tweets, using bing dict

# find % positivity by tweet_id
# convert sentiment into factor

# filter positivity

# merge with complaint_label

#  find % of original tweets that we kept

# find average positivty of tweets by complaint_label

# plot % positivty of tweets by complaint_label

#  run logistic regression to predict complaint status given pos_perc
# first, we'll have to convert complaint_label into factor

# predict labels for test set



# find sentiments of tweets, using bing dict

# find % positivity by tweet_id
# convert sentiment into factor

# filter positivity

# merge with complaint_label


#  find % of original tweets that we kept


# add in predictions in "complaint / non-complaint" terms, transform to factor as needed

# summarize results in confusion matrices
# install.packages("caret")



