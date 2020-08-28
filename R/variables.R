#############################
# Introduction to variables #
#############################

# Source code: https://vicpena.github.io/videos/variables.R
# Notes: https://vicpena.github.io/sta9750/introR.pdf

#---------------------------#
# Running code and comments #
#---------------------------#

# Can run code by highlighting an instruction 
# and clicking on "Run" or using the shortcut Ctrl + Enter

# Try and run the commands in the 3 lines below
3+2
# comment
hist(rnorm(100), col = rainbow(20))

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

# Exercise: find x to the z-th power times y

# Can't do arithmetic operations on characters
x = "3"
y = 3
x-y

# We can do arithmetic operations with logical variables
# TRUE is treated as 1
# FALSE is treated as 0
x = -1
y = TRUE
x+y

# Some arithmetic funtions:
# exp: exponential
# sqrt: square root
# log(x, base = y): log of x, base y (default is base e, the natural logarithm)

x = 3
exp(x^2)
sqrt(54)

# Exercise: find natural logarithm of 5




