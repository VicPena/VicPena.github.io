###############
# animal farm #
###############

# read in the data
# from http://vicpena.github.io/workshops/2021/animal_farm.csv
library(readr)
animal_farm <- read_csv("http://vicpena.github.io/workshops/2021/animal_farm.csv")
View(animal_farm)

# corpus: book
# documents: chapters
# tf_idf (tf itself) to find terms that seem 
# "highly specific" to the chapters
# as well as try to find similarities between chapters

# tokenize into words
library(tidytext)
glimpse(animal_farm)
animal_tok = animal_farm %>% unnest_tokens(word, text_column)
animal_tok

# get rid of stop_words (uninformative words)
animal_tok = animal_tok %>% anti_join(stop_words)

# stem
library(SnowballC)
animal_tok = animal_tok %>% mutate(word = wordStem(word))

# top 10 word_stems by chapter
animal_tok %>% group_by(chapter) %>% count(word) %>% slice_max(n, n = 10) %>% View


# could do all we did on Monday with this dataset
# (try it out if you want some extra practice)
# however, today we'll focus on finding ways to quantify
# how similar / different the chapters are

# find "special words" by chapter w/ tf-idf
# first, count word frequencies by chapter
# then, append tf_idf

# use function bind_tf_idf to compute the tf idfs
# tf-idf(word, document)
# if I have 10 chapters
# I have 10 different tf-idfs for each word that I can imagine
animal_tfidf = animal_tok %>% count(chapter, word) %>% bind_tf_idf(word, chapter, n)

# the protagonist of animal farm is napoleon
# tf: (# times a word appears in a document)/(# of words in a document)
animal_tfidf %>% filter(word == "napoleon") %>% arrange(tf)

# plot 3 words with highest tf_idf by chapter

# start out with a table that has top 3 words by chapter
# idf(word) = log(# chapters/ (# of chapters that contain the word))
barp2 = animal_tfidf %>% group_by(chapter) %>% slice_max(tf_idf, n = 3)
ggplot(barp2) +
  aes(x = reorder_within(word, tf_idf, chapter), y = tf_idf, fill = chapter) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() + 
  facet_wrap(~chapter, scales = "free") +
  coord_flip()

barp2

# convert chapter into factor
barp2 = barp2 %>% mutate(chapter = as.factor(chapter))
barp2
# reorder levels

# create a vector which contains the 
# order in which I want the levels
chaps = levels(barp2$chapter)
chaps[2:9] = chaps[3:10]
chaps[10] = "Chapter 10"

# change the order in which the levels appear
barp2 = barp2 %>% mutate(chapter = factor(chapter, levels = chaps))

# then, do barplot
ggplot(barp2) +
  aes(x = reorder_within(word, tf_idf, chapter), y = tf_idf, fill = chapter) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() + 
  facet_wrap(~chapter, scales = "free", ncol = 2) +
  coord_flip()


# can do tf_idf for bigrams as well

  
##########################################
# using stat / ML methods with text data #
##########################################

# find overall top 20 most freq stemmed words in the dataset
top20 = animal_tok %>% count(word) %>% slice_max(n, n = 20) %>% select(word)

top20
# keep only words in top20
# inner_join merges databases
tab20 = animal_tfidf %>% inner_join(top20, by = "word") %>% select(-n, -idf, -tf_idf)
View(tab20)
# as of right now, I have the data in long format
# pivot to wide format, keep tf
wide = tab20 %>% pivot_wider(names_from = word, values_from = tf, values_fill = 0)
# install.packages("data.table")
library(data.table)
wide2 = wide %>% select(-chapter)
wide2 = transpose(wide2)
rownames(wide2) = colnames(wide)[-1]
colnames(wide2) = wide$chapter
wide2

# apply pca 
PCA = princomp(wide2, cor = TRUE) # tells R to normalize data
# find importance of components
summary(PCA)
# plot importance
plot(PCA, type = "lines")

# autoplot in ggfortify
# install.packages("ggfortify")
library(ggfortify)
autoplot(PCA, label = TRUE, loadings = TRUE, loadings.label = TRUE)

