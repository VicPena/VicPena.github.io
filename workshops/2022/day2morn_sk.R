##########
# Review #
##########
# email: victor.pena@baruch.cuny.edu


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

data("absenteeism")
?absenteeism

# find average days of absence and std dev by
# ethnicity status

# do the same but for all combinations of ethnicity
# status and sex

# find percentages of lrn (learner status)
# by ethnicity


################################
## Subsetting rows with filter #
################################


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



#############
# Exercises #
#############

# install.packages("gapminder"): command for installing the package
library(gapminder)
data(gapminder)
?gapminder

# group_by + summarize:
# find separate summary statistics 
# for different categories

# average life expectancy by continent?

# average life expectancy by country along with its sd

# average life expectancy by continent in 1952?

# average population by continent in 1997?

# find average life expectancy by continent in 1952 and 2007?


#############################
# Dealing with missing data #
#############################

# missing data are marked with NA: Not Available
x = c(1:5, NA)
x

# applying functions to vectors with missing data is tricky
# for example, let's take the mean of x

# by default, if there is an NA in our data and we try to compute
# any function with it, the answer is going to be NA

# arithmetic with NAs is NA


# load in airquality
data("airquality")
?airquality
summary(airquality)


# na.omit: keep complete cases only
# usually not recommended unless you have 
# a very good reason to drop the missing data
air_clean = na.omit(airquality)

