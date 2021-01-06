#############################
# Exporting data and tables #
#############################

library(tidyverse)
data(mpg)

# Exporting a dataset into a text file
write.table(mpg, file = "~/Desktop/mpg.txt")

# you can set the working directory with Rstudio

# Exporting a dataset into a *.csv spreadsheet
write.csv(mpg, file = "~/Desktop/mpg.csv")

write.csv(mpg, file = "mpg2.csv")

# Same idea works with tables!
tab = table(mpg$manufacturer, mpg$year) # rows first, column second
write.csv(tab, file = "table.csv")

table(mpg$manufacturer, mpg$year, mpg$drv) # we can do 3D tables

# Fancier exporting into Word documents
# http://www.sthda.com/english/wiki/add-a-table-into-a-word-document-using-r-software-and-reporters-package

#############################
# Dealing with missing data #
#############################

# missing data are marked with NA: Not Available

x = c(1:5, NA)
x

# applying functions to vectors with missing data is tricky
# for example, let's take the mean of x
mean(x)
# by default, if there is an NA in our data and we try to compute
# any function with it, the answer is going to be NA
mean(x, na.rm = TRUE) # na.rm stands for NA remove
sum(x)
# arithmetic with NAs is NA
3+NA
0*NA

# load in airquality
data("airquality")
?airquality
summary(airquality)

mean(airquality$Ozone, na.rm = TRUE)

# na.omit: keep complete cases only
# usually not recommended unless you have 
# a very good reason to drop the missing data
air_clean = na.omit(airquality)

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
iris_sub = iris %>% select(2, 5)
iris_sub2 = iris %>% select(Sepal.Width, Species)

# %>% : pipe operator

# can also subset by telling R to exclude
iris_sub3 = iris %>% select(-Species)
iris_sub4 = iris %>% select(-c(Sepal.Length, Species))
iris_sub4 = iris %>% select(-Sepal.Length, -Species)

# table creates a table that counts how many flowers of each type there are
table(iris$Species)
# this gives me the whole column and doesn't do the tally
iris %>% select(Species)


######################################
# creating new variables with mutate #
######################################

# we can create new variables using "mutate"
# for example, we can create a new
# variable with the avg measurements on the 
# flowers 

iris2 = iris %>% mutate(avg_measurement = (Sepal.Length + Sepal.Width + Petal.Length + Petal.Width)/4)

iris = iris %>% mutate(avg_measurement = (Sepal.Length + Sepal.Width + Petal.Length + Petal.Width)/4,
                       avg_sepal = (Sepal.Length+Sepal.Width)/2)

#####################
## Subsetting rows ##
#####################

data(iris)

# filter function: allows me to create subsets of rows that
# satisfy some condition

# getting to 1, 30 and 50th row
iris[c(1, 30, 50), ] # using brackets, which we saw on Monday

# in practice, we rarely do this. we usually want to
# get subsets of data that satisfy some condition
iris_greater5 = iris %>% filter(Sepal.Length > 5)

##
## Logical operators in R
##
# == equal to: we need 2 equal signs!
# != not equal to
# > greater than
# < less than
# >= greater or equal to
# <=  less than or equal to

# observations where Species is not setosa
iris %>% filter( Species != "setosa") # remember to put character values in quotation marks!
iris %>% filter(Species == "setosa")


## Combining logical conditions

## 
## and, or, not in R
##
# & and
# | or
# ! not

# setosas whose Sepal.Width is less than or equal to 4
iris %>% filter(Species == "setosa" & Sepal.Width <= 4)

# setosas or versicolor whose Sepal.length is greater than 5
iris %>% filter( (Species == "setosa" | Species == "versicolor") & Sepal.Length > 5) 

# we can create new variables using logical conditions with mutate
iris %>% mutate( bigLength = Sepal.Length > 5)
# if you want to convert TRUE to 1 and FALSE to 0
iris %>% mutate( bigLength = 1*(Sepal.Length > 5))
# can use this to our advantage with complicated logical conditions
iris %>% mutate( cond =  1*((Species == "setosa" | Species == "versicolor") & Sepal.Length > 5))

##########################
# group_by and summarize #
##########################

# install.packages("gapminder"): command for installing the package
library(gapminder)
data(gapminder)
?gapminder

# group_by + summarize:
# find separate summary statistics 
# for different categories

# average life expectancy by continent?
gapminder %>% group_by(continent) %>% summarize(avgLifeExp = mean(lifeExp))

# average life expectancy by country along with its sd
lifeExp = gapminder %>% group_by(country) %>% summarize(avgLife = mean(lifeExp), sdLife = sd(lifeExp))

# average life expectancy by continent in 1952?
gapminder %>% filter(year == 1952) %>% group_by(continent) %>% summarize(avgLifeExp = mean(lifeExp))

# average population by continent in 1997?
gapminder %>% filter(year == 1997) %>% group_by(continent) %>% summarize(avgpop = mean(pop))

# find average life expectancy by continent in 1952 and 2007?
gapminder %>% filter(year == 1952 | year == 2007) %>%
                  group_by(continent, year) %>% summarize(avglifeExp = mean(lifeExp))

gapminder %>% group_by(continent, year) %>% summarize(avglifeExp = mean(lifeExp)) %>%
          filter(year == 1952 | year == 2007)

##################################
# count: tables in the tidyverse #
##################################
library(tidyverse)
data(mpg)

# with count you can do tables, which we know how to do already, using table
# however, count is in the tidyverse, so it's easy to combine with other functions
# therein, and we can use it with %>%, which is nice (once you get used to them)

table(mpg$manufacturer)
mpg %>% count(manufacturer) %>% mutate(perc = 100*n/sum(n)) %>% select(-n)
tab = mpg %>% count(manufacturer, year, drv) 
table(mpg$manufacturer, mpg$year, mpg$drv)
# unlike table, count skips combinations that have counts equal to 0

tab = table(mpg$manufacturer, mpg$year)
# row proportions using prop.table
prop.table(tab, 1)

tab =  mpg %>% count(manufacturer, year) %>% group_by(manufacturer) %>% mutate(perc = round(100*n/sum(n), 3))
write.csv(tab, file = "mpgtable.csv")



tab %>% filter(manufacturer == "ford")

mpg %>% mutate(avghwy = mean(hwy))
mpg2 = mpg %>% group_by(manufacturer) %>% mutate(avghwy = mean(hwy)) %>% ungroup %>%
          group_by(year) %>% mutate(avgcty = mean(cty))
# if you want to group by some other variables, remember to ungroup

