
#############
# Logistics #
#############

# Welcome to the introduction to R workshop!
# Days: Jan 3, 5, 7
# Times: 10am to noon, then 2pm to 4pm
# Small breaks at 11am and 3pm


# Course website: https://vicpena.github.io/workshops/2022/introR

# Please sign up to TopHat and Datacamp
# You'll find exercises and small courses there

############
# Overview #
############
# - Installing packages
# - Variables 
# - Operations and functions
# - Vectors and data.frames

#######################
# Installing packages #
#######################

# R is powerful because many people have built 
# add-ons (packages) that are very useful 

# one of them is tidyverse, which has useful functions 
# for data import, visualization, etc.

# to install it, you need to run the command 
install.packages("tidyverse")

# to load it, you need to run
library(tidyverse)

# whenever you start R, you have to load the packages
# you want to use 



#############################
# Introduction to variables #
#############################

# Cheat sheets: https://rstudio.com/resources/cheatsheets/

#---------------------------#
# Running code and comments #
#---------------------------#

# Can run code by highlighting an instruction 
# and clicking on "Run" or using the shortcut Ctrl + Enter

# Try and run the commands in the 3 lines below
# You can send code to the console by typing Ctrl + Enter
3+2
# comment
hist(rnorm(100), col = rainbow(20))

# Getting help:
# If you want to know how a function works, 
# you can type in ?<name of the function>
# For example
?hist
# Unfortunately, the help files can be a little
# cryptic, but you get used to them

#--------------------# 
# Creating variables #
#--------------------#
var1 = 2020
var2 = FALSE
var3 = "text"
var3

# Exercise: Create a variable named var4 whose value is your favorite number
# and print its value


# NB: can use <- for defining variables as well
var1 <- 2020
var2 <- FALSE
var3 <- "text"

# We can overwrite variables
var1 = 30
var2 = TRUE

#----------------------#
# Basic variable types #
#----------------------#

# use the function class() to retrieve 
# variable types 


# Exercise: find the variable types of var4 and var5
var4 = 1e3
var5 = "TRUE"

#-------------------------------------#
# Operations and arithmetic functions #
#-------------------------------------#

# + add
# - subtract
# * multiply
# / divide
# ^ exponentiate

x = 32
y = 5
z = 1

# For example:
x+y/z
z^y

# Exercise: find x to the z-th power times y

# Can't do arithmetic operations on characters
x = "3"
y = 3

# what happens if we try to compute x-y?

# convert x to numeric and try again

# Some arithmetic functions:
# exp: exponential
# sqrt: square root
# log(x, base = y): log of x, base y (default is base e, the natural logarithm)

# Exercise: 
# define x = 3, y = 5, and z = 53
# find the arithmetic mean of x, y, and z
# find the arithmetic mean of the (natural) logarithms of x, y, and z

#############
## Vectors ##
#############

# Vectors allow us to store multiple elements in a single variable

#--------#
# Basics #
#--------#

# we can define vectors
x1 = c(1, 2, 3, 4, 5, 6)
y1 = c("a","b","c","d","efg")
z1 = c("a", 2, 3, "e")
z3 = c(1, 2, 3, 4, 5, 6, 7, 8 , 9, "10")


# exercise: find the class of the vectors above

# ranges of numeric values, ascending and desc.
going_up = 1:2022
going_down = 2022:1

# finding lengths of vectors with length
length(x1)

#---------------------------------#
# Operations with numeric vectors #
#---------------------------------#
x1 = 1:6
x2 = 7:12
x1
x2


# componentwise vector-vector operations: +, -, *, /
x3 = x1+x2
x1*x2



# find mean, standard deviation, variance, sum and product of a vector


## Exercises ##

# what is the value of 1 * 2 * ..... * 10?

# what happens if you try to find 1 * 2 * .... * 2019?

# Let
x = 1:10
y = 11:20
# find the R equivalent of 
# the function SUMPRODUCT in Excel

#---------------#
# Concatenating #
#---------------#
x1 = 1:6
x2 = 7:12
x1
x2

## append the value 10 to the end of x1

## append the value 10 to the beginning of x1

# can squeeze values in the middle with append
# append(x, values, after)

## concatenate x1 and x2
x3 = c(x1, x2)
c(x2, x1)

#----------#
# Indexing #
#----------#

# Idea: accessing particular values of a vector
# useful for creating subsets of vectors

x1 = 1:6
x1

# first entry

# 4th entry 

# last entry 


# third and fifth entry 

# second through fifth entries 
# access entries 100 through 200 of x2

# all but first entry 

# tell R that I want to exclude the first entry

# exclude third and fifth entries  

# exclude 2nd through 5th

x = c("a", "b", "c", "e")
# edit fourth entry of x from "e" to "d"


##########################
## Intro to data.frames ##
##########################

# work with iris dataset
?iris
data(iris)

# data.frame is a data structure in R 
# that allows me to store datasets (that is, objects with rows and columns,
# which are potentially of different types)
class(iris)



# glimpse: quick look at the dataset
glimpse(iris)

# species is a factor
# factors are a data type for categorical data in R
# it is not the same as character
# in R there are 2 variable types that can be used to store categorical data
# one of them is character, the other one is factor
# factor as a nicer way of dealing with categorical than character


# Here I'm converting a variable of character type to factor
# This happens a lot, because factors are nicer than character
var1 = "hello"
class(var1)
var1 = as.factor(var1)
class(var1)

# summary
summary(iris)

# subset rows with slice

# subset columns with filter

# can also subset by exclusion



# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), 
                dog = c("A","B","C"))
df

# can rename rows and columns of data.frame with rownames & colnames
colnames(df) = c("var1", "var2")
rownames(df) = c("Ann","Bob","Carl")
df

# adding new variables to a data.frame
# using mutate
# e.g. add c("X","Y", NA)
# (the marker for missing data in R is NA Not Available)





