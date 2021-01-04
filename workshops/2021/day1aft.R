
## ------- ##
## Factors ##
## ------- ##

# another way of working with categorical data

# defining factors
chr1 = c("dog", "cat", "cat", "dog")
fac1 = factor(c("dog","cat","cat","dog"))
class(chr1)
class(fac1)

# summary
summary(chr1)
summary(fac1)

# Factors are nicer than character type variables because they have
# nicer properties; for example, summary works better with factors
# because we get tables (we don't the get the same with characters)

# In the iris dataset, how many species of type setosa are there?
data(iris)
iris
str(iris)

# levels: categories contained in factor
levels(iris$Species)

# read in hsb2 data
# http://vicpena.github.io/sta9750/spring19/hsb2.csv
library(readr)
hsb2 <- read_csv("http://vicpena.github.io/sta9750/spring19/hsb2.csv")


str(hsb2)
summary(hsb2)
hsb2$ses = as.factor(hsb2$ses)
hsb2$gender = as.factor(hsb2$gender)
hsb2$race = as.factor(hsb2$race)
hsb2$schtyp = as.factor(hsb2$schtyp)
hsb2$prog = as.factor(hsb2$prog)
summary(hsb2)

# str, summary, head


# levels of ses
levels(hsb2$ses)

# if you produce summaries, the order will be counterintuitive
# e.g. tabulate ses by race

# reorder levels
hsb2$ses = factor(hsb2$ses, levels = c("low", "middle", "high"))
summary(hsb2)
##
## Installing libraries
## 

# install tidyverse
install.packages("tidyverse")
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
table(mpg$manufacturer)

# table make by year
table(mpg$manufacturer, mpg$year)
table(mpg$year, mpg$manufacturer)
# cross-tabluation in R: first variable rows, second variable columns

# proportion table of make
# define table first, then use prop.table
tab = table(mpg$manufacturer, mpg$year)
tab

# row proportions
# prop.table(tab, 1) for row proportions
# prop.table(tab, 2) for column proportions


round(100*prop.table(tab, 1), 2) # table with row proportions
# column proportions
round(100*prop.table(tab, 2), 2) 

plot(tab)

# Exercises
###################


# What is the maximum value of highway miles per gallon in the mpg dataset?
# based off the hwy variable
summary(mpg)
# the maximum is 44
max(mpg$hwy)

# How many cars with manual transmission are there in the mpg dataset?
mpg$trans = as.factor(mpg$trans)
summary(mpg)
# answer: 58 + 19 
table(mpg$trans) # table works with both character and factor types

# What % of the cars in the mpg dataset are SUVs?
tab = table(mpg$class)
100*prop.table(tab)
# answer: 26.495726%

# How many SUVs in the mpg dataset are 4-wheel drives?
table(mpg$class, mpg$drv)
# Answer: 51 cars

# What is the % of Toyotas in the mpg dataset that are SUVs?
tab = table(mpg$manufacturer, mpg$class)
cartable = round(100*prop.table(tab, 1), 2)
cartable[1, 3]
cartable["toyota","suv"]
cartable["toyota",]
cartable[,"pickup"]

# Plots (more to come on Wednesday!) #
# -----------------------------------#

# histogram displ
hist(mpg$displ,
     main = "Histogram of displacement in L", 
     xlab = "displacement in L",
     ylab = "count",
     xlim = c(0, 10),
     col = "blue")

# can play around with scales, titles, etc

# boxplot displ
boxplot(mpg$displ, 
        main = "Histogram of displacement in L", 
        ylab = "displacement in L",
        ylim = c(0, 10),
        col = "blue")

# boxplot displ by make
boxplot(mpg$displ ~ mpg$manufacturer, 
        main = "Histogram of displacement in L", 
        ylab = "displacement in L",
        ylim = c(0, 10),
        xlab = "manufacturer",
        col = "blue")


# ggplots look a little different
# qplot of displ
qplot(mpg$displ, xlab = "displacement", main = "Displacement in L") 
qplot(mpg$displ, geom = "boxplot", xlab = "displacement", main = "Displacement in L") + coord_flip()

# qplot of make
qplot(mpg$manufacturer)

str(mpg)
# qplot of hwy against cty 
qplot(x = mpg$hwy, y = mpg$cty) + geom_smooth() # by default non-linear
qplot(x = mpg$hwy, y = mpg$cty, xlim = c(0, 60), ylim = c(0, 60)) + geom_smooth(method = "lm")  # by default non-linear
colnames(mpg)[3] = "displacement"
colnames(mpg)
qplot(mpg$displacement, xlab = "displacement in L")
