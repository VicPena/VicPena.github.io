install.packages("GGally")
install.packages("caret")
install.packages("tidyverse")
install.packages("glmnet")
install.packages("vip")
install.packages("rsample")
library(GGally) # some useful graphics
library(caret) # automatic model tunning
library(tidyverse) # plots, data-wrangling functions
library(glmnet) # regularized regression
library(vip) # variance importance plots
library(rsample) # splitting data

##############################
# Italian restaurants in NYC #
##############################
# read in http://vicpena.github.io/workshops/2021/nycrest.csv
# nyc dataset: Italian restaurants in nyc

# split the data randomly into training and test
set.seed(123)





# run regularized regression

# variable importance plot

# run vanilla linear regression 


# predict prices of restaurants in test set
# given their Decor, Food, EastWest, and Service

# find mean squared error

# plot predictions against actual prices

############
# mpg data #
############

data(mpg)
?mpg


# goal is to predict hwy given other variables
# excluding manufacturer and model from
# regression




# explore data with ggpairs and ggcorr


# run regularized regression

# variable importance plot

# run vanilla linear regression

# predict hwy in test set

# find MSE

# plot predictions against actual prices


