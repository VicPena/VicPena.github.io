# install.packages("GGally")
# install.packages("caret")
# install.packages("tidyverse")
# install.packages("glmnet")
# install.packages("vip")
# install.packages("rsample")
# install.packages("openintro")
# install.packages("ISLR2")
library(GGally) # some useful graphics
library(caret) # automatic model tunning, cross-validation
library(tidyverse) # plots, data-wrangling functions
library(glmnet) # regularized regression
library(vip) # variance importance plots
library(rsample) # splitting data
library(openintro) # hsb2 data
library(ISLR2) # College data

# screencap to this: 
# https://stats.stackexchange.com/questions/67736/equivalence-between-elastic-net-formulations

##########################
# predicting math scores #
##########################

library(openintro)
data(hsb2)
hsb2 = hsb2 %>% select(-id)

# split the data randomly into training and test
set.seed(123) # this ensures that we get the same random split
split = initial_split(hsb2, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)


# run regularized regression: elastic net
regularized_reg = train(
  math ~ .,
  train,
  preProc = c("center", "scale", "zv"),
  method = "glmnet",
  metric = "RMSE",
  trControl = trainControl (
    method = "cv"
  )
)

# find coefficients
coef(regularized_reg$finalModel, regularized_reg$finalModel$lambdaOpt)

# find variable importances
vip(regularized_reg)
# relative absolute size of coefficients

# fit linear regression model without
# regularization




# predict  outcomes in test set
# use predict function

# find mean squared error




# plot predictions on test set against observed values

################
# College data #
################

#  predict the number of applications received
# using the other variables in the College data set
library(ISLR2)
data(College)
?College
glimpse(College)

# split the data randomly into training and test
# 70% training, 30% testing




# run regularized regression: elastic net


# find coefficients

# find variable importances


# fit linear regression model without
# regularization




# predict outcomes in test set


# find mean squared error

# plot predictions on test set against observed values



