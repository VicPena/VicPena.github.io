# Amazon reviews of some Roombas 
# Source: Introduction to text analysis in R,
#  by Dotson [datacamp course]

# Link: http://vicpena.github.io/workshops/2021/Roomba.csv

# read in the data
library(readr)
Roomba <- read_csv("http://vicpena.github.io/workshops/2021/Roomba.csv")
View(Roomba)

# take a quick look at the data
# install.packages("tidyverse")
library(tidyverse)
glimpse(Roomba)

# how many products are there and how many reviews 
# per product?
# %>% : pipe operator
# count: allows me to create tables
Roomba %>% count(Product)
Roomba = Roomba %>% mutate(id = 1:nrow(Roomba))

# average stars grouped by product?
# group_by and summarize (tidyverse)
Roomba %>% group_by(Product) %>% summarize(avgStars = mean(Stars),
                                           sdStars = sd(Stars))

# transform data so that each row is a different word
# (i.e. tokenize) using tidytext
# install.packages("tidytext")
library(tidytext)
# function unnest_tokens to convert reviews into 
# "words"
# in text mining: token sort of means "object of interest"
# in our analysis, for now, it's going to be words
# but in other cases, it could be "pairs of words" or
# it could be sentences
tok = Roomba %>% unnest_tokens(word, Review)

# frequency table of words
tok %>% count(word)

# find top 10 most frequent words
tok %>% count(word) %>% slice_max(n, n = 10)
# nothing wrong with this
#  however, this is completely useless!!

# we want to get rid of "uninformative words"
stop_words # stop_words (which is in library(tidytext)) has a list of uninformative words
# get rid of "stop words"
# simply get rid of terms in tok that are 
# on the list of stop_words 
View(stop_words)
nrow(stop_words)

# anti_join command: merge 2 databases and only
# keep those rows that don't have a match
# merging my tokens with stop_words
# keeping only those tokens that don't have a match
# in the stop_words database

# get rid of stop_words
tok = tok %>% anti_join(stop_words)
tok %>% count(word) %>% slice_max(n, n = 25) %>% View

# if I wanted to get rid of "roomba" and "vacuum"
# because I think they're not informative
# filter by logical condition that keeps out "roomba" and "vacuum"
# not word in the vector "roomba", "vacuum"
tok = tok %>% filter( !(word %in% c("roomba", "vacuum")) )
tok %>% count(word) %>% slice_max(n, n = 25) %>% View


# find freq tables by product
# find top 5 most freq words by product
tok %>% group_by(Product) %>% count(word) %>% slice_max(n, n = 5)

# add relative frequencies (i.e. proportions)
# mutate: creates new variables from old
tok %>%
  group_by(Product) %>%
  count(word) %>% 
  mutate(prop = n/sum(n))  %>%
  slice_max(n, n = 5)

# Yes! and we will use regular expressions
# regular expressions: commands that allow us to search through text
# efficiently by identifying patterns


#############################
# Plotting word frequencies #
#############################

# More: http://www.cookbook-r.com/Graphs/

# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid


# Barplot of word frequency, top 10 words only
# I need a dataset that has that information first
barp = tok %>% count(word) %>% slice_max(n, n = 10)
# now I can use ggplot
ggplot(barp) +
  aes(x = word, y = n) +
  geom_col() # bar plots (geom_col: stands for column)

# order bars by frequency
ggplot(barp) +
  aes(x = fct_reorder(word, n), y = n) +
  geom_col(fill = "pink") + # bar plots (geom_col: stands for column)
  xlab("top 10 most frequent terms") +
  ggtitle("Word frequency of top 10 most freq. terms in Roomba reviews") +
  coord_flip()



# Barplot of word frequency by product, top 10 words only
barp2 = tok %>% group_by(Product) %>% count(word_stem) %>% slice_max(n, n = 10)
barp2


# ggplot(<data>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid
ggplot(barp2) +
  aes(x = reorder_within(word_stem, n, Product), y = n, fill = Product, label = n) +
  geom_col(show.legend = FALSE) +
  geom_text() +
  scale_x_reordered() +
  facet_wrap( Product ~ . , scales = "free") +
  coord_flip() +
  xlab("Top 10 words") 


##############
# wordclouds #
##############

# $ syntax in R allows me to look into variables within data.frames
# tok$word: word variable within tok dataset

# install.packages("wordcloud")
library(wordcloud)

# input for wordcloud
# a frequency table

