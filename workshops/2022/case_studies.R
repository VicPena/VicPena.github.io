#####################
# Some case studies #
#####################

# Adapted from:
# https://paldhous.github.io/NICAR/2019/r-text-analysis.html

################
# Trump tweets #
################

# http://vicpena.github.io/workshops/2022/trumptweets.csv

#---------------------------#
# Exploratory data analysis #
#---------------------------#

# glimpse dataset

# count year and month

# month / year with most tweets

# identify 3 tweets in dataset with most retweets

# identify 3 tweets with most favorite counts

#------------------#
# word frequencies #
#------------------#

# separate tweets into words

# take out stop words

# take out missing words with !is.na(word)

# find top 10 most frequent words

# find top 5 most frequent words by source2

# plot the results

# find top 5 most frequent words by year

# plot the results


# do the same with bigrams!

# find bigrams

# top 10 bigrams

# top 5 bigrams by source2, plot results

# top 5 bigrams by year

######################
# sentiment analysis #
######################

# merge with bing dictionary

# do sentiment analysis by source2 
# are tweets by aides more positive / negative than
# tweets by Trump himself?

# group_by source2, find % of positive 
# tweets by source, plot results


# use bing dictionary to do sentiment analysis by year and month
# track positivity over time

# tabulate by year, month, find % of positive 
# tweets by year, month, plot results

#---------------------------#
# topic modeling by source2 #
#---------------------------#

library(topicmodels)
# group_by source2, count words, and cast_dtm

# run LDA

# find betas and plot them

# find gammas and plot them


##########################################
# Analyzing State of the Union addresses #
##########################################


# date format: "%Y-%m-%d"
# http://vicpena.github.io/workshop/2022/sou.csv

# track sentiment analysis over time


# plot readability scores over time 
# https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests
# 0.39*(words/sentences) + 11.8*(syllables/words) - 15.59

install.packages("Rcpp")
install.packages("quanteda")
install.packages("nsyllable")
library(quanteda)
library(nsyllable)
library(tidyverse)

# nsyllable(text),
# nsentence(text),
# ntoken(text, remove_punct = TRUE)