# clustering on words
# can also do k-means
kmeans(wide2, centers = 6, nstart = 30)


# clustering on chapters
kmeans(t(wide2), centers = 5, nstart = 30)

# install.packages("factoextra")
# install.packages("NbClust")
library(factoextra)
library(NbClust)

# plotting within sum of squares
fviz_nbclust(wide2, kmeans, method = "wss")

###################
# Back at bigrams #
###################

# read in the data
library(tidyverse)
library(tidytext)
library(readr)
animal_farm = read_csv("http://vicpena.github.io/workshops/2021/animal_farm.csv")

# convert chapter into factor
animal_farm = animal_farm %>% mutate(chapter = as.factor(chapter))
animal_farm
# reorder levels
chaps = levels(animal_farm$chapter)
chaps[2:9] = chaps[3:10]
chaps[10] = "Chapter 10"
chaps
animal_farm = animal_farm %>% mutate(chapter = factor(chapter, levels = chaps))
levels(animal_farm$chapter)

# since I had a hard time with them on Wed, let's
# cover bigrams again...

animal_tok = animal_farm %>% unnest_tokens(word, text_column, token = "ngrams", n = 2)
animal_tok %>% count(word) %>% slice_max(n, n = 10)
# problem with this: the most frequent bigrams are noninformative
# "of the" "in the" "and the" don't really tell me anything interesting
stop_words

# bigrams: combinations of 2 words

# 2 approaches to getting rid of stop words with bigrams:
# - work only with bigrams where BOTH words are NOT stop words
# something like: the animals would not be included because "the" is a stop word
# - work only with bigrams where AT LEAST ONE word is NOT a stop word
# "the animals" would be included because animals is not a stop word


# - work only with bigrams where BOTH words are NOT stop words
# process:
# 1. get bigrams with unnest_tokens: we've done it
# 2. split up the bigrams into 2 words with separate
animal_sep = animal_tok %>% separate(word, into = c("word1", "word2"), sep = " ")
# 3. filter out stop words
# I want a logical condition that checks
# whether both words are not stop_words
animal_sep$word1 %in% stop_words$word # TRUE if stop_word
animal_sep$word2 %in% stop_words$word # TRUE if stop_word

# want a logical condition which is TRUE
# if both word1 and word2 are NOT stop_words
!(animal_sep$word1 %in% stop_words$word) # TRUE if NOT stop_word
!(animal_sep$word2 %in% stop_words$word) # TRUE if NOT stop_word
# need to use the AND operator (in R encoded as &) to combine the logical conditions

# output: logical condition where TRUE if both are NOT stop_words and FALSE otherwise
animal_filtered = animal_sep %>% filter(!(word1 %in% stop_words$word)&!(word2 %in% stop_words$word)) 

# 4. paste bigrams back together with unite
both_tok = animal_filtered %>% unite(word, c(word1, word2), sep = " ")
both_tok %>% count(word) %>% slice_max(n, n = 10)

# - work only with bigrams where AT LEAST ONE word is NOT a stop word
# same process, different logical condition

# 1. get bigrams with unnest_tokens: we've done it
# 2. split up the bigrams into 2 words with separate
animal_sep = animal_tok %>% separate(word, into = c("word1", "word2"), sep = " ")
# 3. filter out stop words
# I want a logical condition that checks
# whether both words are not stop_words
animal_sep$word1 %in% stop_words$word # TRUE if word1 is a stop_word
animal_sep$word2 %in% stop_words$word # TRUE if word2 is a stop_word

# want a logical condition which is TRUE
# if either word1 or word2 are NOT stopwords
# it is enough to have one of word1 or word2 not being stopwords

!(animal_sep$word1 %in% stop_words$word) # TRUE if word1 is NOT stop_word
!(animal_sep$word2 %in% stop_words$word) # TRUE if word2 is NOT stop_word
# need to use the OR operator (in R encoded as |) to combine the logical conditions
!(animal_sep$word1 %in% stop_words$word) |  !(animal_sep$word2 %in% stop_words$word) 
# output: logical condition where TRUE if one of the words is not a stop_word
animal_filtered = animal_sep %>% filter(!(animal_sep$word1 %in% stop_words$word) |!(animal_sep$word2 %in% stop_words$word) ) 