# first I will need a table with word frequencies
tab = tok %>% count(word)
tab
# important to remember that 
# the input of wordcloud is a freq table with word counts
wordcloud(words = tab$word,
          freq = tab$n, 
          colors = "dodgerblue",
          max.words = 50)

# change colors
# colors in R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# we can do separate word clouds by product
glimpse(tok)
# separate the data into 2 disjoint sets
# and then repeat the process

# create a subset w Roomba 650 only
# filter command
room650 = tok %>% filter(Product == "iRobot Roomba 650 for Pets")
room880 = tok %>% filter(Product != "iRobot Roomba 650 for Pets")

# start with freq table
tab650 = room650 %>% count(word)
wordcloud(words = tab650$word,
          freq = tab650$n, 
          colors = "dodgerblue",
          max.words = 50)

tab880 = room880 %>% count(word)
wordcloud(words = tab880$word,
          freq = tab880$n, 
          colors = "hotpink1",
          max.words = 50)


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
barp3 = tok %>% 
  inner_join(get_sentiments("nrc")) %>% 
  count(sentiment) %>%
  mutate(perc = 100*n/sum(n))

# plot sentiments
ggplot(barp3) +
  aes(x = fct_reorder(sentiment, n), y = perc, label = paste(round(perc, 2),"%")) +
  geom_col(fill = "pink") + # bar plots (geom_col: stands for column)
  geom_text() + 
  xlab("sentiment") +
  ggtitle("Sentiment analysis for Roomba reviews (Dict: nrc)") +
  coord_flip()



# plot top 10 most frequent positive and negative words, using bing

# create a dataset that is merged with the bing dictionary
tok_bing = tok %>% inner_join(get_sentiments("bing"))
# table which contains the top 10 words by sentiments
barp_sent = tok_bing %>% group_by(sentiment) %>% count(word) %>% slice_max(n, n = 10)
barp_sent
ggplot(barp_sent) +
  aes(x = reorder_within(word, n, sentiment), y = n, fill = sentiment, label = n) +
  geom_col(show.legend = FALSE) +
  geom_text() +
  scale_x_reordered() + 
  facet_wrap(  sentiment  ~ . , scales = "free" ) +
  coord_flip()

# do the same, but break down further by product
barp_sent2 = tok_bing %>% 
  group_by(sentiment, Product) %>% 
  count(word) %>% 
  slice_max(n, n = 10) %>%
  mutate(perc = 100*n/sum(n))

ggplot(barp_sent2) +
  aes(x = reorder_within(word, n, list(sentiment, Product)), y = perc, fill = sentiment, label = round(perc,2)) +
  geom_col(show.legend = FALSE) +
  geom_text() +
  scale_x_reordered() + 
  facet_wrap(  sentiment  ~ Product , scales = "free" ) +
  coord_flip()

# find words that appear in top 10 
# in only one of the products
barp_sent2 %>% filter(sentiment == "negative")
# get out a database which contains
# those words that appear for one roomba
# but not the other
unq = barp_sent2 %>% ungroup() %>% count(word) %>% 
  filter(n == 1) %>% 
  select(word)

View(barp_sent2)
barp_sent2 %>% inner_join(unq)


##################
# Topic modeling #
##################

# add variable to Roomba identifying the reviews

# create dtm
# install.packages("tm")
# install.packages("NLP")
library(tm)

# find interesting groups of words
# given a set of "documents"
# set of documents are the reviews

# filter out stop_words
tok = Roomba %>% unnest_tokens(word, Review)
tok = tok %>% anti_join(stop_words)
tok = tok %>% filter( !(word %in% c("roomba", "vacuum", "cleaning", "clean", "irobot")) ) # words I don't want to keep

# how many times each word appears in each review
dtm_review = tok %>% count(word, id) %>% cast_dtm(id, word, n)
dtm_review
# id: review
# word: words in the review
# n: counting how many times each word appears


# run topic model
# install.packages("topicmodels")
library(topicmodels)
# LDA a type of topic model
# Latent Dirichlet Allocation
# There are extensions that have 
# time-series
# Your topics change over time 
# dynamic LDA
# Hierarchical LDA

# Gibbs' sampler: specifying a method for estimating
# LDA is a Bayesian model
# it has associated with it a posterior distribution 
# over all the unknowns
# sample from posterior distribution using 
# a Markov Chain
lda_output = LDA(dtm_review, k = 2, methods = "Gibbs")

lda_topics = lda_output %>% tidy(matrix = "beta") # betas are word probabilities by topic

# top 5 words by topic
barplot_lda = lda_topics %>% group_by(topic) %>% slice_max(beta, n = 10) 
# Pr(word given a topic) = Pr(word | topic)
lda_topics %>% group_by(topic) %>% summarize(sum(beta))

