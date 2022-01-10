# libraries
# install.packages("effects")
# install.packages("titanic")
# install.packages("gridExtra")
library(effects) # plotting effects
library(titanic) # titanic data
library(tidyverse)
library(caret) 
library(gridExtra) # arrange ggplots
library(ISLR2)

################
# Default data #
################

set.seed(12345)
data("Default")
?Default

# split the data randomly into training and test
set.seed(123) # this ensures that we get the same random split
split = initial_split(Default, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)


# plot training data w/ ggpairs

# fit logistic regression models

# do backward selection with model that has all 
# pairwise interactions

# plot effects with effect_plot



# fitting regularized logistic regression
reg_logistic = train(
  default  ~ student*balance*income,
  train,
  preProc = c("center", "scale", "zv"),
  method = "glmnet",
  family = "binomial",
  trControl = trainControl (
    method = "cv"
  )
)
# plotting vips: variable importances

# find coefficients
coef(reg_logistic$finalModel, reg_logistic$finalModel$lambdaOpt)

# find accuracy

# fit equivalent logistic regression
logistic = train(
    default  ~ student*balance*income,
    train,
    preProc = c("center", "scale", "zv"),
    method = "glm",
    family = "binomial",
    trControl = trainControl (
      method = "cv"
    )
)


# plot vips 

# find coefficients

# find accuracy


# find predictions

# find boxplot of prob predictions versus observed outcomes

# find grouped by means and sd of prob predictions versus observed outcomes

# find confusion table for threshold 0.5


###############
# Boston data #
###############

# Goal: predicting if a suburb is high crime

data(Boston)
?Boston

# chas should be converted into factor
Boston$chas = as.factor(Boston$chas)

# Outcome variable
Boston = Boston %>% 
  mutate(highcrim = as.factor(ifelse(crim > median(crim), "yes", "no"))) 


# Exclude "crim"
Boston = Boston %>% select(-crim)

# split into training 70% and test 30%

# fitting regularized logistic regression
# include linear terms only (could include interactions with chas)

# also fit logistic regression
# include linear terms only (could include interactions with chas)



# plot vips 

# find coefficients

# find accuracy


# find predictions

# find boxplot of prob predictions versus observed outcomes

# find grouped by means and sd of prob predictions versus observed outcomes

# find confusion table for threshold 0.5

