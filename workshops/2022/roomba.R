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

# the apartment is clean after this 
# the apartment is not clean after this

###########
# bigrams #
###########
# extract bigrams from text
bigrams = Roomba %>% unnest_tokens(word, Review, token = "ngrams", n = 2)

trigrams = Roomba %>% unnest_tokens(word, Review, token = "ngrams", n = 3)
trigrams %>% count(word) %>% slice_max(n, n = 10)


# top 10 most frequent bigrams
bigrams %>% count(word) %>% slice_max(n, n = 10)
# issue: it contains stop_words
# these are not very informative

# option 1: to remove the bigrams where
# both words are stop_words

# option 2: to remove the bigrams
# where there is a word that is a stop_word

# option 1 contains more bigrams than option 2
# but option might contain bigrams that are less informative

# the kitchen: this would be included in option 1
# but not in option 2

# here we are going to go with option 2
# so things like "the kitchen" would not be included



# get rid of stop_words
# this works as long as you have a dataset called bigrams
# and the column with the bigrams is called word
bigrams
both_tok = bigrams %>%
  separate(word, into = c("word1", "word2"), sep = " ") %>%
  filter( !(word1 %in% c(stop_words$word, "roomba", "650", "880")) & 
          !( word2 %in% c(stop_words$word, "roomba", "650", "880")) ) %>%
  unite(word, c(word1, word2), sep = " ")


tri_tok = trigrams  %>%
  separate(word, into = c("word1", "word2", "word3"), sep = " ") %>%
  filter( !(word1 %in% c(stop_words$word, "roomba", "650", "880")) &
            !( word2 %in% c(stop_words$word, "roomba", "650", "880")) &
            !( word3 %in% c(stop_words$word, "roomba", "650", "880"))) %>%
  unite(word, c(word1, word2, word3), sep = " ")
tri_tok %>% count(word) %>% slice_max(n, n = 10)

# email: victor.pena@baruch.cuny.edu

# filter: only keeps those bigrams where the first word is not on the 
# list of stop_words and the second word is not on the list of stop_words
  
both_tok %>% count(word) %>% slice_max(n, n = 10)


top5_words_star = both_tok %>% 
                    group_by(Stars) %>%
                        count(word) %>% 
                            slice_max(n, n = 5)

ggplot(top5_words_star) +
  aes(y = reorder_within(word, n, Stars), x = n, fill = Stars) +
  geom_col() +
  scale_y_reordered() +
  facet_wrap(~ Stars, scales = "free", nrow = 1) +
  ylab("top 10 most frequent stems (by stars)") +
  theme(legend.position="none") 


# find the top 5 most frequent 
# bigrams by Product 
# and then find the plot with the 5 
# most frequent bigrams
top5_words_prod = both_tok %>%
  group_by(Product) %>%
  count(word) %>%
  slice_max(n=5,n)

top5_words_prod

ggplot(top5_words_prod) +
  aes(y = reorder_within(word, n, Product), x = n, fill = Product) +
  geom_col() +
  scale_y_reordered() +
  facet_wrap(~ Product, scales = "free", nrow = 1) +
  ylab("top 10 most frequent stems (by product)") +
  theme(legend.position="none")



##############
# wordclouds #
##############


# install.packages("wordcloud")
library(wordcloud)

# input for wordcloud
# a frequency table
word_count = tok %>% count(word)

# first I will need a table with word frequencies

# important to remember that 
# the input of wordcloud is a freq table with word counts
wordcloud(word = word_count$word, 
          freq = word_count$n,
          max.words = 50,
          color = "darkolivegreen3")

# change colors
# colors in R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# split the data using filters
# and then running the wordclouds

# I want two create two word clouds
# one for Roomba 650 another
# for Roomba 880
tok650 = tok %>% filter(Product == "iRobot Roomba 650 for Pets")
tok880 = tok %>% filter(Product == "iRobot Roomba 880 for Pets and Allergies")

# exercise: adapt the code below 
# to get word clouds with top 50 words 
# for 650 and 880 separately 
# with colors that are not the one that I chose
wordcloud(word = word_count$word, 
          freq = word_count$n,
          max.words = 50,
          color = "darkolivegreen3")
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# table for tok650
word_count_650 = tok650 %>% count(word)
# word cloud
wordcloud(word = word_count_650$word, 
          freq = word_count_650$n,
          max.words = 50,
          color = "red")

# table for tok880
word_count_880 = tok880 %>% count(word)
# word cloud 
wordcloud(word = word_count_880$word, 
          freq = word_count_880$n,
          max.words = 50,
          color = "darkviolet")


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
get_sentiments("afinn") %>% filter(value == 4)

# loughran: has more sentiments than just + and - but... it's not ordinal
get_sentiments("loughran") %>% view
# nrc
get_sentiments("nrc") %>% count(sentiment)

get_sentiments("nrc") %>% view


