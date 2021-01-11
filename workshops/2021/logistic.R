# libraries
# install.packages("effects")
# install.packages("titanic")
library(effects) # plotting effects
library(titanic) # titanic data
library(tidyverse)
library(caret) 
library(gridExtra) # arrange ggplots

set.seed(12345)

data("titanic_train")
data("titanic_test")

titanic_train = titanic_train %>% 
  select(Survived, Pclass, Age, Sex) %>%
  mutate(Survived = as.factor(Survived),
         Pclass = as.factor(Pclass)) %>%
  na.omit() 

titanic_test = titanic_test %>% 
  select(Pclass, Age, Sex) %>%
  mutate(Pclass = as.factor(Pclass)) %>%
  na.omit() 

# plot data



# fit logistic regression models



# fitting regularized logistic regression

# plotting vips

# find average bootstrapped accuracy

# fit equivalent logistic regression


# plot vips & find average bootstrapped accuracy

# append predictions

#####################
# interfaith dating #
#####################

# read in http://VicPena.github.io/workshops/2021/interfaith.csv

# split into test and train


# predict interfaith dating status given other vars

# plotting effects


# fit model using caret