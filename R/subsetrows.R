#####################
## Subsetting rows ##
#####################

data(iris)

# first, 30th, and 50th rows of iris

# in practice, we rarely do this. we usually want to
# get subsets of data that satisfy some condition

# for example, if we want a subset with setosa, 
# we can
# 1. create a logical vector that is 
# TRUE if row is iris$Species is "setosa"

# 2. index by the logical vector

##
## Logical operators in R
##
# == equal to
# != not equal to
# > greater than
# < less than
# >= greater or equal to
# <=  less than or equal to

# Create a subset with
# observations with Sepal.Length > 5


# observations where Species is not setosa



## Combining logical conditions

## 
## and, or, not in R
##
# & and
# | or
# ! not
# %in% 

# not setosas whose Sepal.Width is less than or equal to 4

# setosas or versicolor whose Sepal.length is greater than 5




# Using the filter function in the tidyverse to do the same thing
# ----------------------------------------
library(tidyverse)

# setosas only

# versicolors whose Sepal.Width is less than 5

# versicolors whose Sepal.Width is between 4 and 5

# We can combine filter and select

# create a subset that only contains `setosas` and excludes `Species` 

