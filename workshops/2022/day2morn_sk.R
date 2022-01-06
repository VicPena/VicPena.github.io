##########
# Review #
##########
# email: victor.pena@baruch.cuny.edu

# creating variables of different types:
# - numeric, character, factor, logical
# - vectors: allowed to keep more than one observation in a single variable
# - data.frames: data structures that have rows and columns

data(iris)
class(iris)
# data.frame

# saving results into csv files: write.csv

# create summary statistics
# by groups and without groups

############
# Overview #
############
# - Recoding factors redux
# - Review exercises
# - Subsetting rows w/ filter
# - Missing data


####################
# Recoding factors #
####################

library(tidyverse)
interfaith <- read_table2("http://users.stat.ufl.edu/~winner/data/interfaith.dat", 
                          col_names = FALSE)

interfaith

# change column names 
colnames(interfaith) = c("ses", "religion", "gender", "interfaith", "count")
interfaith

# convert variables to factors
# ses, religion, gender, and interfaith
# are read in as numerical when they're not
# they're not really numbers 
# important: for creating tables and using other
# functions that expect factor types and not numeric types

# mutate function
interfaith = interfaith %>% 
              mutate(ses = recode_factor(ses, `1` = "low",
                                              `2` = "middle",
                                              `3` = "high"),
                     religion = recode_factor(religion, `1` = "protestant",
                                                       `2` = "catholic"),
                     gender = recode_factor(gender, `1` = "male",
                                                    `2` = "female"),
                     interfaith = recode_factor(interfaith, `1` = "yes",
                                                            `2` = "no"))


interfaith


#############
# Exercises #
#############

# install.packages("openintro")
library(openintro)
data("absenteeism")
?absenteeism

absenteeism %>% view

# mean sd days aboriginal students
# mean sd days not aboriginal students

# group_by & summarize
# library(tidyverse)
# install.packages("tidyverse")
library(tidyverse)

# find average days of absence and std dev separately by
# each ethnicity status
absenteeism %>% group_by(eth) %>% summarize(mean_days = mean(days),
                                            med_days = median(days),
                                            sd_days = sd(days))

# do the same but for all combinations of ethnicity sex

# eth sex
# A   M
# A   F
# N   M
# N   F

# write code that finds me the means and std deviations
# of days of absence defined by all the combinations of 
# ethnicity and sex
absenteeism
# I want separate summary statistics for 
# the values of ethnicity
# ethnicity:
# - A (aboriginal) and N (not aboriginal)

absenteeism %>% group_by(eth, sex) %>% summarize(mean_days = mean(days),
                                                 sd_days = sd(days))

absenteeism
# find percentages of lrn (learner status)
# by ethnicity

# learner status
# ethnicity

# Among Aboriginals: % of slow learners and % of average learners
# Among Non-aboriginal students: % of slow learners and average learners

absenteeism %>% count(eth, lrn) %>% mutate(perc = 100*n/sum(n))
# but these percentages are not separate by aboriginal and non-aboriginal
# out of the total population
# out of the total population, 27.4% of the students are aboriginal
# and average learners



# percentages grouped by the ethnicity status
# add the fact that we want to separate our analyses
# according to ethnicity status
absenteeism %>% group_by(eth) %>% count(eth, lrn) %>% mutate(perc = 100*n/sum(n))
# separate percentages for aboriginal and non-aboriginal
# 58% of aboriginal are average learners, 42% are slow
# 55.8% of non-aboriginals are average learners, 44.2% slow 


################################
## Subsetting rows with filter #
################################


# subsets of rows using slice

# first 5 rows of iris
iris %>% slice(1:5)

# filter is a function that lets us get subsets of the data
# that satisfy logical conditions

# in practice, we rarely do this. we usually want to
# get subsets of data that satisfy some condition
iris_greater5 = iris %>% filter(Sepal.Length > 5)

iris_greater5

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
iris_not_setosa = iris %>% filter(Species != "setosa")

# observations where Species is only viriginica
iris_virginica = iris %>% filter(Species == "virginica")
iris_virginica

# observations where Sepal.Width is less than or equal to 3
iris_small = iris %>% filter(Sepal.Width <= 3)
iris_small


## Combining logical conditions

## 
## and, or, not in R
##
# & and
# | or
# ! not

# virginica such that petal length is greater than 2
# a subset of the data that only includes 
# flowers whose species is virginica AND 
# their petal length is greater than 2

iris_sub = iris %>% filter(Species == "virginica" & Petal.Length > 2)
iris_sub

iris_sub2 = iris %>% filter(Species == "virginica" | Petal.Length > 2)
# all flowers that are either virginica or have a petal length greater than
# two or both conditions are satisfied
iris_sub2

# Exercise regarding filter
# create a dataset that has only setosas whose petal.length is  greater than 4
# or their petal width is greater than 2 

