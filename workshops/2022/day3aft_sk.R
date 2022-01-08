
#############################
# Fitting regression models #
#############################
# read in http://vicpena.github.io/sta9750/spring19/nyc.csv
nyc <- read_csv("http://vicpena.github.io/sta9750/spring19/nyc.csv")
nyc = nyc %>% mutate(Location = East)
# create subset with some variables
# select function: lets me get subsets of 
# variables in a dataset
nyc_sub = nyc %>% select(Price, Service, Decor, Food, East)

# load library(GGally)
library(GGally)

# ggpairs
ggpairs(nyc_sub)

# ggcorr (correlations)
# it only makes sense for numerical variables
# create a subset of the data that only includes
# the numerical variables
# with that, I will use ggcorr
nyc_num = nyc %>% select(Price, Service, Decor, Food)
ggcorr(nyc_num, label = TRUE)
# heatmap: intensity of the correlations


# Predict the Price of a meal given 
# and the predictors are `Food`, `Decor`, `Service`, and `East`
# lm: linear model (regression model)
mod = lm(Price ~ Food + Decor + Service + Location, data = nyc)
# outcome that I want to predict: Price
# after the tilde (~)
# I put in the predictors which are the variables that I
# will use to predict the outcome



# we can a regression table with the command
# summary
summary(mod)

# residuals: observed values - predicted values by model

# min: -13.7995
# there is a restaurant whose predicted Price is 
# $13.7995 more expensive than its actual observed Price

# max: 16.8484
# there is a restaurant whose predicted Price 
# is $16.8484 cheaper than its actual observed Price


# Estimates: Least-squares estimates
# of the coefficients

# Regression equation:

# Price = -23.644163 + 1.634869*Food + 1.875549*Decor + 0.007626*Service - 1.613350*LocationWest

# East side, regression equation:
# Price = -23.644163 + 1.634869*Food + 1.875549*Decor + 0.007626*Service 
# West side, regression equation:
# Price = (-23.644163 - 1.613350) + 1.634869*Food + 1.875549*Decor + 0.007626*Service 

# LocationWest = 1 if restaurant is on the West side 
#                  and it's 0 on the East side

# null: all coefficients are zero
# alternative: there is at least a coefficient
#              that is non-zero
# p-value: 2.2*10^(-16)


# predict: allows us to make predictions for any new restaurants



# model diagnostics
plot(mod)
# fitted vs residuals: if the assumptions of the 
# model are met you should see a cloud of points
# with no discernible patterns
# used to detect deviations from linearity

# Linear model has assumption
# Linearity: there is an underlying linear trend in the data
# Independence: the errors do not depend upon each other
# Normality: the errors are normal 
# Equality of variance (homoskedasticity): the variance of the error does not depend on x

# Linearity: residuals vs fitted; if assumption satisfied we see a cloud of points
# with no discernible patters

# Independence: we usually don't check unless we have a time variable

# Normality: we check with the qq-plot; if the points are 
# near the dashed line, then the assumption is met

# Equality of variances: we usually check with residuals vs 
# fitted; if the assumption is satisfied, we see that the spread
# on the y-axis doesn't depend on where we are on the x-axis



ggplot(nyc) +
  aes(y = Price, x = Food) +
      geom_point() +
        geom_smooth(method = "lm")

# residuals vs fitted values
# observed - predicted
# fitted: line itself



# qq-plot: is used to assess the assumption of 
# normality of residuals. if the assumption is met
# then the points should be near the line
# in this case, the plot is good; the points are 
# near the line
# if normality is not satisfied, you see an S shaped
# plot

# sqrt(abs(standardized residuals)) against fitted values
# the interpretation is the same as the interpretation of the 
# first one


# hatvalues: used for identifying usual combiations of the predictors
# if an observation has a large hatvalue it means that its 
# predictors are unusual in some sense

# two points that have unsual combinations of predictors

# add a column to our dataset with the hat values
nyc = nyc %>% mutate(hatvalues = hatvalues(mod))
# and then filter and identify the restaurants
nyc %>% filter(hatvalues > 0.20)
# we can take a look at the values of their predictors
# and understand why they are unusual

# Food, Decor, Service, Location
summary(nyc)
# Veronica: Very small value of Decor (min in the sample)
#           but its quality of Food is very good and the Service
#           is also very bad (min in the sample)

# Gennaro: Small values of Decor and Service  but good quality of Food 
# predict

# useful for making predictions without having to use the 
# regression equation manually

# Suppose that I want to predict the price of a meal
# in the following two restaurants

# restaurant 1: Food = 20, Service = 14, Decor = 23, Location = "West"
# restaurant 2: Food = 14, Service = 24, Decor = 24, Location = "East"

# 1st. define a data.frame which has the data for the new restaurants
newrest = data.frame(Food = c(20, 14),
                     Service = c(14, 24),
                     Decor = c(23, 24),
                     Location = c("West", "East"))

newrest

# 2nd. using predict
predict(mod, newdata = newrest, interval = "prediction", level = 0.99)
# prediction intervals for the prices
# if you want 0.95 you can change that to 0.95 
# (or don't write anything, because 0.95 is the default value)



# effect plots with library(jtools)
# install.packages("jtools")
library(jtools)
effect_plot(mod, Food)
# set the numerical variables
# to the averages in the sample
# and the categorical variables to their baseline
# and visualize the effect of Food on the outcome

effect_plot(mod, Location)
# no interactions
# this gives me predicted values for East and West
# along with 95% confidence intervals



#############################
# Automatic model selection #
#############################

# backward selection
# start out with all the variables
# under consideration 
# and drop variables one by one until 
# my model gets worse according to some criterion

# a criterion to score the model 
# by default R uses AIC (Akaike Information Criterion)
# AIC: is a criterion that was developed to select
# the best model for prediction (under certain
# theoretical conditions)
mod_all_variables = lm(Price ~ Food + Service + Decor + Location, data = nyc)
bwd_AIC = step(mod_all_variables, direction = "backward")
# The smaller the AIC, the better
# Starting AIC: 526.64
summary(bwd_AIC)




mod_no_variables = lm(Price ~ 1, data = nyc)
summary(mod_no_variables)
fwd_AIC = step(mod_no_variables,
               scope = formula(mod_all_variables),
               direction = "forward")

# stepwise regression
# where you start with nothing (like forward)
# and then at each step you can either add or drop variables
stepwise_AIC = step(mod_no_variables,
               scope = formula(mod_all_variables),
               direction = "both")
summary(stepwise_AIC)


################
# Interactions #
################

# simply write the product
# Quality of Food and Location
# The effect of quality of food on the Price
# is dependent on whether the restaurant is on the East
# or the West side
mod_inter = lm(Price ~ Food + Food*Location + Location + Decor + Service,
               data = nyc)

summary(mod_inter)
# a different slope for Food for restaurants on the West side
# slope for Food on the East side: 1.67086
# slope for Food on the West side: 1.67086-0.09881

# use interact_plot in library(interactions)
# to visualize interaction
library(interactions)
interact_plot(mod_inter, Food, Location)
# setting all the other variables to their 
# average in the sample
# we can visualize the interaction effect
mod_inter2 = lm(Price ~ Food + Location*Service + Location + Decor + Service,
               data = nyc)
interact_plot(mod_inter2, Service, Location)
summary(mod_inter2)

# mediation analysis can be done in R
# product test
# bootstrap test
# 

