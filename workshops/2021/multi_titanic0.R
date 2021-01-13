# read in Titanic data
library(tidyverse)
library(readr)
titanic_train = read_csv("http://vicpena.github.io/workshops/2021/titanic_train.csv")
titanic_test = read_csv("http://vicpena.github.io/workshops/2021/titanic_test.csv")

# convert Pclass and Survived into factor (otherwise caret won't run the algorithms...)
titanic_train = titanic_train %>% mutate(Pclass = as.factor(Pclass),
                                         Survived = as.factor(Survived))
titanic_test = titanic_test %>% mutate(Pclass = as.factor(Pclass),
                                       Survived = as.factor(Survived))


# fit k-nn to predict PClass given age and sex
library(caret)


# fit regression tree
# install.packages("rattle")
library(rattle) # needed for displaying regression trees

# find vip and plot tree


# fit random forest

# get vips



# append predictions

# confusion matrices
