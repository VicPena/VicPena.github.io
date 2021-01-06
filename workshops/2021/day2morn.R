#############################
# Exporting data and tables #
#############################

library(tidyverse)
data(mpg)

# Exporting a dataset into a text file

# you can set the working directory with Rstudio

# Exporting a dataset into a *.csv spreadsheet


# Same idea works with tables!

# Fancier exporting into Word documents
# http://www.sthda.com/english/wiki/add-a-table-into-a-word-document-using-r-software-and-reporters-package

#############################
# Dealing with missing data #
#############################

# missing data are marked with NA
x = c(1:5, NA)
x

# applying functions to vectors with missing data is tricky
# for example, let's take the mean of x

# arithmetic with NAs is NA


# load in airquality
data("airquality")
?airquality
summary(airquality)

# na.omit: keep complete cases only
# usually not recommended unless you have 
# a very good reason to drop the missing data

######################
# library(tidyverse) #
######################

install.packages("tidyverse")
library(tidyverse)



##########################
## Subsetting variables ##
##########################

data(iris)
# first second and fifth column of iris
# can also subset by telling R to exclude



# select creates subsets of variables
# for example, create a subset of iris with
# first, second, and fifth columns

# order matters: if you want to get variable 5 first in the new dataset


# we can use variable names,
# e.g. Sepal.Length, Sepal.Width, Species

# nb: don't have to type "iris$ " all the time, which is nice

# you can exclude variables too
# e.g. exclude Sepal.Length and Sepal.Width

######################################
# creating new variables with mutate #
######################################

# we can create new variables using "mutate"
# for example, we can create a new
# variable with the avg measurements on the 
# flowers 

#####################
## Subsetting rows ##
#####################

data(iris)

# first, 30th, and 50th rows of iris

# in practice, we rarely do this. we usually want to
# get subsets of data that satisfy some condition

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

# create subset with flowers of type "setosa" only

# setosas whose Sepal.Width is less than or equal to 4

# setosas or versicolor whose Sepal.length is greater than 5



##########################
# group_by and summarize #
##########################

library(gapminder)
data(gapminder)
?gapminder

# group_by + summarize:
# find separate summary statistics 
# for different categories

# average life expectancy by continent?

# average life expectancy by continent in 1952?

# average population by continent in 1997?

# how many countries in each continent had a GDP over $10k in 2007?

# find average life expectancy by continent in 1952 and 2007?


##################################
# count: tables in the tidyverse #
##################################
library(tidyverse)
data(mpg)

# table for manufacturer

# proportion table for manufacturer

# table for manufacturer by year

# proportion table for manufacturer by year


