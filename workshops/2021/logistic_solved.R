################
# Titanic data #
################

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
ggpairs(titanic_train)


# fit logistic regression models
nullmod = glm(Survived ~ 1, family = "binomial", data = titanic_train)
fullmod = glm(Survived ~ Pclass*Age*Sex, family = "binomial", data = titanic_train)

bwd = step(fullmod) # backward selection
fwd = step(nullmod,
           scope = list(upper = fullmod),
           direction = "forward")  # fwd selection
both = step(nullmod,
            scope = list(upper = fullmod),
            direction = "both")  # fwd selection
# plotting effects
plot(allEffects(bwd))

# fitting regularized logistic regression
reg_logistic = train(
  Survived ~ Pclass*Age*Sex, 
  titanic_train,
  method = "glmnet",
  family = "binomial",
  trControl = trainControl(
    method = "cv", 
  )
)
# plotting vips
vip(reg_logistic)
# find average accuracy
confusionMatrix(reg_logistic)

# fit equivalent logistic regression
logistic = train(
  Survived ~ Pclass*Age*Sex, 
  titanic_train,
  method = "glm",
  family = "binomial",
  trControl = trainControl(
    method = "cv", 
  )
)
vip(logistic)
confusionMatrix(logistic)


# append predictions
titanic_test = titanic_test %>% 
  mutate(preds_reg = predict(reg_logistic, newdata = titanic_test, type = "prob"),
         preds_lm = predict(logistic, newdata = titanic_test, type = "prob"))


#####################
# interfaith dating #
#####################

# read in http://VicPena.github.io/workshops/2021/interfaith.csv

interfaith <- read_csv("http://VicPena.github.io/workshops/2021/interfaith.csv")
interfaith %>% select(-X1) %>% ggpairs
interfaith = interfaith %>% mutate(inter = ifelse(interfaith == "yes", 1, 0))


set.seed(12345)
library(rsample)
split = initial_split(interfaith, prop = 0.7)
train = training(split)
test = testing(split)

# predict interfaith dating status given other vars
nullmod = glm(inter ~ 1, family = "binomial", data = train)
fullmod = glm(inter ~ ses*religion*gender, family = "binomial", data = train)

bwd = step(fullmod) # backward selection
fwd = step(nullmod,
           scope = list(upper = fullmod),
           direction = "forward")  # fwd selection
both = step(nullmod,
            scope = list(upper = fullmod),
            direction = "both")  # fwd selection
# plotting effects
plot(allEffects(bwd))

logistic = train(
  as.factor(inter) ~ religion + gender + religion:gender, 
  train,
  method = "glm",
  family = "binomial",
  trControl = trainControl(
    method = "cv", 
  )
)

confusionMatrix(logistic)

