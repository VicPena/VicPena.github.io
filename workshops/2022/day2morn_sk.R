
##################################
# review: group_by and summarize #
##################################

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

