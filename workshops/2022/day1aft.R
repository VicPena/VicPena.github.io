# First session
# We learned
# - Difference between Rstudio (nice dashboard) and R (engine)
# - Variables: numerical, character, factor, logical
# - Vectors: store multiple numbers (characters) in a single variable
# - data.frames (most useful): rows and columns potentially of different
#                              types


# email: victor.pena@baruch.cuny.edu



############
# Overview #
############
# - More data.frames
# - Getting data into R
# - Basic summaries: intro, grouping, aggregate data 
# - Exercises
# - Plots

####################
# More data.frames #
####################

data(iris)
class(iris)
# data.frame: is a data structure with rows and columns
#             potentially of different types

install.packages("tidyverse")
library(tidyverse)

# subset rows with slice
# rows from 3 to 100
# pipe operator: %>% 
iris_2 = iris %>% slice(3:100)
iris_2

# iris_3: contains rows: 3, 100, 45
iris_3 = iris %>% slice(c(3, 100, 45))
iris_3

# subset columns with select 
iris

# can also subset by exclusion
iris_4 = iris %>% select(Petal.Width, Species)

# why pipe operators are useful
# suppose I want to create a subset of the data
# which includes the rows c(1, 3, 53) and only
# the variables Petal.Width and Species
iris_5 = iris %>% slice(c(1, 3, 53)) %>% select(Petal.Width, Species)
# the order in which you type the functions matters!
# here not so much, but as we learn about other functions, it will
# matter a lot 

# the order is going to be sequential 
# the first function that you write is going to be run first,
# then the second, and so on...


# Two functions
# - slice: subsets of rows
# - select: subsets of columns

# So far, we've seen subsets specified by what we 
# want to include

# We can also specify subsets by what we want to exclude instead

# suppose that I want to exclude rows 1, 3, 5 from iris dataset
iris_5 = iris %>% slice(-c(1, 3, 5))
# if I want to create a subset of my data that excludes
# Species I can write
iris_6 = iris %>% select(-Species)
iris_6

# %>%: part of the tidyverse
# tidyverse functions use the pipe operator extensively


# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), 
                dog = c("A","B","C"),
                var3 = c(5, 4, 3))
df

# can rename rows and columns of data.frame with rownames & colnames
colnames(df) = c("var1", "var2", "var3")
rownames(df) = c("Ann","Bob","Carl")
df

########################################
# adding new variables to a data.frame #
########################################

# using mutate
# e.g. add c("X","Y", NA)
# (the marker for missing data in R is NA Not Available)

df = df %>% mutate(var4 = c("X", "Y", NA))
df
# NA is the marker of missing data in R
# NA stands for Not Available 
# In other programming languages you may have seen
# things like * or . or something else

# Three functions on data.frames
# - slice: for subsets of rows
# - select: for subsets of columns
# - mutate: for creating new variables (from old or not)

# I can also mutate to create new variables from old
# variable called var5 which has the average of var1 and var3
df = df %>% mutate(var5 = (var1+var3)/2)


#######################
# Getting data into R #
#######################

# We can use the Import Dataset menu in Rstudio

# We can use code as well... It's pretty painful, though
# If you're interested in learning that, check out the 
# Datacamp course
# https://app.datacamp.com/learn/courses/introduction-to-importing-data-in-r


# Read in:
# http://users.stat.ufl.edu/~winner/data/nba_ht_wt.csv
library(readr)
nba <- read_csv("http://users.stat.ufl.edu/~winner/data/nba_ht_wt.csv")
summary(nba)
# variables that are character are not well summarized
# if we had them in factor type instead we would a get a nicer
# summary

# if I change say the type of Pos from character to
# factor
nba$Pos = as.factor(nba$Pos)

# it is possible! 
# we can use mutate for that
nba = nba %>% mutate(Pos = as.factor(Pos), 
                     Player = as.factor(Player))

# factor: a nicer type of variable for categorical information
summary(nba)
# instead of seeing a bunch nothing we see
# a table telling me how many players we got in each position


# Read in interfaith dating data
# description: http://users.stat.ufl.edu/~winner/data/interfaith.txt
# data: http://users.stat.ufl.edu/~winner/data/interfaith.dat
library(readr)
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
interfaith = interfaith %>% mutate(ses = factor(ses),
                                   religion = factor(religion),
                                   gender = factor(gender),
                                   interfaith = factor(interfaith))

# there is a way of doing this fast but I'm making
# now a mistake which I won't be able to catch on the fly

# let me show you the slower way of doing this
levels(interfaith$ses) = c("low", "middle", "high")
levels(interfaith$religion) = c("protestant", "catholic")
levels(interfaith$gender) = c("male", "female")
levels(interfaith$interfaith) = c("yes", "no")


df2 = data.frame(var1 = factor(c("A","B","C","C","A","B")))
# suppose that instead of A, B, C I want edit
# those to Alice, Bob and Carol
# the order is alphanumeric
levels(df2$var1) = c("Alice", "Bob", "Carol")
df2

## ----------------------------- ##
## Basic data summaries with `R` ##
## ----------------------------- ##

# we have seen a little bit of that already 
# with the summary function 

