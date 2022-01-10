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
library(oenintro) # hsb2 data
library(ISLR2) # College data

# email: victor.pena@baruch.cuny.edu
# come back at 2pm
# logistic regression and regularized logistic regression
#



##########################
# predicting math scores #
##########################

library(openintro)
data(hsb2)
hsb2 = hsb2 %>% select(-id)

# goal: predict the math scores 
# given the other variables


# split the data randomly into training and test
set.seed(123) # this ensures that we get the same random split

install.packages("rsample") # install package
library(rsample) # splitting data
split = initial_split(hsb2, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)

# training set to fit models 
# test set to evaluate the predictive performance of the models

# elastic net

library(caret)
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

regularized_reg

# math ~ .
# this is going to fit a model where math is the outcome
# and the rest of the variables in the dataset are going to 
# be predictors

# preProc: pre-procesing
# center the data, scale, it removes variables that have zero variance
# centering and scaling is important in regularized regression
# models because the regularization parameters are common to all variables
# so they hve to be on comparable scales

# method = "glmnet": fit the elastic net model

# metric = "RMSE" metric used for assessing model performance
# in choosing the best parameters

# find coefficients
coef(regularized_reg$finalModel, regularized_reg$finalModel$lambdaOpt)
# coefficients beta

# find variable importances
# quantify the relative importance of the variables
vip(regularized_reg)
# relative absolute size of coefficients
# highest coefficient in absolute value is going 
# be 100%
# the other variable importances are 
# variable importance 100*abs(beta)/max abs(beta)


# fit linear regression model without
# regularization
# usual OLS estimates
mod_lm = lm(math ~ . , data = train)
# . : everything in train goes in as predictors
summary(mod_lm)

# use the test set, which we haven't touched yet
# to compare the performance of the 
# regularized regression model to the 
# regression model without regularization



# predict outcomes in test set
# use predict function

# create a two new columns to our data
# which are going to contain the 
# predictions with the models
library(tidyverse)
test = test %>% mutate(pred_reg = predict(regularized_reg, newdata = test),
                       pred_lm = predict(mod_lm, newdata = test))

# we are comparing two models
# - regularized regression model
# - nonregularized regression model

# find mean squared error
test %>% summarize(MSE_reg = mean((math-pred_reg)^2),
                   MSE_lm = mean((math-pred_lm)^2))

# MSE regularized regression model 41.0
# MSE usual OLS estimates, linear model 42.4


# plot predictions on test set against observed values
ggplot(test) +
  aes(x = pred_reg, y = math) +
    geom_point()



################
# College data #
################

#  predict the number of applications received
# using the other variables in the College data set
install.packages("ISLR2")
library(ISLR2)
# Introduction to Statistical Learning in R
data(College)
?College
glimpse(College)

# split the data randomly into training and test
# 70% training, 30% testing: fairly popular way of splitting data
# 65% - 35% (bigger datasets)
# 60% - 40% (very large data)
# Most people use smaller testing sets
# when their datasets are small
# and larger testing sets when their
# datasets are big

# training set: the dataset that is used for training 
# your models, so you want to be fairly big
# for your models to have predictive power

# test set: if you have a test set that is small
# your model comparison is not going to be very
# dependable
# the larger the test set, the better the model
# comparison gets





# 1st step. split the data into training and test sets
split = initial_split(College, prop = 0.7) 
train = training(split) # 70% training
test = testing(split)

# fit regularized regression elastic net
regularized_reg = train(
  Apps ~ ., # formula for the model that you want to fit
  train, # dataset that is used for model fitting
  preProc = c("center", "scale", "zv"), # pre-processing
  method = "glmnet", # method = "glmnet" is the elastic net
  metric = "RMSE", # metric we use to evaluate models in CV
  trControl = trainControl (
    method = "cv" # I want to estimate the regularization parameters using CV
  )
)

# we can take a look at the coefficients
coef(regularized_reg$finalModel, regularized_reg$finalModel$lambdaOpt)
# tells me what the coefficients beta are
# whenever you see a "." that means that the coefficient is 0

# fit usual linear regression model
mod_lm = lm(Apps ~ . , data = train) # lm command fits linear models in R
summary(mod_lm) # gets me the regression table


# after this, we have fitted models on the
# training set

# our goal now is to compare them in the test set
# which we set apart just for that purpose


# make predictions with the test set
# and compare Mean Squared Error for these models
# test: assessing and comparing model performance

# test: attach predictions with the lm model
# and the elastic net model
test = test %>% mutate(pred_reg = predict(regularized_reg, newdata = test),
                       pred_lm = predict(mod_lm, newdata = test))


# compute MSE
test %>% summarize(MSE_reg = mean((Apps-pred_reg)^2),
                   MSE_lm = mean((Apps-pred_lm)^2))
# MSE with the regularized regression model
# is again, smaller than the MSE with the usual linear regression model
# which has OLS estimates

