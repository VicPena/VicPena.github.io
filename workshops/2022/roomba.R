# Logistics
# - Today: word frequencies, plots, 
#     word clouds, sentiment analysis
# - I'll send a project this afternoon / evening
# - Work on it tomorrow if you can; we'll solve it Wednesday

###############################
# Introduction to text mining #
###############################

# Amazon reviews of some Roombas 
# (vaccuum cleaners robots)
# Source: Introduction to text analysis in R,
#  by Dotson [datacamp course]

# Link: http://vicpena.github.io/workshops/2021/Roomba.csv

# install.packages("tidyverse")
# install.packages("tidytext")
# install.packages("textdata")
library(tidyverse)
# library that has useful functions for
# manipulating data and creating plots

# install.packages("tidytext")
# install.packages("textdata")
library(tidytext)
library(textdata)

# read in the data
Roomba <- read_csv("http://vicpena.github.io/workshops/2021/Roomba.csv")

# take a quick look at the data
summary(Roomba)


# how many products are there and how many reviews 
# per product?
# count function: gets tables
Roomba %>% count(Product)
# Two products: 
# Roomba 650: 633
# Roomba 880: 1200

# average stars grouped by product?
# average stars for the roomba 650 and the roomba 880 separately
# group_by and summarize (tidyverse)
# find summary statistics that are grouped by
# categories given by a categorical variable

# categorical variable: Product
# output: separate statistics for the different products
Roomba %>% group_by(Product) %>% summarize(avg_stars = mean(Stars),
                                           sd_stars = sd(Stars))

# so far, this is review
# we have not used the text data at all

# we are going to break up
# the reviews into words and then we're going to
# count word frequencies


# transform data so that each row is a different word
# function unnest_tokens to convert reviews into 
# "words"
tok = Roomba %>% unnest_tokens(word, Review)

# frequency table of words

# find top 10 most frequent words
tok %>% count(word)
# 10,310: number of words in this dataset

# If I'm interested in getting the top 10 only
# I can use a function called slice_max that gets
# me just that
tok %>% count(word) %>% slice_max(n, n = 10)
# this is not incorrect 
# however, it's not very informative because the
# most frequent words are always going to be these
# ones

# get rid of these uninformative words
# and then create a table that has frequencies of
# words that are informative
# prepositions, we want to get rid of them

# we want to get rid of "uninformative words"
stop_words %>% view

# get rid of stop_words with anti_join
tok = tok %>% anti_join(stop_words)

# re-do the count
tok %>% count(word) %>% slice_max(n, n = 10)


# get rid of "roomba" and "vacuum"
# filter by logical condition that keeps out "roomba" and "vacuum"
# not word in the vector "roomba", "vacuum"
tok = Roomba %>% unnest_tokens(word, Review)
tok = tok %>% anti_join(stop_words)
tok = tok %>% filter( !(word %in% c("roomba", "vacuum", "650", "880")))
# ! negation
# set up a vector with words to exclude: c("roomba", "vacuum")
# words are on the list

# %in%: checks whether an entry of a vector is within
# a range of values given by a vector
vec = c("dog", "cat", "mouse", "cow")
pets = c("dog", "cat")
vec %in% pets
!(vec %in% pets) # opposite


# re-do the count... again
tok %>% count(word) %>% slice_max(n, n = 10)

# I'm going to stop here but the process could keep going
# until we have a set of words that we think is "informative"

# find freq tables by product
# find top 5 most freq words by product
# can be done with the group_by 
# and summarize command
tok %>% group_by(Product) %>%
            count(word) %>% 
                slice_max(n, n = 5)

# find relative frequencies / proportions
# mutate function
tok_count = tok %>% group_by(Product) %>% count(word) %>% mutate(prop = n/sum(n))
tok_count %>% slice_max(n, n = 5)

# these are counts based on one word only
# and they don't capture things like "not clean"
# "not good" 
# the floor is clean
# the floor is not clean
# this distinction is not captured in our analysis

# we are going to see later (wednesday?)
# how to analyze pairs of words bigrams 
# separate entry for "is clean" and "not clean"

# there is a tradeoff because your effective sample size
# decreases as you make n-grams larger
# bigrams: two words
# ...
# n-grams: n words