# now we're going to use other functions 
# that let us do slightly more complicated 
# summary statistics

# - count and summarize
# - group_by
# - introduction to ggplot

# load mpg
?mpg
data(mpg)

# glimpse
glimpse(mpg)


#####################
# Tables with count #
#####################

# table of manufacturer
mpg %>% count(manufacturer)

# create a column with percentages: mutate function!
# mutate creates new columns 
mpg %>% count(manufacturer) %>% mutate(perc = 100*n/sum(n)) %>% select(-n)

# table of make and year
mpg %>% count(manufacturer, year)
# if I print this, R is not giving all the possible 
# rows because it tries to save space

# if I want to see everything I can add in view after
mpg %>% count(manufacturer, year) %>% view


# export tables with write.csv
# I want to save the table I just did into a csv file
# csv are spreadsheets; they're convenient because
# you can read them in with pretty much any software (including excel)

# first, save the table into a variable
tab = mpg %>% count(manufacturer, year)
write.csv(tab, file = "~/Desktop/manufacturer_year.csv")


# suppose I want to use menus instead of writing paths
write.csv(tab, file = "newtable.csv")
# we can select where we want to save our files by going to the Files tab
# then, find the folder where we want to save the table
# and then click on More > Set As Working Directory
# then, run the code above and the file will be saved there


# R is case sensitive
NBA # this is incorrect: dataset does not exist
nba # this is correct: dataset exists
# NBA is not the same as nba for R


# exercise: with the NBA data, create a table of Pos
# and save it into a csv

# you can use the count function
# to create the table

# mutate creates new variables
# we don't need in this example
pos = nba %>% count(Pos)
write.csv(pos, file = "~/Desktop/pos.csv")

# write.csv function to save the table
# into a csv file


#####################################
# summary statistics with summarize #
#####################################

mpg

# median of cty, std deviation of hwy, minimum of displ
mpg %>% summarize(med_cty = median(cty),
                  mean_cty = mean(cty), 
                  sd_hwy = sd(hwy), 
                  min_displ = min(displ))

# summarize function is convenient for 
# finding specific summary statistics that might be
# of interest

# mean
# median
# sd: std. deviation
# var: variance
# min, max, etc.


############
# group_by #
############
# summary statistics by groups defined 
# by categorical variables in the data

mpg %>% count(class)

# suppose that I want to study fuel consumption
# by class 

# summary statistics grouped by the class

# means and std deviation of cty: city miles per gallon
# by class
mpg %>% group_by(class) %>% summarize(avg_cty = mean(cty),
                                      sd_cty = sd(cty))



# Exercise: 
# find means and std deviations of hwy (highway miles per gallon)
# grouped by manufacturer
mpg %>% group_by(manufacturer) %>% summarize(avg_hwy = mean(hwy),
                                             sd_hwy = sd(hwy))

# absolutely! order matters here
# we need to group first and then summarize

# if we summarize first, we haven't created the groups just yet
# so the answers will not consider the grouping




# we can use group_by with count as well

# for example, what if we want to find the percentage
# of toyotas that are SUVs?

# creating a table that has the information about
# manufacturer and class 
mpg %>% count(manufacturer, class) %>% view

# we are going to use group_by to find 
# percentages that are grouped by the manufacturer
mpg %>% 
  group_by(manufacturer) %>%
  count(manufacturer, class) %>%
  mutate(perc = 100*n/sum(n)) 

# Exercise:
# find the percentage of Toyotas that are 4wd 
# (Hint: use drv variable instead of the class)

# separate statistics by the make of the car
# I'm interested in finding different percentages
# of the drv variable by the manufacturer variable
mpg %>% 
  group_by(manufacturer) %>%
  count(manufacturer, drv) %>% 
  mutate(perc = 100*n/sum(n)) %>%
  view
  
###############################
# Working with aggregate data #
###############################

# the interfaith dating data 
# are "grouped" or in aggregate format
interfaith

# aggregate: each row represents more than 
# one individual

# first row: represents 11 individuals 
# in the study who are of low ses, protestant,
# male and interfaith dating


# find table of interfaith status
interfaith %>% count(interfaith)
interfaith %>% count(ses)


# how do we deal with this???

# a quick way to fix this is to 
# convert the data from aggregate to individual level,
# where each row represents a different individual
# and then run tables as usual

# uncount: converts data from aggregate to
# individual level
inter_indiv = interfaith %>% uncount(count)

# if you have data in individual format
# you can find tables as usual
inter_indiv %>% count(interfaith)
inter_indiv %>% count(ses)

# find percentage of interfaith dating for 
# Catholics and Protestants separately

# group by the religion
# and I find the percentages of interfaith
# dating separately by the religion
inter_indiv %>%
  group_by(religion) %>%
  count(religion, interfaith) %>%
  mutate(perc = 100*n/sum(n)) %>%
  select(-n)

# the % of catholics interfaith dating is ~ 73.1%
# the % of protestants interfaith dating is ~ 24.9%


#############
# Exercises #
#############

data("absenteeism")
?absenteeism

# find average days of absence and std dev by
# ethnicity status

# do the same but for all combinatiosn of ethnicity
# status and sex

# find percentages of lrn (learner status)
# by ethnicity