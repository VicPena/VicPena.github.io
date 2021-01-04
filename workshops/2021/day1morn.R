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
var4 = 0
var4

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
class(var1)
class(var2)
class(var3)

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
class(x)
x-y
x = as.numeric(x)
class(x)
x-y

# what happens if we try to compute x-y?


# Some arithmetic funtions:
# exp: exponential
# sqrt: square root
# log(x, base = y): log of x, base y (default is base e, the natural logarithm)

x = 3
exp(x^2)
sqrt(54)
log(10, base = 10)

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
x1
y1
z1
z3 = c(1, 2, 3, 4, 5, 6, 7, 8 , 9, "10")
z3

# exercise: find the class of the vectors above
class(x1)
# ranges of numeric values, ascending and desc.
goingup = 1:2021
2021:1
goingup
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

x1 = c(1, 2, 3)
x2 = c(1, 2, 3, 4, 5, 6)
x1+x2

# find mean, standard deviation, variance, sum and product of a vector
mean(x2)
sd(x2) # (n-1) as the denominator
var(x2) # (n-1) as the denominator
sum(x2)
prod(x2)

## Exercises ##

# what is the value of 1 * 2 * ..... * 10?
x3 = 1:10
prod(x3)
prod(1:10)
# what happens if you try to find 1 * 2 * .... * 2019?
prod(1:2019)

# Let
x = 1:10
y = 11:20
# find the R equivalent of 
# the function SUMPRODUCT in Excel
sum(x*y)

#---------------#
# Concatenating #
#---------------#
x1 = 1:6
x2 = 7:12
x1
x2

## append the value 10 to the end of x1
x3 = c(x1, 10)

## append the value 10 to the beginning of x1
x3 = c(10, x1)
x3

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
x1[1]
# 4th entry 
x1[4]
# last entry 
x1[6]
length(x1)
x1[length(x1)]
x2 = 63:2134
x2[length(x2)]

# third and fifth entry 
x2[c(3,5)]
# second through fifth entries 
# access entries 100 through 200 of x2
x2[100:200]

# all but first entry 
x1
x1[2:6]
# tell R that I want to exclude the first entry
x1[-1]
# exclude third and fifth entries  
x1[-c(3,5)]
v1 = c(3,5)
x1[-v1]

# exclude 2nd through 5th
x1[-(2:5)]

x = c("a", "b", "c", "e")
# modify fourth entry of x from "e" to "d"
x[4] = "d"
x[c(2,4)] = c("B", "D") # R is case sensitive
x


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



# str: structure
str(iris)

# factors are a data type for categorical data in R
# it is not the same as character
# in R there are 2 variable types that can be used to store categorical data
# one of them is character, the other one is factor
# factor as a nicer way of dealing with categorical than character


# Here I'm converting a variable of character type to 
# factor
# This happens a lot, because factors are nicer than character
var1 = "hello"
class(var1)
var1 = as.factor(var1)
class(var1)

# summary
summary(iris)

# head
head(iris)
# tail
tail(iris)

# we can index the same way we indexed 
iris[1,] # first row
iris[36,] # 36th row
iris[,3] # third column
iris[3,3] # third row and third column
iris[2,4] # second row and fourth column
# Important thing to remember: rows go first, then columns

# subset the first 20 rows
iris[1:20,]
# subset that only contains second and fourth
iris2 = iris[,c(2,4)]

# exclude the third column

# subset rows 1 through 10 and exclude first two columns


# we can extract variables using $ followed by the name of the variable
# e.g. create a new variable that extracts "Species" out of iris
iris[,3]
iris$Petal.Length
iris$Species

# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), 
                dog = c("A","B","C"))
df

# can rename rows and columns of data.frame with rownames & colnames
colnames(df) = c("var1", "var2")
rownames(df) = c("Ann","Bob","Carl")
df

# adding new variables to a data.frame
# e.g. add var3 below to df
var3 = c("X","Y", NA)
df$var3 = var3
df
# the marker for missing in R is NA Not Available


