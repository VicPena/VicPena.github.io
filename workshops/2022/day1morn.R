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
# you can either: highlight code and click on run
# or be on the line that you want to run and 
# hit control + enter (windows) or command + return

# comments in R are prefaced by a pound symbol #
# if there is a pound symbol, R will know to ignore whatever
# comes after

# commenting code is very useful because sometimes we write
# code that is complicated and we come back to it some other 
# day and we might not know what we were doing if we 
# don't comment the code


# To use libraries you need to
# 1. install them (only have to do once)
# 2. load them (you have to do everytime you start R from scratch)

# to load it, you need to run
library(tidyverse)

# whenever you start R, you have to load the packages
# you want to use 

#############################
# Introduction to variables #
#############################

# Cheat sheets: https://rstudio.com/resources/cheatsheets/

# variables are useful because they let us store information

#--------------------# 
# Creating variables #
#--------------------#
var1 = 2020
var2 = FALSE
var3 = "text"

# these are variables of different types
# var1: numerical type variable
# var2: logical type variable (TRUE or FALSE)
# var3: character type variable


# Exercise: Create a variable named var4 whose value is your favorite number
# and print its value
var4 = 0
var4

# NB: can use <- for defining variables as well
var1 <- 2020
var2 <- FALSE
var3 <- "text"
# the arrow is two characters so it takes longer 
# to type than an equal sign

# We can overwrite variables
var1 = 2022
var2 = TRUE

#----------------------#
# Basic variable types #
#----------------------#

# use the function class() to retrieve 
# variable types 
class(var1)
# a numeric type variable
class(var2)
# logical
class(var3)
# character

var5 = factor("good morning")
class(var5) 
# factor

# certain functions expect certain types of variables
# sometimes you have to make sure that the variables 
# that you have are of the appropriate type; otherwise,
# the function might not work

# some functions expect "factor" type variables and
# sometimes our variables are "character" instead and 
# we need to change the type

# there are two ways of encoding character type information
# in R:
# - "character" type: older and not very flexible
# - "factor" type: newer and more flexible
# often, we have to convert data types from "character" to 
# "factor"

# there are many types of variables:
# - "numeric": is used for numbers 
# - "character" / "factor": these are used for character information
# - "logical": logical statements TRUE or FALSE
# - "date" : dates
# - ... 

# "good morning": you can either store it as a factor or as a 
# character; factors are a newer way of storing this sort of information
# so sometimes, we need to convert from one type to the other because
# certain functions expect data in a certain type

# Exercise: find the variable types of var4 and var5
var4 = 1e3
var5 = "TRUE"
var6 = TRUE

# e???
# We can use scientific notation for numbers in R
# for example; if I want to write 1000
# I can define
var4 = 1e3 
# 1e3 = 1*10^3 # 1 times 10 to the third power
# 1e3 = 1000 a thousand
# 1e5 = 100000 # hundred thousands
# 50000 = 5e4

# var5 is a character type... why?
# If you define something wrapped around quotation marks
# R is going to think that it's a character type variable
var7 = "7"
class(var7)
# var5 is not logical because TRUE was wrapped around
# quotation marks




#-------------------------------------#
# Operations and arithmetic functions #
#-------------------------------------#

# + add
# - subtract
# * multiply
# / divide
# ^ exponentiate (caret)

x = 32
y = 5
z = 3

# For example:
x+y/z # x plus the result dividing y over z 
z^y # z to the y-th power

# if I wanted to add x plus y first and then divide
# we can add parentheses!
(x+y)/z

# + add
# - subtract
# * multiply
# / divide
# ^ exponentiate (caret)

# Exercise: find x to the z-th power times y
x^z*y
# the order of operations has exponents first
(x^z)*y

# Can't do arithmetic operations on characters
x = "3"
class(x)
x^3
# we can't do arithmetic on characters
y = 3
# what happens if we try to compute x-y?
x-y
# despite x being 3, R doesn't know that because
# it's been read in as a character

# convert x to numeric and try again
# if you have a variable that is read in as character
# but is actually a number, like x here
# you can convert it with the code
x = as.numeric(x)
class(x)
x
# compute x to third power
x^3
# take difference x - y
x-y
# works as expected

# Some arithmetic functions:
# exp: exponential
# sqrt: square root
# log(x, base = y): log of x, base y (default is base e, the natural logarithm)
exp(x) # e^x: (2.71...)^x
sqrt(x)
log(x, base = 10)
log(x, base = 2)
log(x) # natural logarithm

# Exercise: 
# define x = 3, y = 5, and z = 53
# find the arithmetic mean of x, y, and z
# find the arithmetic mean of the (natural) logarithms of x, y, and z
x = 3
y = 5
z = 53
# mean x, y and z: add them up and divide by 3
(x+y+z)/3
# mean of natural logarithms of x, y and z: 
# log(x) log(y) log(z) and then take the average
(log(x)+log(y)+log(z))/3

#############
## Vectors ##
#############

# Vectors allow us to store multiple elements in a single variable

#--------#
# Basics #
#--------#

# we can define vectors
x1 = c(1, 2, 3, 4, 5, 6)
# mean of x1: there is a function that 
# takes in vectors and outputs means
mean(x1)
sd(x1)
var(x1)
median(x1)

y1 = c("a","b","c","d","efg")
# character-type vector

z1 = c("a", 2, 3, "e")
# this doesn't give me any errors
# however, z1 is going to be all characters
z1

z3 = c(1, 2, 3, 4, 5, 6, 7, 8 , 9, "10")
# if there is at least one character entry
# the vector is going to be read in as character

