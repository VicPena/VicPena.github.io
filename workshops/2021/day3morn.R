###########################################
# Confidence intervals & Hypothesis tests #
###########################################

library(tidyverse)

# Inference on population means (based on normal dist'n)
#-------------------------------------------------------

# one mean
#---------

# t-test
# Assumptions:
# 1. observations are independent
# 2. if sample size is small (n < 30), data are roughly bell-shaped 
# and thin-tailed
# 3. if sample size is big, data don't have to look bell-shaped;
# thin-tailedness is enough


# scientists recorded some measurements stored in x
x = c(1,4,2,3,6,9,1,3,9,3)

# visualize data
library(tidyverse)
qplot(x)

# provide a 99% confidence interval for the population mean
# (interval based on normal distribution)
t.test(x, conf.level = 0.99)

# Test H0: population mean is equal to 2
#      H1: population mean is NOT equal to 2
t.test(x, mu = 2)

# Test H0: population mean is equal to 5
#      H1: population mean is less than 5
t.test(x, mu = 5, alternative = "less")
t.test(x, mu = 5, alternative = "greater") # H1: mean is greater than 5


# comparing two means
#---------------------

# A pharmaceutical is interested in knowing whether 
# their new treatment is significantly different 
# than the current gold standard. 
# They collected a sample of 40 individuals:
# 20 of them were assigned the new treatment, 
# and 20 of them were assigned the current treatment. 
# The outcome is on an ordinal scale that goes 
# from 0 to 100, where 0 is "bad" and 100 is "great".

# read in the data from https://vicpena.github.io/sta9750/fall18/pharma.csv
library(readr)
pharma <- read_csv("https://vicpena.github.io/sta9750/fall18/pharma.csv")

# find means and standard deviations by group
pharma %>% group_by(group) %>% summarize(avgOut = mean(outcome), median(outcome), sd(outcome))

# visualize the data
# ggplot(<dataset>) +
# aes() # variables that go into the plot along with the role that they play
# facets, changing labels, limts , adding titles, etc.

# The outcome is on an ordinal scale that goes 
# from 0 to 100, where 0 is "bad" and 100 is "great".
# side-by-side boxplots
ggplot(pharma) +
  aes(x = group, y = outcome) +
    geom_boxplot()

ggplot(pharma) +
  aes(x = outcome) +
    geom_histogram() +
      facet_grid(group ~ .)

# find 95% confidence interval for difference
# (pop mean current treatment) - (pop mean new treatment)
t.test(outcome ~ group, data = pharma)

# Test H0: treatments are the same
#      H1: treatments are different

# Test H0: treatements are the same
#      H1: new treatment is worse
t.test(outcome ~ group, alternative = "greater", data = pharma)
# diff: current - new
# If new treatment is worse, the diff must be positive

# t-test assuming that variances are equal
t.test(outcome ~ group, alternative = "greater", var.equal = TRUE, data = pharma)



## One proportion 


# Do people ever regret getting a tattoo?
# In a 2012 poll by Harris Interactive, 
# 59 out of 423 respondents said yes. 
# Based on the data in this study, 
# find a 99% confidence interval the proportion of people 
# with tattoos who regret getting one. 

# use prop.test, conf.level = 0.99
prop.test(59, 423, conf.level = 0.99)

# test p = 0.2 against p less than 0.2
prop.test(59, 423, p = 0.2, alternative = "less")

prop.test(59, 423, conf.level = 0.95)
prop.test(59, 423) # by default, we get 95% confidence intervals

## Two proportions


#  In a study about online dating, 
# 9 out of 40 males lied about their age
# and 5 out of 40 females lied about their age. Find a 95% confidence
# interval for the difference
# (% of men who lie about their age) - (% of women who lie about their age).

# use prop.test
# test H0: men and women lie at the same rate
# against H1: men lie more than women
prop.test(c(9, 5), c(40, 40), conf.level = 0.95)





## chi-squared tests of independence for categorical variables

# read in hsb2
library(openintro)
data(hsb2)

# a team of social scientists want to test 
# whether the distribution of `ses` depends on `race`

# plot the data
ggplot(hsb2) +
  aes(x = race, fill = ses) + 
    geom_bar(position = "fill") + 
      ggtitle("Race versus socioeconomic status") +
        scale_fill_brewer(palette = "Blues") +
          theme_minimal()

# do a chi-squared test 
tab = table(hsb2$race, hsb2$ses)
chisq.test(tab)


#############################
# Exploratory data analysis #
#############################

# read in http://vicpena.github.io/sta9750/spring19/nyc.csv
nyc <- read_csv("http://vicpena.github.io/sta9750/spring19/nyc.csv")

# Create a figure that contains plots for all the pairs of variables 
#   in the dataset, except Case and Restaurant
# install.packages("GGally")
library(GGally)
# create a dataset which excludes both Case and Restaurant
nycplot = nyc %>% select(-Case, -Restaurant)
ggpairs(nycplot)

install.packages("plotly")
library(plotly)

plot  = ggplot(nyc) +
  aes(x = Service, y = Food, label = Restaurant) +
    geom_point() + geom_smooth()

plot2  = ggplot(nyc) +
  aes(x = Service, y = Food, label = Restaurant) +
  geom_text() + geom_smooth()

plot2

ggplotly(plot)

nyc %>% filter(Service < 15, Food > 20)
nyc %>% filter(Service < 17, Food > 23)

ggplot(nyc) +
  aes(x = Service, y = Price, label = Restaurant) +
  geom_text() + geom_smooth()


# Provide a heatmap for the correlation 
#  between the numerical variables in the dataset. 
ggcorr(nycplot, label = TRUE)

# Find examples of cheap restaurants that 
# have relatively good food and examples of 
# expensive restaurants that have relatively bad food 

# relationship between price and food
ggplot(nyc) +
  aes(x = Food, y = Price, label = Restaurant) +
    geom_text()

plot2 = ggplot(nyc) +
  aes(x = Food, y = Price, label = Restaurant) +
  geom_point() + geom_smooth(method = "lm")

ggplotly(plot2)

##################################
# Fitting regression models in R #
##################################

# Using the lm command
# I'm interested in predicting prices, given 
# outcome: Price
# predictors: Food, Service, Decor, East
mod = lm(Price ~ Food + Service + Decor + East, data = nyc)
summary(mod)