# there is no accepted best dictionary
# and what you can do is to run analyses with 
# different dictionaries and see how robust 
# your conclusions are to the choice of dictionary

# most often the conclusions don't change much
# if you change the dictionary

# if it seems that a text is positive with one 
# dictionary it's going to seem positive with
# another one



# merge tokenized data with bing dictionary
# keeping only words that have a match in the dictionary
# (can use either inner_ or right_join)
# then, tabulate sentiment

# merging with the bing dictionary
bing_sent = tok %>% inner_join(get_sentiments("bing"))
nrc_sent = tok %>% inner_join(get_sentiments("nrc"))
# inner_join = merges data

get_sentiments("bing") %>% view
get_sentiments("nrc") %>% view
# this gets the tok data
# and only keeps those words that have an entry
# in the bing dictionary

# bing dictionary has a list of words with a 
# "positive" or "negative" sentiment attached to them
bing_sent

# we can count the number of occurrences 
# of positive and negative words by tabulating the 
# frequencies of the sentiment variable
bing_sent %>% count(sentiment) %>% mutate(perc = 100*n/sum(n))
nrc_sent %>% count(sentiment) %>% mutate(perc = 100*n/sum(n))
# 54% positive / 46% negative
# this table gets me the number of positive and negative 
# words in my roomba dataset

# get % of positive words by product
# use group_by
bing_sent %>% 
  group_by(Product) %>% 
  count(sentiment) %>% 
  mutate(perc = 100*n/sum(n))
# 55.3% positive for roomba 650
# 53.4% positive for roomba 880

# exercise: do the same as above
# but use Stars as the grouping variable
# and use bing_nrc dataset instead of 
# bing_sent
nrc_sent %>% 
  group_by(Stars) %>% 
  count(sentiment) %>% 
  mutate(perc = 100*n/sum(n)) 

bing_plot = bing_sent %>% 
  group_by(Stars) %>% 
  count(sentiment) %>% 
  mutate(perc = 100*n/sum(n)) 

ggplot(bing_plot) +
  aes(y = sentiment, x = perc, fill = sentiment) +
      geom_col() +
        facet_wrap(~ Stars, nrow = 5) +
         theme(legend.position="none") +
            xlim(0, 100)


# your sentiment analysis is as good
# as your dictionary is

# if you have a good list of words (dictionary) for your problem at 
# hand, then your analysis will be good
# however, if your list of words (dictionary) for your problem
# is not good, then your analysis will not be good


# plot top 10 most frequent positive and negative words,
# using bing

# the answer: use group_by sentiment
# and then do a count of words and 
# then do a slice_max
bing_sent %>% group_by(sentiment) %>%
                count(word) %>%
                    slice_max(n, n = 5)
# top 5 most frequent negative and positive words



# do the same, but break down further by product
bing_sent %>% group_by(Product, sentiment) %>%
  count(word) %>%
  slice_max(n, n = 5)


# I have prepared some exercises
# that cover the topics that we have 
# worked on for a new dataset



# find top 100 words for the roombas
# call output top

# find words that appear for one roomba but not the other
# values_fill = 0 changes NA to 0 in pivot_wider
top_wide = top %>% pivot_wider(names_from = Product, values_from = n) 
top_wide %>% filter(!complete.cases(top_wide))

# Today
# - stopwords in other languages
# - network plots
# - tf_idf
# - topic models
# - exercises 


################################
# stopwords in other languages #
################################

# install.packages("tm")
library(tm)
?stopwords
stopwords("spanish")


#################
# network plots #
#################

library(igraph)
# find top 20 bigrams and 
# separate(word, into = c("word1", "word2"))


# create graph_from_data_frame()


# create graph with bigrams 
library(ggraph)
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n)) +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)


##########
# tf_idf #
##########

# tf: term frequency
# idf: inverse document frequency
# tf idf = tf*idf

# find tf_idf by Product

# plot top 10 tf_idfs


# what's going on with lighthouses and otto?

# plot top 10 tfs


##################
# Topic modeling #
##################


# install.packages("tm")
# install.packages("NLP")
# install.packages("topicmodels")
library(tm)
library(topicmodels)

# dataset structured in 
# documents which have words

# topic models "discover" topics
# different topics have different 
# word probabilities
# for example, the probability
# that the word "cat" appears in 
# topic 1 might be 0.2 and in 
# topic 2 might be 0.1 

# topic models give us word probabilities
# given the topic (betas) as well as 
# probabilities of topics given the document (gammas)



# filter out stop_words


# count words by Product
# cast_dtm(Product, word, n)

# run topic model
# LDA(dtm, k = number of topics, methods = "Gibbs")

# Get betas with tidy(matrix = "beta") 
# Get gammas with tidy(matrix = "gamma")

# top 5 words by topic


# create a plot for betas

# create a plot for gammas




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
# http://qpleple.com/perplexity-to-evaluate-topic-models/
