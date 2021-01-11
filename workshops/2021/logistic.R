# libraries
# install.packages("effects")
# install.packages("titanic")
# install.packages("gridExtra")
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
ggpairs(titanic_train)


# fit logistic regression models
logistic = glm(Survived ~ Pclass + Age + Sex, family = "binomial", data = titanic_train)
summary(logistic)
mod_inter = glm(Survived ~ Pclass*Age*Sex, family = "binomial", data = titanic_train)
summary(mod_inter)
mod_inter = glm(Survived ~ Age + Sex + Pclass + Age*Pclass, family = "binomial", data = titanic_train)
summary(mod_inter)

nullmod = glm(Survived ~ 1, family = "binomial", data = titanic_train)
fullmod = glm(Survived ~ Pclass*Age*Sex, family = "binomial", data = titanic_train)
# backward (criterion is AIC)
bwd = step(fullmod)
summary(bwd)
# forward
fwd = step(nullmod, 
     scope = list(upper = fullmod), 
     direction = "forward")
summary(fwd)
# stepwise regression
both = step(nullmod, 
           scope = list(upper = fullmod), 
           direction = "both")
summary(both)
# allEffects function to visualize the model
# visualize the effects of the variables
plot(allEffects(both))

# fitting regularized logistic regression
reg_logistic = train(
  Survived ~ Pclass*Age*Sex,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "glmnet",
  family = "binomial",
  trControl = trainControl (
    method = "cv"
  )
)
# plotting vips: variable importances
vip(reg_logistic)

# find average bootstrapped accuracy
confusionMatrix(reg_logistic)
# accuracy: estimates how often I classify right
# % of times that my model predicts correctly
# I estimate that my regularized logistic
# regression predicts correctly ~80%

# fit equivalent logistic regression
logistic = train(
  Survived ~ Sex + Pclass + Age + Sex:Pclass + Pclass:Age + 
    Sex:Age,
  titanic_train,
  preProc = c("center", "scale", "zv"),
  method = "glm",
  family = "binomial"
)

# plot vips & find average bootstrapped accuracy
vip(logistic)
confusionMatrix(logistic)
# estimated accuracy:       
# Accuracy (average) : 0.7977
# which is slightly smaller than the accuracy of the regularized
# regression


# append predictions
titanic_test = titanic_test %>% mutate(preds_log = predict(logistic, newdata = titanic_test, type = "prob"),
                                       preds_reg = predict(reg_logistic, newdata = titanic_test, type = "prob"))


ggplot(titanic_test) +
  aes(x = preds_log[,1], y = preds_reg[,1]) +
    geom_point() + geom_smooth()


