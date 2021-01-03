
## ------- ##
## Factors ##
## ------- ##

# another way of working with categorical data

# defining factors
chr1 = c("dog", "cat", "cat", "dog")
fac1 = factor(c("dog","cat","cat","dog"))

# summary


# In the iris dataset, how many species of type setosa are there?

# levels: categories contained in factor

# read in hsb2 data
hsb2 = read.csv("http://vicpena.github.io/sta9750/spring19/hsb2.csv")
str(hsb2)
# str, summary, head

# levels of ses
levels(hsb2$ses)

# if you produce summaries, the order will be counterintuitive
# e.g. tabulate ses by race

# reorder levels


##
## Installing libraries
## 

# install tidyverse
install.packages('tidyverse')
# load tidyverse
library(tidyverse)

## ----------------------------- ##
## Basic data summaries with `R` ##
## ----------------------------- ##

# load mpg
?mpg
data(mpg)
str(mpg)

# str and summary

# Tables
# ------

# table make

# table make by year

# proportion table of make
# define table first, then use prop.table


# total proportion table of make / year


# row proportions

# column proportions

# Exercises
###################


# What is the maximum value of highway miles per gallon in the mpg dataset?
# How many cars with manual transmission are there in the mpg dataset?
# What % of the cars in the mpg dataset are SUVs?
# How many SUVs in the mpg dataset are 4-wheel drives?
# What is the % of Toyotas in the mpg dataset that are SUVs?



# Plots (more to come on Wednesday!) #
# -----------------------------------#

# histogram displ

# can play around with scales, titles, etc

# boxplot displ

# boxplot displ by make

# ggplots look a little different
# qplot of displ

# qplot of make
