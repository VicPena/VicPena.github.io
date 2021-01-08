
nyc = read.csv("http://vicpena.github.io/sta9750/spring19/nyc.csv")

#############################
# Exploratory data analysis #
#############################

head(nyc)
str(nyc)
summary(nyc)

# Create a figure that contains plots for all the pairs of variables 
#   in the dataset, except Case and Restaurant

library(GGally)
library(dplyr)
ggpairs(nyc %>% select(Price, Food, Decor, Service, East))


# Provide a heatmap for the correlation 
#  between the numerical variables in the dataset. 

ggcorr(nyc %>% select(Price, Food, Decor, Service), label = TRUE)


# 	Find examples of cheap restaurants that 
# have relatively good food and examples of 
# expensive restaurants that have relatively bad food 
library(plotly)
plot = ggplot(nyc) +
  aes(x = Food, y = Price, label = Restaurant) +
  geom_point() +
  geom_text() +
  geom_smooth() 
plot
ggplotly(plot)

nyc %>% arrange(Food, Price)
qplot(Price, data = nyc)
# bad Price 65, Food 19, Rainbow Grill
# bad Price 47, Food 18, Coco Pazzo Teatro

nyc %>% arrange(desc(Food), desc(Price))
# good Gennaro, Price 34, Food 24
# good Sirabella's Price 36, Food 23

#############################
# Fitting regression models #
#############################

# fit a model where the outcome is `Price` 
# and the predictors are `Food`, `Decor`, `Service`, and `East`

mod = lm(Price ~ Food + Decor + Service + East, data = nyc)
mod
summary(mod)


# diagnostics 
plot(mod)
# 41 and 62

#  useful functions are `hatvalues`, `residuals`, and `rstandard`
# roughly, if the model fits correctly, 95% of the 
# std. residuals should be under 2
# leverage goes under the name "hatvalues"

# if you have an observation with high leverage (or high "hatvalue")
# that means that you're looking at an observation with a combination of
# predictors that is rare (it doesn't occur very often in the data)

# leverages allow me to identify "outliers" in the covariate space

# cooks distance combine both residuals and leverage
# observations with high residual are observations that are badly predicted
# by my model
# high leverage points have "weird" combinations of predictors / covariates (same thing)
cooksd = cooks.distance(mod)
qplot(cooksd) 
# we tend to look at observations that stick out


# 0. load the tidyverse (ggplot is in the tidyverse, so I need to load it)
library(tidyverse)
# 1. create a ggplot
qplot(cooksd)

# 2. append the cooksdistances to my data.frame
nyc$cooksd = cooksd
nyc %>% filter(cooksd > 0.1)

# high leverage points
nyc$hatvalues = hatvalues(mod)
nyc_leverage = nyc %>% filter(hatvalues > 0.15)
qplot(y = Restaurant, x = hatvalues, data = nyc_leverage)
nyc_leverage
qplot(y = Price, x = Food, data = nyc)
summary(nyc)

#############################
# Automatic model selection #
#############################

# more information here:
# https://cran.r-project.org/web/packages/olsrr/vignettes/variable_selection.html
install.packages("olsrr")
library(olsrr)

# all subsets
# Outcome: Price
# Possible covariates / predictors: Food, Decor, Service, East / West
mod = lm(Price ~ Food + Decor + Service + East, data = nyc)
allsubs = ols_step_all_possible(mod)
plot(allsubs)
# best subsets

# Backward, forward, and stepwise

# backward w/ p-values
# other option: AIC / Mallows' Cp

backward_p = ols_step_backward_p(mod) # backward selection using p-values
plot(backward_p)
mod_back = lm(Price ~ Food + Decor + East, data = nyc)
summary(mod_back)
plot(mod_back)
ols_step_backward_aic(mod) # backward selection using AIC
# backward slection with p-values and AIC coincide

# forward w/ p-values
# other option: AIC / Mallows' Cp
ols_step_forward_p(mod)
ols_step_forward_aic(mod, details = TRUE)

# stepwise/ p-values
# other option: AIC / Mallows' Cp
ols_step_both_aic(mod) # again, same model!!

# The model that is preferred by these methods is
# a model that has 
# Price as the outcome
# and Decor, Food, and East as the predictors


## Prediction

modfinal = lm(Price ~ Food + Decor + East, data = nyc)

# nyctest has data for some 
# Italian restaurants
# that weren't included in `nyc`.


nyctest = read.csv("http://vicpena.github.io/sta9750/spring19/nyctest.csv")



# We can find point predictions and 99\% prediction intervals as follows:
# convert object to data.frame

# column bind
nyctest = cbind(nyctest,predict(modfinal, newdata = nyctest, interval = "prediction", level = 0.99))

nyctest
library(plotly)

plot = ggplot(nyctest) +
  aes(x = preds, y = Price, label = Restaurant) + 
    geom_point() + geom_smooth(method = "lm")


# check whether prediction intervals trap the truth
nyctest %>% mutate(success = Price < upr & Price > lwr)
# success rate of ~ 95%
# since the success rate of 95% isn't very far off from the advertised 99%,
# I think the model seems to be a reasonable fit
#  we should know, though, that the intervals seem to be rather wide,
# so it might not be the most useful in practice

################
# Interactions #
################

# simply write the product
library(openintro)
data(hsb2)

str(hsb2)

# my goal is to find a model 
# that allows me to predict math scores
# given socioeconomic profile variables
# I want a model to predict math
# given variables gender, race, ses, schtyp, prog

mod = lm(math ~ gender + race + ses + schtyp + prog, data = hsb2)

# backward selection to trim down the model
ols_step_backward_p(mod, details = T)
mod_add = lm(math ~ race + ses + prog, data = hsb2)
  
mod_inter = lm(math ~ race + ses + prog + race*ses + race*prog + ses*prog, data = hsb2)
ols_step_backward_p(mod_inter, details = T)

mod_inter = lm(math ~ race + ses + prog + race*ses + race*prog + ses*prog, data = hsb2)

summary(mod_add)
mod_inter = lm(math ~ race + ses + prog + ses*race, data = hsb2)
summary(mod_inter) # the model that has the interaction that makes
# sense in context makes the adjusted R2 worse, so I keep the additive model
AIC(mod_add) # AIC of additive model (with no interaction)
AIC(mod_inter) # AIC with interaction
# AIC got worse (it got bigger; AIC is better when it's smaller)

# we use interaction terms when we suspect that 
# the effect of one variable on the outcome depends on the other
# an example here would be that the effect of race on math scores depends on 
# the socioeconomic status: something like in high socioeconomic status, 
# race may not have a strong effect on math scores, whereas in lower socioeconomic stata,
# the effect of race may be more noticeable

levels(factor(hsb2$race)) # the baseline in regression is always going to be the first level

# visualize the model
mod_add = lm(math ~ race + ses + prog, data = hsb2)
summary(mod_add)
plot(mod_add)
str(summary(mod_add))
# this will save regression table
# into a csv
write.csv(summary(mod_add)$coef, file = "~/Desktop/regres.csv")
library(GGally)
ggcoef(mod_add)