iris %>%
  filter((Species == "setosa" & Petal.Length > 4) | (Petal.Width > 2) )

# To be in you can be either:
# - Setosa with petal length greater than 4
# - Any flower with petal width greater than 2 

iris %>%
  filter((Petal.Length > 4 | Petal.Width > 2) & (Species == "setosa"))

# for & to satisfied both conditions have to be satisfied



# To be in here both:
# - Setosa
# - and Have petal length greater than 4 or Petal width greater than 2





# Give those that (either setosa and whose petal length is greater than 4)
# or those flowers whose petal width is greater than 2


iris %>%
  filter(Species == "setosa" & (Petal.Length > 4 | Petal.Width > 2))


iris %>%
  filter((Petal.Length > 4 | Petal.Width > 2))

# Whenever we write complex logical conditions 
# make sure to write parentheses to understand the kind of 
# restriction we are applying to our data

# it's easy to make mistakes and end up with empty subsets of 
# data when we code these things 




#############
# Exercises #
#############

# install.packages("gapminder"): command for installing the package
# install.packages("gapminder")

# information on countries over the years
# lifeExp, gdpPercap by continent over the years
library(gapminder)
data(gapminder)
view(gapminder)
?gapminder

# group_by + summarize:
# find separate summary statistics 
# for different categories

# average life expectancy by continent?
# ignore the year; combine from all years
gapminder %>%
  group_by(continent) %>%
  summarize(avg_lifeExp = mean(lifeExp)) 


gapminder %>% 
  group_by(continent, year) %>% 
  summarize(avg_lifeExp = mean(lifeExp)) %>% 
  view

# average life expectancy by country along with its sd
gapminder %>%
  group_by(country) %>%
    summarize(avg_LE = mean(lifeExp),
              sd_LE = sd(lifeExp)) %>%
                view

# average life expectancy by continent 
# looking only at data in 1952?

# run filter first so that you only work with data
# from 1952 
# and then group_by and summarize to get the answer

gapminder %>% filter(year == 1952) %>% 
                group_by(continent) %>%
                  summarize(avg_LE = mean(lifeExp))


gapminder %>% 
  group_by(continent) %>%
  filter(year == 1952) %>% 
  summarize(avg_LE = mean(lifeExp))


# when the variable is categorical we need quotation marks
# when we deal with numbers we don't

# average population by continent in 1997?
gapminder %>% filter(year == 1997) %>% 
  group_by(continent) %>%
  summarize(avg_pop = mean(pop))

# table with average life expectancy by continent in years 1952 and 2007?
# averages for 1952
gapminder %>% 
  group_by(continent) %>%
  filter(year == 1952) %>% 
  summarize(avg_LE = mean(lifeExp))
# averages for 2007
gapminder %>% 
  group_by(continent) %>%
  filter(year == 2007) %>% 
  summarize(avg_LE = mean(lifeExp))

# table with average life expectancy by continent in years 1952 and 2007?
# averages for 1952

# it makes sense to filter our data
# so that we only have data from those years
gapminder %>% 
  filter(year == 1952 | year == 2007) %>%
  group_by(continent, year) %>% 
  summarize(avg_LE = mean(lifeExp))


# I could do the following
# I can find all the averages for all combinations of year
# and continent and after that, filter out only the years that 
# I care about
gapminder %>%
  group_by(continent, year) %>% 
    summarize(avg_LE = mean(lifeExp)) %>%
      filter(year == 1952 | year == 2007)

# combining group_by, summarize, filter, and count
# we can get summary statistics that are as complex and detailed as 
# we want




#############################
# Dealing with missing data #
#############################

# missing data are marked with NA: Not Available
x = c(1:5, NA)
# NA: not available
x

# applying functions to vectors with missing data is tricky
# for example, let's take the mean of x
mean(x)
sd(x)
# NA
# if I apply any summary statistic to a vector containing 
# one missing value then the answer is going to be NA

mean(x, na.rm = TRUE)
sd(x, na.rm = TRUE)
# na.rm = NA remove
# takes out the missing data and then finds average



# by default, if there is an NA in our data and we try to compute
# any function with it, the answer is going to be NA

# arithmetic with NAs is NA
5+NA
0*NA
# whenever we have a missing value and we do an operation with 
# it the result is going to be missing


# load in airquality
data("airquality")
view(airquality)
summary(airquality)
# the number of missing values appears in the 
# summary output
# for example, we got 37 missing values of Ozone

airquality %>% summarize(avg_ozone = mean(Ozone))
airquality %>% summarize(avg_ozone = mean(Ozone, na.rm = TRUE))
# if I want to see actual averages with summarize
# I need to add na.rm = TRUE



# na.omit: keep complete cases only
# usually not recommended unless you have 
# a very good reason to drop the missing data
air_clean = na.omit(airquality)

summary(air_clean)
# if you run na.omit you get out a dataset
# that has NO missing values

