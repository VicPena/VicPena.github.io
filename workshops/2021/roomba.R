# Amazon reviews of some Roombas 
# Source: Introduction to text analysis in R,
#  by Dotson [datacamp course]

# Link: http://vicpena.github.io/workshops/2021/Roomba.csv

# read in the data

# take a quick look at the data


# how many products are there and how many reviews 
# per product?

# average stars grouped by product?


# transform data so that each row is a different word
# (i.e. tokenize) using tidytext
# install.packages("tidytext")

# frequency table of words

# find top 10 most frequent words

# get rid of "stop words"
# View(stop_words)
# merge existing dataset w/ stop_words


# after filtering out stop words
# let's repeat the freq table
# find top 5 most freq words

# get rid of some more words


# find freq tables by product


# find top 5 most freq words by product


# add relative frequencies (i.e. proportions)



#############################
# Plotting word frequencies #
#############################

# More: http://www.cookbook-r.com/Graphs/

# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid


# Barplot of word frequency, top 10 words only


# order bars by frequency


# Barplot of word frequency by product, top 10 words only



##############
# wordclouds #
##############

# install.packages("wordcloud")

# change colors
# colors in R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf



######################
# Sentiment analysis #
######################

# goal: figure out the "mood" of a text

# sentiment analysis uses dictionaries
# that classify words into sentiments
# once we map out words to sentiments,
# we can count how frequently each sentiment
# appears in our data

# different dictionaries within tidytext

# install.packages("textdata")
# install afinn, loughran, nrc
library(textdata)


# counts of different sentiments in dictionaries

# bing

# afinn

# loughran

# check out words that are considered "constraining"

# nrc 



# merge tokenized data with bing dictionary
# keeping only words that have a match in the dictionary
# (can use either inner_ or right_join)
# then, tabulate sentiment


# plot sentiments


# same but with percentages on the y axis


# same but with nrc
# horizontal bars ordered by frequency


# plot top 10 positive and negative words, using bing

# do the same, but break down further by product

# find words that appear in top 10 
# in only one of the products

# add "Product" variable

##################
# Topic modeling #
##################

# add variable to Roomba identifying the reviews

# create dtm
# install.packages("tm")

# run topic model
# install.packages("topicmodels")
library(topicmodels)
# k is number of topics

# convert lda output to tidy format

# betas are conditional word probabilities
# given the topic

# plot with top 10 words by topic



# how to select k?
# one way: using "perplexity" (the lower the better)

