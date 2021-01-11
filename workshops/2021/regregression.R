install.packages("GGally")
install.packages("caret")
install.packages("tidyverse")
install.packages("glmnet")
install.packages("vip")
install.packages("rsample")
library(GGally) # some useful graphics
library(caret) # automatic model tunning, cross-validation
library(tidyverse) # plots, data-wrangling functions
library(glmnet) # regularized regression
library(vip) # variance importance plots
library(rsample) # splitting data

##############################
# Italian restaurants in NYC #
##############################
# read in http://vicpena.github.io/workshops/2021/nycrest.csv
# nyc dataset: Italian restaurants in nyc

library(readr)
nycrest <- read_csv("http://vicpena.github.io/workshops/2021/nycrest.csv")

# split the data randomly into training and test
set.seed(123) # this ensures that we get the same random split
split = initial_split(nycrest, prop = 0.7) # 70% training, 30% testing
train = training(split)
test = testing(split)
# stratified sampling, which respects the structure of the
# data

# use ggpairs to explore the data
train %>% select(Price, Food, Service, Decor, East) %>% ggpairs
# use ggcorr to find correlations among numerical variables
# heatmap which uses color-coding to quantify how big the correlations are
train %>% select(Price, Food, Service, Decor) %>% ggcorr(label = TRUE)
# train %>% select(Price, Food, Service, Decor) %>% ggcorr()

# Our goal is going to be 
# predict the price of a meal, given the quality of the food
# service, decor, and the variable that tells me whether the
# restaurant is on the East or West side

# run regularized regression
# a specific kind of regularized regression, which is called
# the elastic net
# it combines the lasso (absolute value penalty) with ridge (squared error
# penalty)
regularized_reg = train(
  Price ~ Food + Decor + Service + East,
  train,
  preProc = c("center", "scale"),
  method = "glmnet",
  metric = "RMSE",
  trControl = trainControl (
    method = "cv"
  )
)

# variable importance plot
vip(regularized_reg)

# run vanilla linear regression 
mod_lm = lm(Price ~ Food + Decor + Service + East, data = train)

# predict prices of restaurants in test set
# given their Decor, Food, EastWest, and Service
test = test %>% mutate(preds_reg = predict(regularized_reg, newdata = test),
                preds_lm = predict(mod_lm, newdata = test))

# find mean squared error
test %>% summarize(MSE_reg = mean((preds_reg-Price)^2),
                   MSE_lm = mean((preds_lm-Price)^2),
                   MAE_reg = mean(abs(preds_reg - Price)),
                   MAE_lm = mean(abs(preds_lm-Price)))

# plot predictions against actual prices
# install.packages("plotly")
library(plotly)

plot = ggplot(test) +
  aes(x = preds_reg, y = Price, label = Restaurant) +
    geom_point() +
      geom_smooth(method = "lm")

ggplotly(plot)


plot_lm = ggplot(test) +
  aes(x = preds_lm, y = Price, label = Restaurant) +
  geom_point() +
  geom_smooth(method = "lm")
ggplotly(plot_lm)



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

# predict hwy in test set

# find MSE

# plot predictions against actual prices


