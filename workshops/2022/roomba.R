# Amazon reviews of some Roombas 
# Source: Introduction to text analysis in R,
#  by Dotson [datacamp course]

# Link: http://vicpena.github.io/workshops/2021/Roomba.csv

# read in the data


# take a quick look at the data
# install.packages("tidyverse")
library(tidyverse)

# how many products are there and how many reviews 
# per product?


# average stars grouped by product?
# group_by and summarize (tidyverse)

# transform data so that each row is a different word
# (i.e. tokenize) using tidytext
# install.packages("tidytext")
library(tidytext)
# function unnest_tokens to convert reviews into 
# "words"
tok = Roomba %>% unnest_tokens(word, Review)

# frequency table of words

# find top 10 most frequent words


# we want to get rid of "uninformative words"
library(tidytext)
stop_words



# get rid of stop_words with anti_join


# re-do the count

# get rid of "roomba" and "vacuum"
# filter by logical condition that keeps out "roomba" and "vacuum"
# not word in the vector "roomba", "vacuum"


# find freq tables by product
# find top 5 most freq words by product

# add relative frequencies (i.e. proportions)
# by product


############
# stemming #
############

# install.packages("SnowballC")
library(SnowballC)
tok = tok %>% mutate(word_stem = wordStem(word))


# 1st create freq table, top 10 stemmed words

# could re-do analysis with stemmed data


#############################
# Plotting word frequencies #
#############################

# More: http://www.cookbook-r.com/Graphs/

# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid


# Barplot of word frequency, top 10 words only
# I need a table that has that information first


# now I can use ggplot

# order bars by frequency
# with x = fct_reorder(word, n)



# Barplot of word frequency by product, top 10 words only


# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid

# x = reorder_within(word_stem, n, Product)
# scale_x_reordered() 
# facet_wrap( Product ~ . , scales = "free") +
  


##############
# wordclouds #
##############


# install.packages("wordcloud")
library(wordcloud)

# input for wordcloud
# a frequency table

# first I will need a table with word frequencies

# important to remember that 
# the input of wordcloud is a freq table with word counts

# change colors
# colors in R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# we can do separate word clouds by product


# separate the data into 2 disjoint sets
# and then repeat the process



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
# bing dictionary
get_sentiments("bing") %>% View
# install.packages("textdata")
# install afinn, loughran, nrc
library(textdata)
# afinn: allows me to work with a numerical ordinal scale 
# that goes from -5 (awful word category) to 5 (enthusiastic great words)
get_sentiments("afinn") %>% View
get_sentiments("afinn") %>% count(value)
get_sentiments("afinn") %>% filter(value == 5)
# loughran: has more sentiments than just + and - but... it's not ordinal
get_sentiments("loughran") %>% count(sentiment)
# nrc
get_sentiments("nrc") %>% count(sentiment)


# merge tokenized data with bing dictionary
# keeping only words that have a match in the dictionary
# (can use either inner_ or right_join)
# then, tabulate sentiment

# plot sentiments
# fct_reorder(sentiment, n)
# label = paste(round(perc, 2),"%")
# geom_text


# plot top 10 most frequent positive and negative words, using bing

# create a dataset that is merged with the bing dictionary

# table which contains the top 10 words by sentiments
# x = reorder_within(word, n, sentiment)
# scale_x_reordered()
# facet_wrap(  sentiment  ~ . , scales = "free" )


# do the same, but break down further by product



# find top 100 words for the roombas
# call output top

# find words that appear for one roomba but not the other
# values_fill = 0 changes NA to 0 in pivot_wider
top_wide = top %>% pivot_wider(names_from = Product, values_from = n) 
top_wide %>% filter(!complete.cases(top_wide))
