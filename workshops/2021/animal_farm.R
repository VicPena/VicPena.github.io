###############
# animal farm #
###############

# read in the data
# from http://vicpena.github.io/workshops/2021/animal_farm.csv

# tokenize into words

# get rid of stop_words

# stem

# top 10 word_stems

# could do all we did on Monday with this dataset
# (try it out if you want some extra practice)
# however, today we'll focus on finding ways to quantify
# how similar / different the chapters are

# find "special words" by chapter w/ tf-idf
# first, count word frequencies by chapter
# then, append tf_idf

# plot 3 words with highest tf_idf by chapter

# first, find top 5 words by chapter


# convert chapter into factor

# reorder levels

# then, do barplot


# can do tf_idf for bigrams as well

  
##########################################
# using stat / ML methods with text data #
##########################################

# find overall top 50 most freq stemmed words in the dataset

# pivot to wide format, keep tf

# transpose data; careful with colnames, etc.

# apply pca 

# find importance of components

# plot importance


# autoplot in ggfortify
# install.packages("ggfortify")
library(ggfortify)
# "repel" text labels so that they're not all overlaid
# install.packages("ggrepel")
library(ggrepel)


# can also do k-means

# install.packages("factoextra")
# install.packages("NbClust")
library(factoextra)
library(NbClust)

# plotting within sum of squares