# exercise: find the class of the vectors above
class(z1) # character type vector
class(z3)
class(x1) # numeric type vector



# ranges of numeric values, ascending and desc.
going_up = 1:2022
max(going_up)
length(going_up)

# a vector that goes from 1 to 2022 I don't have to type
# all the numbers
going_down = 2022:1
going_down

# finding lengths of vectors with length
length(x1)

#---------------------------------#
# Operations with numeric vectors #
#---------------------------------#
x1 = 1:6 # 1 through 6
x2 = 7:12 # 7 through 12
x1
length(x2)
# both vectors of length 6

# componentwise vector-vector operations: +, -, *, /
# + add
# - subract
# * multiply
# / divide
# ^ exponentiate
x1+x2
x1*x2

w1 = c(1, 2, 3)
w2 = c(1, 3, 4, 5, 6)
w1+w2


# find mean, standard deviation, variance, sum and product of a vector
mean(w2)
sd(w2)
var(w2)
sum(w2)
prod(w2)

w2
# prod(w2) = 1*3*4*5*6

## Exercises ##

# what is the value of 1 * 2 * ..... * 10?
prod(1:10)
# what happens if you try to find 1 * 2 * .... * 2019?
prod(1:2019)
# if a number is very large R will say that it is infinite
# there is a threshold upon which R gives up and says
# it's infinite
# ~ 10^16




# find the R equivalent of 
# the function SUMPRODUCT in Excel
x = c(1, 2, 3)
y = c(4, 5, 6)
# 1*4+2*5+3*6

# 1st step: create a vector with the products
# 1*4, 2*5, 3*6
z = x*y
z

# 2nd step: add up the vector that I created in
# step 1
sum(z)
1*4+2*5+3*6
sum(x*y)




# Let
x = 1:10
y = 11:20
# SUMPRODUCT(x,y)
# less code than writing 1*11 + 2*12 + .... + 10*20
# using sum function

# 1st step where you find the componentwise
# products: 1*11, 2*12, 3*13, ... , 10*20
z = x*y
sum(z)
sum(x*y)

#---------------#
# Concatenating #
#---------------#
x1 = 1:6
x2 = 7:12
x1
x2
# sometimes you want to combine vectors
# you may want to create a bigger vector 
# called x3 which combines the values of 
# x1 and x2
x3 = c(x1, x2)
x3

## append the value 10 to the end of x1
x4 = c(x1, 10)
## append the value 10 to the beginning of x1
x5 = c(10, x1)
x5

# can squeeze values in the middle with append
# append(x, values, after)
x = c(1, 2, 3, 5, 6)
y = c(9, 8, 7,  5, 4)
# you would like to squeeze 4 after the third position
# you can do that with the append function
x = append(x, 4, after = 3)
y = append(y, 6, after = 3)
y
# append 6 to x after the third number in the vector
# after refers to the position within the vector
# not the contents of the vector

z = c(5, 4, 0, -1)
# I want to put the numbers 3, 2, 1 after 4
z = append(z, c(3, 2, 1), after = 2)


#----------#
# Indexing #
#----------#

# Idea: accessing particular values of a vector
# useful for creating subsets of vectors

x1 = 1:6
x1

# first entry
x1[1]

# 4th entry 
x1[4] 

# last entry 
x1[6]
x1[length(x1)]

# third and fifth entry 
x1[c(3,5)]

# second through fifth entries 
# access entries 100 through 200 of x2
x2 = 2020:1000
x2[100:200]

# we can use this to edit values of a vector
x3 = c("a", "b", "c", "e", "e")
# we want to change the values of entries
# through indexing

# we want to change the fourth entry
# of x3 from "e" to "d"
x3[4] = "d"

# all but first entry 
x3[-1]

# exclude third and fifth entries  
x3[-c(3, 5)]

# exclude 2nd through 5th
x3[-(2:5)]

##########################
## Intro to data.frames ##
##########################

# we've seen variables
# at first, variables only had 
# one value
var3 = FALSE

# then, we moved on to vectors, which
# had more than one value 
x3 = c("a", "b", "d", "goodbye")

# now, we're going to go a step further
# and define variables / objects 
# that have rows and columns 

# and those are called data.frames


# work with iris dataset
?iris
data(iris)
class(iris)
# data.frames are objects that rows and columns
# the columns can be of different types

# this is useful because real data looks like this
# we often have several variables of different types

# data.frames are the most commonly used types 
# in real data analyses

# iris dataset is built into R 
# you can get information about by typing in
?iris



# data.frame is a data structure in R 
# that allows me to store datasets (that is, objects with rows and columns,
# which are potentially of different types)
class(iris)



# glimpse: quick look at the dataset
library(tidyverse)
glimpse(iris)
# glimpse function is especially useful whenever we 
# have many variables because just looking at the data might 
# not be a good idea (since it may be too large)


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

# summary: expects factors for categorical information
summary(iris)
# for Species a table of frequencies

# if I had Species as a character instead, the output wouldn't 
# be meaningful
iris$Species = as.character(iris$Species)


# let's convert back to factor
iris$Species = as.factor(iris$Species)
glimpse(iris)

# if I run summary
summary(iris)
# there are 50 flowers of type setosa, 50 of type
# versicolor, and so on

# get the 1st quartile, 3rd quartile: 25% percentile, 75% percentile

# in the afternoon, I'm going to keep on talking about
# data.frames and how to work with them because real data
# are data.frames not vectors



