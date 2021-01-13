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


# fit k-nn to predict PClass given age, sex, and Survived 
library(caret)
knnmodel = train(
  Pclass ~ Survived + Age + Sex,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "knn",
  trControl = trainControl(
    method = "cv"
  )
)
knnmodel




# fit regression tree
# install.packages("rattle")
library(rattle) # needed for displaying regression trees
treemodel = train(
  Pclass ~ Survived + Age + Sex,
  titanic_train,
  method = "rpart",
  trControl = trainControl(
    method = "cv"
  )
)
# find vip and plot tree
library(rattle)
fancyRpartPlot(treemodel$finalModel)
library(vip)
vip(treemodel)



# fit random forest
# install.packages("randomForest")
library(randomForest)
randomf = train(
  Pclass ~ Survived + Age + Sex,
  titanic_train,
  method = "rf",
  trControl = trainControl(
    method = "cv"
  )
)
# get vips
vip(randomf)



# append predictions
titanic_test = titanic_test %>% mutate(pred_knn = predict(knnmodel, newdata = titanic_test, type = "raw"),
                                       pred_tree = predict(treemodel, newdata = titanic_test, type = "raw"),
                                       pred_rf =  predict(randomf, newdata = titanic_test, type = "raw"))

# confusion matrices
# first I put the predictions
# then I'll put the actual values 
confusionMatrix(titanic_test$pred_knn, titanic_test$Pclass)
confusionMatrix(titanic_test$pred_tree, titanic_test$Pclass)
confusionMatrix(titanic_test$pred_rf, titanic_test$Pclass)

prds = predict(treemodel, newdata = titanic_test, type = "prob")
# can construct all sorts of rules that allow me
# to tune the specificity for class 2, say

selection_class = function(x) {
  if (order(x)[2] == 2 | order(x)[3] == 2) {
    2
  }
  else {
    order(x)[3]
  }
}

selection_class2 = function(x) {
  if ( x[2] > 0.22 ) { 
     2
  }
  else {
    order(x)[3]
  }
}

titanic_test = titanic_test %>% mutate(class2 = as.factor(apply(prds, 1, selection_class2)))
confusionMatrix(titanic_test$class2, titanic_test$Pclass)


library(ISLR)
data(Default)
# we're splitting data into 
# training and test sets
# we will train models on the training data
# and then we'll test their predictive performance
# on the test data, which we didn't use to fit the models

library(rpart) # the library for regression trees 
# trees split the data into different categories

library(rsample) # library for splitting
set.seed(123) # this ensures that we get the same random split
split = initial_split(Default, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)

library(GGally)
train %>% ggpairs

# the idea is to build models to predict Default
# given student, balance, income 
treemodel = train(
  default ~ student + balance + income,
  train,
  method = "rpart",
  trControl = trainControl(
    method = "cv"
  )
)
vip(treemodel)
fancyRpartPlot(treemodel$finalModel)

knnmodel = train(
  default ~ student + balance + income,
  train,
  preProc = c("center", "scale", "zv"),
  method = "knn",
  trControl = trainControl(
    method = "cv"
  )
)
knnmodel

# reg logistic
regmodel = train(
  default ~ student + balance + income,
  train,
  preProc = c("center", "scale", "zv"),
  method = "glmnet",
  family = "binomial",
  trControl = trainControl(
    method = "cv"
  )
)
vip(regmodel)


# assess performance of these models (tree model, knn model, reg regression)
# on the test data
# add predictions to the test set
test = test  %>% mutate(pred_knn = predict(knnmodel, newdata = test, type = "raw"),
                 pred_tree = predict(treemodel, newdata = test, type = "raw"),
                 pred_reg =  predict(regmodel, newdata = test, type = "raw"))

# start with the predictions, and then put in the actual values
confusionMatrix(test$pred_knn, test$default, positive = "Yes")
confusionMatrix(test$pred_tree, test$default, positive = "Yes")
confusionMatrix(test$pred_reg, test$default, positive = "Yes")


qplot(predict(regmodel, newdata = test, type = "prob")[,1])

probs_paying = predict(regmodel, newdata = test, type = "prob")[,1]
probs_paying = 1*(probs_paying > 0.75)
probs_paying


thresh = 0.1
probs_default =  predict(regmodel, newdata = test, type = "prob")[,2]
pred_default = 1*(probs_default > thresh)
# we need to convert to factor
pred_default = as.factor(pred_default)
levels(pred_default) = c("No", "Yes")
confusionMatrix(pred_default, test$default, positive = "Yes")
