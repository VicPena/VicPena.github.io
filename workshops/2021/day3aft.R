
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

#  useful functions are `hatvalues`, `residuals`, and `rstandard`

#############################
# Automatic model selection #
#############################

# more information here:
# https://cran.r-project.org/web/packages/olsrr/vignettes/variable_selection.html

library(olsrr)

# all subsets

# best subsets

# Backward, forward, and stepwise

# backward w/ p-values
# other option: AIC / Mallows' Cp


# forward w/ p-values
# other option: AIC / Mallows' Cp

# stepwise/ p-values
# other option: AIC / Mallows' Cp

## Prediction


# nyctest has data for some 
# Italian restaurants
# that weren't included in `nyc`.


nyctest = read.csv("http://vicpena.github.io/sta9750/spring19/nyctest.csv")



# We can find point predictions and 99\% prediction intervals as follows:
# convert object to data.frame

# append actual prices


# preds versus actual

################
# Interactions #
################

# simply write the product
library(openintro)
data(hsb2)


# visualize the model

