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
