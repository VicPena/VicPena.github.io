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

# Exercise: Create a variable named var4 whose value is your favorite number

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

# Exercise: find x to the z-th power times y

# Can't do arithmetic operations on characters
x = "3"
y = 3

# what happens if we try to compute x-y?


# Some arithmetic funtions:
# exp: exponential
# sqrt: square root
# log(x, base = y): log of x, base y (default is base e, the natural logarithm)

x = 3
exp(x^2)
sqrt(54)

# Exercise: find natural logarithm of 5

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

# exercise: find the class of the vectors above

# ranges of numeric values, ascending and desc.
1:2021

# finding lengths of vectors with length

#---------------------------------#
# Operations with numeric vectors #
#---------------------------------#
x1 = 1:6
x2 = 7:12

# number-vector operations: +, -, *, /

# componentwise vector-vector operations: +, -, *, /
x1
x2
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

## append the value 10 to the end of x1

## append the value 10 to the beginning of x1

## concatenate x1 and x2

#----------#
# Indexing #
#----------#

# Idea: accessing particular values of a vector
# useful for creating subsets of vectors

x1 = 1:6

# first entry

# 4th entry 

# last entry 

# third and fifth entry 

# second through fifth entries 

# all but first entry 

# exclude third and fifth entries  

# exclude 2nd through 5th


x = c("a", "b", "c", "e")
# modify fourth entry of x from "e" to "d"


##########################
## Intro to data.frames ##
##########################

# work with iris dataset
?iris
data(iris)



# str

# summary

# head

# tail

# we can index the same way we indexed matrices

# subset the first 20 rows

# exclude the third column

# subset rows 1 through 10 and exclude first two columns


# we can extract variables using $ followed by the name of the variable
# e.g. create a new variable that extracts "Species" out of iris


# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), var2 = c("A","B","C"))
df

# can rename rows and columns of data.frame with rownames & colnames


# adding new variables to a data.frame
# e.g. add var3 below to df
var3 = c("X","Y","Z")


