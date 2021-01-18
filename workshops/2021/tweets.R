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