# people do one word at a time and bigrams and 
# stop there


# add relative frequencies (i.e. proportions)
# by product


############
# stemming #
############

# install.packages("SnowballC")
library(SnowballC)
tok = tok %>% mutate(word_stem = wordStem(word))
# the effect of running mutate above is creating
# a new variable called word_step whose output is the 
# stemmed words

# stemmed words: just leave the root

tok_count = tok %>% group_by(Product) %>% count(word_stem) %>% mutate(prop = n/sum(n))
tok_count %>% slice_max(prop, n = 3)


# if we want to find the results not grouped by product
tok %>% count(word_stem) %>% mutate(prop = n/sum(n)) %>% slice_max(prop, n = 10)



#############################
# Plotting word frequencies #
#############################

# More: http://www.cookbook-r.com/Graphs/

# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid


# Barplot of word frequency, top 10 words only
# disregarding product

# I need a table that has that information first
top10_words = tok %>% count(word_stem) %>% slice_max(n, n = 10)
top10_words

# now I can use ggplot
# ggplot(data) +
# aes(x = , y = ...) +
# geom_col [geom_columns] +
# ... 
ggplot(top10_words) +
  aes(x = word_stem, y = n) +
    geom_col()

# for example, the bars
# are not sorted according to their frequency
# which makes reading the plot 
# difficult

ggplot(top10_words) +
  aes(x = fct_reorder(word_stem, n), y = n) +
  geom_col()

ggplot(top10_words) +
  aes(y = fct_reorder(word_stem, n), x = n) +
   geom_col() +
      ylab("top 10 most frequent roots") +
        xlab("frequency") +
          ggtitle("Roomba reviews: Top 10 most frequent roots")
# order bars by frequency
# with x = fct_reorder(word, n)

# 1st. creating a table with the top 10 stems by product
top10_words_prod = tok %>% group_by(Product) %>% count(word_stem) %>% slice_max(n, n = 10)
top10_words_prod %>% view

# and then use essentially the same code we used
# adding facet_wrap: graphical "group_by"

# the reorder within function
# will let me sort the bars by frequency
# separately by Product

# this works as long as we have a
# dataset called top10_words_prod
# that has top 10 most frequent stems
# by a categorical variable
ggplot(top10_words_prod) +
  aes(y = reorder_within(word_stem, n, Product), x = n, fill = Product) +
    geom_col() +
    scale_y_reordered() +
      facet_wrap(~ Product, scales = "free") +
        ylab("top 10 most frequent stems (by product)") +
            theme(legend.position="none") +
              scale_fill_manual(values = c("darkorange", "dodgerblue"))


# x = reorder_within(word_stem, n, Product)
# scale_x_reordered() 
# facet_wrap( Product ~ . , scales = "free") +

# see if the top 10 most frequent words
# depend a lot on the number of stars of the review
Roomba %>% count(Stars)


top10_words_prod = tok %>% group_by(Product) %>% count(word_stem) %>% slice_max(n, n = 10)
# modify the code above so that you 
# find top 5 most frequent word stems
# grouped by Stars (ignore the product)
top5_words_star = tok %>% group_by(Stars) %>% count(word_stem) %>% slice_max(n, n = 5)


ggplot(top5_words_star) +
  aes(y = reorder_within(word_stem, n, Stars), x = n, fill = Stars) +
  geom_col() +
  scale_y_reordered() +
  facet_wrap(~ Stars, scales = "free", nrow = 1) +
  ylab("top 10 most frequent stems (by stars)") +
  theme(legend.position="none") 
# I want to modify the code above so that it displays
# the information in top5_words_star

# reconvene at 2pm 

# after break: 
# - bigrams
# - word clouds
# - sentiment analysis

###########
# bigrams #
###########

bigrams = Roomba %>% unnest_tokens(word, Review, token = "ngrams", n = 2)

# top 10 most frequent bigrams


# get rid of stop_words
both_tok = bigrams %>%
  separate(word, into = c("word1", "word2"), sep = " ") %>%
  filter( !(word1 %in% stop_words$word) & !(word2 %in% stop_words$word) ) %>%
  unite(word, c(word1, word2), sep = " ")



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


