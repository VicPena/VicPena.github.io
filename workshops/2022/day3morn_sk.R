############
# Overview #
############
# - Confidence intervals and hypothesis testing
# - Exploratory data analysis

###################### 
# Plots: odds & ends #
######################

library(tidyverse)
library(openintro)

data(hsb2)
tab2 = hsb2 %>% count(ses, race)

# changing scale from proportions to percentages
# in geom_col(position = "fill")
ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
  geom_col(position = "fill") +
  scale_y_continuous() 


ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent) 


# adding counts / percentages to bars
library(openintro)
data(immigration)

immi_counts = immigration %>% group_by(political) %>% count(response)

ggplot(immi_counts) +
  aes(x = political, y = n, label = n, fill = response) +
  geom_col() +
  geom_text(position = position_stack(0.5))

ggplot(immi_counts) +
  aes(x = political, y = n, label = n, fill = response) +
  geom_col(position = "dodge") +
  geom_text(position = position_dodge(0.9))


ggplot(immi_counts) +
  aes(x = political, y = n, label = round(100*n/sum(n),2), fill = response) +
  geom_col(position = "fill") +
  geom_text(position = position_fill(0.5))


# adding error bars to bar plots
# http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization


###########################################
# Confidence intervals & Hypothesis tests #
###########################################

library(tidyverse)

# Inference on population means (based on normal dist'n)
#-------------------------------------------------------


# scientists recorded some measurements stored in x
x = c(1,4,2,3,6,9,1,3,9,3)

# visualize data


# provide a 99% confidence interval for the population mean
# (interval based on normal distribution)

# Test H0: population mean is equal to 0 
#      H1: population mean is NOT equal to 0



# Test H0: population mean is equal to 5
#      H1: population mean is less than 5


# Non-parametric alternative: wilcox.test

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

# find means and standard deviations by group

# visualize the data

# find 95% confidence interval for difference
# (pop mean current treatment) - (pop mean new treatment)

# Test H0: treatments are the same
#      H1: treatments are different


# Non-parametric alternative: wilcox.test

## One proportion 


# Do people ever regret getting a tattoo?
# In a 2012 poll by Harris Interactive, 
# 59 out of 423 respondents said yes. 
# Based on the data in this study, 
# find a 99% confidence interval the proportion of people 
# with tattoos who regret getting one. 

# use prop.test, conf.level = 0.99


# test p = 0.2 against p less than 0.2


## Two proportions


#  In a study about online dating, 
# 9 out of 40 males lied about their age
# and 5 out of 40 females lied about their age. Find a 95% confidence
# interval for the difference
# (% of men who lie about their age) - (% of women who lie about their age).

# use prop.test



# test H0: men and women lie at the same rate
# against H1: men lie more than women


## chi-squared tests of independence for categorical variables

# read in hsb2
library(openintro)
data(hsb2)

# a team of social scientists want to test 
# whether the distribution of `ses` depends on `race`

# visualize the data

# do a chi-squared test 




#############################
# Exploratory data analysis #
#############################

# read in http://vicpena.github.io/sta9750/spring19/nyc.csv
install.packages("GGally")
library(GGally)

# Create a figure that contains plots for all the pairs of variables 
#   in the dataset, except Case and Restaurant

# Provide a heatmap for the correlation 
#  between the numerical variables in the dataset. 


# Find examples of cheap restaurants that 
# have relatively good food and examples of 
# expensive restaurants that have relatively bad food 
