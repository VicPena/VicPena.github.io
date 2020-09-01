##
## Installing libraries
## 

# install ggplot2
install.packages('ggplot2')
# load ggplot2
library(ggplot2)

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



# Plots (more to come in Chapter 3!) #
# -----------------------------------#

# histogram displ

# can play around with scales, titles, etc

# boxplot displ

# boxplot displ by make

# ggplots look a little different
# qplot of displ

# qplot of make