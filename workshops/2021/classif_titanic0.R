# read in Titanic data
library(caret)
library(glmnet)

titanic_train <- read_csv("http://vicpena.github.io/workshops/2021/titanic_train.csv")
titanic_test <- read_csv("http://vicpena.github.io/workshops/2021/titanic_test.csv")

# convert Survived into factor (otherwise caret won't run the algorithms...)
# factor is a data-type in R which is used to encode categorical data
library(tidyverse)
titanic_train = titanic_train %>% mutate(Survived = as.factor(Survived))
titanic_test = titanic_test %>% mutate(Survived = as.factor(Survived))

# fit logistic reg with all interactions
mod_inter = glm(Survived ~ Pclass*Age*Sex, family = "binomial", data = titanic_train)
summary(mod_inter)
# do backward selection with AIC
bwd = step(mod_inter)
summary(bwd)

# fit regularized logistic regression (elastic net) with all interactions
library(caret)
reg_logistic = train(
  Survived ~ Pclass*Age*Sex,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "glmnet",
  family = "binomial",
  trControl = trainControl(
    method = "cv"
  )
)
# take look at variable importance plots
library(vip)
vip(reg_logistic)

# do the same with logistic reg model w/ predictors selected by bwd selection
# so we can compare vips
# install.packages("e1071") if you don't have it

logistic = train(
  Survived ~ Pclass + Age + Sex + Pclass:Sex + Age:Sex,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "glm",
  family = "binomial",
  trControl = trainControl(
    method = "cv"
  )
)
vip(logistic)


# append predictions
titanic_test = titanic_test %>% mutate(preds_reg = predict(reg_logistic, newdata = titanic_test, type = "raw"),
                        preds_log = predict(logistic, newdata = titanic_test, type = "raw"))

predict(reg_logistic, newdata = titanic_test, type = "raw")
predict(reg_logistic, newdata = titanic_test, type = "prob")

# if we wanted a model that has better
# sensitivity; that is, a model that is 
# better at catching 1s, we could have
# a lower threshold for saying "1" than 0.5
prob = predict(reg_logistic, newdata = titanic_test, type = "prob")
head(predict(reg_logistic, newdata = titanic_test, type = "prob"))
predict(reg_logistic, newdata = titanic_test, type = "raw")


# setting threshold for calling a 1 to "thresh"
thresh = 0.3
newpreds = 1*(prob[,2] > thresh)
# need to change to factor, otherwise the function doesn't run
confusionMatrix(as.factor(newpreds), titanic_test$Survived, positive = "1")
confusionMatrix(titanic_test$preds_reg, titanic_test$Survived, positive = "1")



# confusion matrices: first predictions, then actual 
confusionMatrix(titanic_test$preds_reg, titanic_test$Survived, positive = "1")
confusionMatrix(titanic_test$preds_log, titanic_test$Survived, positive = "1")

knnmodel = train(
  Survived ~ Pclass + Age + Sex,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "knn",
  trControl = trainControl(
    method = "cv"
  )
)

knnmodel
titanic_test = titanic_test %>% mutate(preds_knn = predict(knnmodel, newdata = titanic_test, type = "raw"))
confusionMatrix(titanic_test$preds_knn, titanic_test$Survived, positive = "1")

# rpart is for regression trees
# install.packages("rpart")

tree = train(
  Survived ~ Pclass + Age + Sex,
  titanic_train,
  method = "rpart",
  trControl = trainControl(
    method = "cv"
  )
)
tree
?rpart

# install.packages("rattle") # the package that has functions that
# allow me to plot the tree
library(rattle)
fancyRpartPlot(tree$finalModel)

# more references about criteria for splitting and stopping
# Elements of Statistical Learning
# Wiki for CART: https://en.wikipedia.org/wiki/Decision_tree_learning

titanic_test = titanic_test %>% mutate(preds_tree = predict(tree, newdata = titanic_test, type = "raw"))
confusionMatrix(titanic_test$preds_tree, titanic_test$Survived, positive = "1")