# 4. paste bigrams back together with unite
one_tok = animal_filtered %>% unite(word, c(word1, word2), sep = " ")
one_tok %>% count(word) %>% slice_max(n, n = 10)


# can do usual plots of word frequencies, etc.
# we can also compute tf_idf
# tf-idf: allows me to find words that are highly specific to certain documents in a corpus
# corpus: book
# documents: chapters
# tf-idf: allows me to find words that appear "weirdly often" in certain chapters

# create a table with bigrams by chapter
# add in the tf-idfs using the bind_tf_idf function
tfidf_tok = one_tok %>% group_by(chapter) %>% count(word) %>% bind_tf_idf(word, chapter, n)

# plot top 3 bigrams according to tf_idf by chapter

# find top 3 words according to tf_idf by chapter
barp = tfidf_tok %>% slice_max(tf_idf, n = 3)

# then, plot
ggplot(barp) +
  aes(x = reorder_within(word, tf_idf, chapter), y = tf_idf, fill = chapter) +
    geom_col(show.legend = FALSE) +
      scale_x_reordered() +
        facet_wrap(~ chapter, scales = "free", ncol = 2) +
          coord_flip()


#################
# network plots #
#################
library(ggraph)
library(igraph)
library(tidygraph)
# 1st step, separate bigrams in 2 cols,
# count word counts
# find top 20 (so graph is manageable)
# finally, save result as "graph" object
tab_graph = one_tok  %>%  
  separate(word, into = c("from", "to"), sep = " ")  %>% 
  count(from, to)  %>%
  slice_max(n, n = 20) %>%
  as_tbl_graph() # needed for creating the plots

# plot network using ggraph
# network is composed of: nodes and edges
ggraph(tab_graph, layout = "fr") +
  geom_edge_link(aes(width = n, alpha = n)) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1)


# do it separately by chapter??
# in principle, we could use the facet_node command
# however, I can't get it to work so that 
# it gets rid of zero freq links by chapter

# finally, save result as "graph" object
tab_graph = one_tok  %>%  
  separate(word, into = c("from", "to"), sep = " ")  %>% 
  group_by(chapter) %>%
  count(from, to)  %>%
  slice_max(n, n = 5) %>%
  as_tbl_graph() # needed for creating the plots

# this is not great
ggraph(tab_graph, layout = "fr") +
  geom_edge_link(aes(width = n, alpha = n)) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  facet_edges(~ chapter, scales = "free")

# create separate plots by chapter since facet_edges is not working well
plot_table = one_tok  %>%  
  separate(word, into = c("from", "to"), sep = " ")  %>% 
  group_by(chapter) %>%
  count(from, to)  %>%
  slice_max(n, n = 5) 

# plot for the first chapter
chap1_graph = plot_table %>% filter(chapter == "Chapter 1") %>%
  ungroup %>%
  select(from, to, n) %>%
  as_tbl_graph()

ggraph(chap1_graph, layout = "fr") +
  geom_edge_link(aes(width = n, alpha = n)) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)



# so... we can write a loop that does the plots individually
# far from optimal, but it'll be better than 
# the previous plot
chap_plot = one_tok  %>%  
  separate(word, into = c("from", "to"), sep = " ")  %>% 
  group_by(chapter) %>%
  count(from, to)  %>%
  slice_max(n, n = 5)
chap_plot
plots = list()
for (i in 1:10) {
  # filter counts for chapter i 
  data_plot = chap_plot %>% filter(chapter == paste("Chapter", i))
  # create the plot for chapter i, then save it into plots list
  plots[[i]] = ggraph(data_plot, layout = "fr") +
    geom_edge_link(aes(width = n, alpha = n)) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    ggtitle(paste("Chapter", i))
}

# grid.arrange allows us to plot a bunch of ggplots together
# install.packages("gridExtra")
library(gridExtra)
grid.arrange(grobs = plots, ncol = 2)

# far from perfect, but it's a good start

