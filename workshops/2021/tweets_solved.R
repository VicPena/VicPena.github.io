# read in tweets
library(readr)
tweets <- read_csv("http://vicpena.github.io/workshops/2021/tweets.csv")

# take a look at dataset
glimpse(tweets)

# count number of tweets by verified / unverified users
library(tidyverse)
tweets %>% count(usr_verified)

# find average follower counts for verified / unverified users
tweets %>% group_by(usr_verified) %>% summarize(avgFollow = mean(usr_followers_count))

# count number of tweets classified as complaints / not complaints
tweets %>% count(complaint_label)

# plot results
tweets %>% count(complaint_label) %>%
  ggplot() +
  aes(x = complaint_label, y = n) +
  geom_col()

# tokenize the tweets
tok = tweets %>% unnest_tokens(word, tweet_text)

# top 10 word frequencies
tok %>% count(word) %>%
  slice_max(n, n = 10)

# filter out stop_words
tok = tok %>% anti_join(stop_words)

# repeat table w/ top 10 word freq
tok %>% count(word) %>%
  slice_max(n, n = 10)

# filter out some extra "words'
tok = tok %>% filter(!(word %in% c("t.co", "http")))

tok %>% count(word) %>%
  slice_max(n, n = 10)

# plot top 10 most frequent words
tok %>% count(word) %>%
  slice_max(n, n = 10) %>%
  ggplot() +
  aes(x = fct_reorder(word, n), y  = n) +
  geom_col() +
  coord_flip()

# plot top 10 most frequent words by complaint label
tok %>% group_by(complaint_label) %>%
  count(word) %>%
  slice_max(n, n = 10) %>%
  ggplot() +
  aes(x = reorder_within(word, n, complaint_label), y  = n, fill = complaint_label) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(complaint_label ~ . , scales = "free") +
  coord_flip() 


# do the same, but for verified vs unverified 
tok %>% group_by(usr_verified) %>%
  count(word) %>%
  slice_max(n, n = 10) %>%
  ggplot() +
  aes(x = reorder_within(word, n, usr_verified), y  = n, fill = usr_verified) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(usr_verified ~ . , scales = "free") +
  coord_flip() 

##############
# wordclouds #
##############
library(wordcloud)

# find word clouds for complaints / noncomplaints
complaints = tok %>% filter(complaint_label == "Complaint")
noncomplaints = tok %>% filter(complaint_label == "Non-Complaint")

comp_table = complaints %>% count(word)
comp_table
wordcloud(words = comp_table$word,
          freq = comp_table$n,
          max.words = 30)

noncomp_table = noncomplaints %>% count(word)
wordcloud(words = noncomp_table$word,
          freq = noncomp_table$n,
          max.words = 30)


######################
# Sentiment analysis #
######################

# merge tokenized data with loughran dictionary
sent = tok %>% inner_join(get_sentiments("loughran"))

# tabulate sentiments
sent %>% count(sentiment)

# plot sentiments
sent %>% count(sentiment) %>%
  ggplot() +
  aes(x = fct_reorder(sentiment, n), y = n) +
  geom_col() +
  coord_flip()

# tabulate sentiments for complaints / noncomplaints 
sent %>% group_by(complaint_label) %>% count(sentiment)

# plot sentiments for complaints / noncomplaints
sent %>% group_by(complaint_label) %>% count(sentiment) %>%
  ggplot() +
  aes(x = reorder_within(sentiment, n, complaint_label), y = n, fill = complaint_label) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(complaint_label ~ ., scales = "free") +
  coord_flip()

# plot sentiments for verified / unverified users
sent %>% group_by(usr_verified) %>% count(sentiment) %>%
  ggplot() +
  aes(x = reorder_within(sentiment, n, usr_verified), y = n, fill = usr_verified) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(usr_verified ~ ., scales = "free") +
  coord_flip()


# tabulate top 3 words by sentiment
sent %>% group_by(sentiment) %>% count(word) %>% slice_max(n, n = 3)
# plot top 3 words by sentiment
sent %>% group_by(sentiment) %>% count(word) %>% slice_max(n, n = 3) %>%
  ggplot() +
  aes(x = reorder_within(word, n, sentiment), y = n, fill = sentiment) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(sentiment ~ ., scales = "free") +
  coord_flip()


# plot top 3 words by sentiment for complaints / noncomplaints separately
sent %>% group_by(sentiment, complaint_label) %>% count(word) %>% slice_max(n, n = 3) %>%
  ggplot() +
  aes(x = reorder_within(word, n, list(sentiment, complaint_label)), y = n, fill = sentiment) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(sentiment ~ complaint_label, scales = "free") +
  coord_flip()


##################
# Topic modeling #
##################

# create dtm
dtm_tweets = tok %>% count(word, tweet_id) %>% cast_dtm(tweet_id, word, n)


# run topic model for different number of topics
# select "best" in terms of perplexity
maxk = 10
perp_vector = numeric(maxk)
for (k in 2:maxk) {
  lda_out = LDA(dtm_tweets, k = k, methods = "Gibbs")
  perp_vector[k] = perplexity(lda_out)
}
qplot(x = 2:maxk, y = perp_vector[-1])

bestk = 5
best_lda = LDA(dtm_tweets, k = bestk, methods = "Gibbs")
lda_topics = best_lda %>% tidy(matrix = "beta") 


# plot with top 10 words by topic
lda_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ggplot() +
  aes(x = reorder_within(term, beta, topic), y = beta, fill = as.factor(topic)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(topic ~ ., scales = "free", ncol = bestk) +
  scale_x_reordered() +
  coord_flip()

# get rid of more stopwords?

