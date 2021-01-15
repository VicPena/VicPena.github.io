#########################
# Unsupervised learning #
#########################

#######
# PCA #
#######

# Read in https://koalaverse.github.io/homlr/data/my_basket.csv
# Source: Chapter 17 of Hands-on Machine Learning with R, by Bradley Boehmke


# This data set identifies items and quantities
# purchased for 2,000 transactions from a grocery store.
# The objective is to identify common groupings of items purchased together.

# There are 42 variables, so there are 
choose(42, 2)
# pairs of variables 
# would be really boring to stare at those all day

library(tidyverse)

# fit PCA

# find importance of components

# plot importance


# autoplot in ggfortify
# install.packages("ggfortify")
library(ggfortify)

# plot only variables
# install.packages("ggrepel")
library(ggrepel)
# put loadings into a data.frame
# otherwise, functions in the tidyverse won't work

###########
# k-means #
###########

# fit k-means to loadings of first 2 components 

# plot clustering assignment


# Choosing value of k?
# load required packages
install.packages("factoextra")
install.packages("NbClust")
library(factoextra)
library(NbClust)

# plotting within sum of squares