# create a plot that has 
# betas, terms (words), topics
ggplot(barplot_lda) +
  aes(x = reorder_within(term, beta, topic), y = beta, fill = topic) +
  geom_col(show.legend =  FALSE) +
  facet_wrap(topic ~ . , scales = "free", nrow = 5) +
  scale_x_reordered() + 
  coord_flip()

# k is number of topics


# how to select k?
# one way: using "perplexity" (the lower the better)
# perplexity is a function of loglikelihood
# the higher the loglikelihood, the lower the perplexity

# fit the model for different values of k 
# (k is the number of topics / clusters)
# and then we'll identify a value of k 
# after which adding new clusters doesn't
# seem to "help much"

# for loop to run this model for different values of k
maxK = 10
perp = numeric(maxK)
for (k in 2:maxK) {
  lda_output = LDA(dtm_review, k = k, methods = "Gibbs")
  perp[k] = perplexity(lda_output)
}
qplot(x = 2:maxK, y = perp[-1])

############
# stemming #
############

# install.packages("SnowballC")
library(SnowballC)
tok = tok %>% mutate(word_stem = wordStem(word))


# 1st create freq table, top 10 stemmed words
tok %>% count(word) %>% slice_max(n, n = 10)
tok %>% count(word_stem) %>% slice_max(n, n = 10)

# after stemming we could potentially re run all of our analyses

library(tm)

# find interesting groups of words
# given a set of "documents"
# set of documents are the reviews

# how many times each word appears in each review
dtm_review = tok %>% count(word_stem, id) %>% cast_dtm(id, word_stem, n)
dtm_review
# id: review
# word: words in the review
# n: counting how many times each word appears
lda_output = LDA(dtm_review, k = 2, methods = "Gibbs")
lda_topics = lda_output %>% tidy(matrix = "beta") # betas are word probabilities by topic

# top 5 words by topic
barplot_lda = lda_topics %>% group_by(topic) %>% slice_max(beta, n = 10) 
# Pr(word given a topic) = Pr(word | topic)
lda_topics %>% group_by(topic) %>% summarize(sum(beta))

# create a plot that has 
# betas, terms (words), topics
ggplot(barplot_lda) +
  aes(x = reorder_within(term, beta, topic), y = beta, fill = topic) +
  geom_col(show.legend =  FALSE) +
  facet_wrap(topic ~ . , scales = "free", nrow = 5) +
  scale_x_reordered() + 
  coord_flip()



#######################
# tokenize by n-grams #
#######################
# read in the data
library(readr)
library(tidyverse)
library(tidytext)
Roomba <- read_csv("http://vicpena.github.io/workshops/2021/Roomba.csv")

# find bigrams
# top 10 2-grams


# getting rid of stop_words
# how?
# well, we have different options...
# we want to get rid of 2-grams where
# both words are stop_words for sure


# strategy: separate the 2-grams into 2 words
# filter out rows where both words are stop_words
# then, paste 2-grams back together


# create table of 2-grams after filtering out stop_words

# another option is getting rid of 2-grams where there is 1 or 2
# stop_words

# top 10 most common bigrams

# let's go with the option where there may be one stop_word
# before that, though, let's stem the words 


# repeat top 10 after stemming

# plot top 10 2-grams by product

# 1st, create table with w/ top 10 most freq. bigrams by product
# add in relative freq. (i.e. proportions)

# now, plot 

# sentiment analysis?

# get bigrams that start by "not"


# then, run sentiment analysis on second word

# get top 5 words by sentiment



# convert sentiment to factor
# change levels of sentiment to  "not + negative" and "not + positive"

# top 5 words by topic


# break down further by product
# 1st, create table by product & sentiment, run sentiment analysis

# get top 3 by product and sentiment


# convert to factor + edit levels
# change levels of sentiment to  "not + negative" and "not + positive"


# could do the same with "no", "without" "never", etc. 

#################
# network plots #
#################

# here, let's work with the bigram data 
# where both words are NOT stop_words
# don't unite the columns and don't forget to stem


# install.packages("tidygraph")
# install.packages("ggraph")
library(tidygraph)
library(ggraph)

# bigram counts, keep top 20

# alternatively, can use library(snahelper)
# install.packages("snahelper")
# install.package("igraph)
library(snahelper)
library(igraph)
# highlight graph object, select snahelper addin


# top 10 bigram graph plot by product

# alternatively, can do 2 separate plots
# can use snahelper
