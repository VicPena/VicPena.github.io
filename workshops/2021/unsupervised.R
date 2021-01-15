#########################
# Unsupervised learning #
#########################

#######
# PCA #
#######

# Read in https://koalaverse.github.io/homlr/data/my_basket.csv
# Source: Chapter 17 of Hands-on Machine Learning with R, by Bradley Boehmke
library(readr)
my_basket <- read_csv("https://koalaverse.github.io/homlr/data/my_basket.csv")

# This data set identifies items and quantities
# purchased for 2,000 transactions from a grocery store.
# The objective is to identify common groupings of items purchased together.

# There are 42 variables, so there are 
choose(42, 2)
# pairs of variables 
# would be really boring to stare at those all day

library(tidyverse)

# fit PCA
PCA = princomp(my_basket, cor = TRUE) # scale the data so that they're all on the same scale

# find importance of components
summary(PCA)

# plot importance
plot(PCA) # screeplot
# PCA + time series: dynamic factor models
plot(PCA, type = "lines")
propvar = PCA$sdev^2/sum(PCA$sdev^2)
plot(propvar, type = "l")
plot(cumsum(propvar), type = "l")

# autoplot in ggfortify
# install.packages("ggfortify")
library(ggfortify) 
autoplot(PCA, loadings = TRUE, loadings.label = TRUE) # biplot

# plot only variables
# install.packages("ggrepel")
library(ggrepel)
# put loadings into a data.frame
# otherwise, functions in the tidyverse won't work
loads  = as.data.frame(PCA$loadings[,1:2]) 
loads = loads %>% mutate(item = rownames(loads))
ggplot(loads) +
  aes(x = Comp.1, y = Comp.2, label = item) +
    geom_text_repel()

ggplot(loads) +
  aes(x = Comp.1, y = Comp.3, label = item) +
  geom_text_repel()



###########
# k-means #
###########

# fit k-means to loadings of first 2 components 
km = kmeans(loads, centers = 5, nstart = 25)
km
loads = loads %>% mutate(cluster = as.factor(km$cluster),
                 item = rownames(loads))

ggplot(loads) +
  aes(x = Comp.1, y = Comp.2, label = item, color = cluster) +
  geom_text_repel()

# plot clustering assignment


# Choosing value of k?
# load required packages
# install.packages("factoextra")
# install.packages("NbClust")
library(factoextra)
library(NbClust)

# plotting within sum of squares
fviz_nbclust(loads[,1:2], kmeans, method = "wss")

# re-run k-means with k = 4
# because that's what seems best using the elbow method
km = kmeans(loads[,1:2], centers = 4, nstart = 25)
km
loads = loads %>% mutate(cluster = as.factor(km$cluster),
                         item = rownames(loads))

ggplot(loads) +
  aes(x = Comp.1, y = Comp.2, label = item, color = cluster) +
  geom_text_repel()

#############
# USArrests #
#############

data("USArrests")
?USArrests
View(USArrests)

PCA = princomp(USArrests, cor = TRUE) # scale the data so that they're all on the same scale
summary(PCA)
plot(PCA, type = "lines")
propvar = PCA$sdev^2/sum(PCA$sdev^2)
plot(propvar, type = "l")
plot(cumsum(propvar), type = "l")

# biplot (in library(ggfortify))
autoplot(PCA, loadings = TRUE, labels = TRUE, loadings.label = TRUE)

# find the coordinates of the states 
# with respect to the principal components

scores = as.data.frame(PCA$scores[,1:2]) %>% mutate(state = rownames(PCA$scores))
ggplot(scores) +
  aes(x = Comp.1, y = Comp.2, label = state) +
    geom_text_repel()

km = kmeans(USArrests, centers = 4, nstarts = 25)
fviz_nbclust(USArrests, kmeans, method = "wss")

###########################
# hierarchical clustering #
###########################

# by default the function that implements 
# hierarchical clustering is going to cluster by rows

flipped = t(my_basket) # t stands for transpose

# 1st of all, compute the distances between the variables
distances = dist(flipped)
# how is R computing differnces between clusters?
# by default it's going to use complete linkage
# define distance between clusters 
# as worst possible case distance between variables
# in clusters
clust = hclust(distances, method = "centroid") 
plot(clust)
fviz_nbclust(flipped, hcut, method = "wss")
# it's hard to come up with a good value of clusters
# for this example
# let's go with, say, 5

tree_cut = cutree(clust, k = 6)
tree_cut
loads
