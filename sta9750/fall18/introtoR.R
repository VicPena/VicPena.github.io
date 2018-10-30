### Creating variables 

# creates two variables
firstvariable = 0 
secondvariable = 10

# you can do operations with the variables
firstvariable+secondvariable
firstvariable*secondvariable

### Using R to compute things

# you can do operations without using variables
10*2
6/2*(2+1)

# R has functions such as sqrt, exp, log, etc.
exp(5)
sqrt(4)
exp(firstvariable)
log(10,base=2)
# you can ask for help by writing ? before the name of a function
?log


###  Vectors

# you can create vectors
x = c(1,2,3,4,5,6)

# and do operations with them
x+5
x*5
x = x/5

# if two vectors are of different lengths, you have to be careful
y = c(2,3)
x+y # componenwise
x*y # componentwise 
z = c(1,3,5,6,5,3)

t(z)%*%x  # vector/matrix product
x*z # componentwise
length(z) # gives us the length of the vector

z = c(z,10) # concatenating: adding more stuff to a vector

# you can access particular entries of a vector
z[1] # first entry
z[7] # 7th entry
z[length(z)] # last entry

### Matrices

# you can create matrices as follows 
A = matrix(c(1,2,3,4),nrow=2,ncol=2,byrow=TRUE) # read by row 
A2 = matrix(c(1,3,2,4),nrow=2,ncol=2,byrow=FALSE) # read by column

A%*%A # matrix prod
A*A # componentwise
A+A
log(A)
A[2,2] # accessing entries: rows first, then columns
A[1,2]

### Installing libraries

# you can install libraries with the command "install.packages"

install.packages('ggplot2')
library(ggplot2)


### Displaying and summarizing data

?mpg
data(mpg) # reads data; it's available in the ggplot2 package


str(mpg) # gives us some information on the variables
summary(mpg) # summary of quantitative variables

# you can tabulate using "table"
table(mpg$manufacturer) # with $, I get variables 
table(mpg$manufacturer,mpg$year)
table(mpg$year)
# can compute means, sds, etc.
mean(mpg$year)
sd(mpg$year)

# can plot stuff, too
hist(mpg$displ, main="Engine displacement (in litres)",
     col=rainbow(20),
     xlim=c(0,10))
# you can learn more about how to change the attributes of the plot with ?hist

# boxplots
boxplot(mpg$displ)
# boxplots by another variable
boxplot(mpg$displ~mpg$manufacturer)

# qplot, which is in library(ggplot2), does nice plots by default
qplot(mpg$displ)
qplot(mpg$manufacturer)

# these are bad; you can make better plots with a little more work
qplot(mpg$displ,mpg$year)
qplot(mpg$displ,factor(mpg$year)) # change the type to factor
boxplot(mpg$displ~factor(mpg$year)) # this is better


