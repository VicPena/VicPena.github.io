
#############################
# Fitting regression models #
#############################

# fit a model where the outcome is `Price` 
# and the predictors are `Food`, `Decor`, `Service`, and `East`

# model diagnostics

# effect plots with library(jtools)
install.packages("jtools")
library(jtools)


#############################
# Automatic model selection #
#############################

# backward selection

# forward selection
# fwd = step(mod_null,
#            scope = formula(mod_full),
#            direction = "forward")

# stepwise selection


##############
# Prediction #
##############

# Predict `Price` for restaurants:
# Mario's: Food = 20, Decor = 20, Service = 19, East side
# Luigi's: Food = 15, Decor = 23, Service = 23, West side

# predict(mod, newdata, interval = "prediction", level)


################
# Interactions #
################

# simply write the product

# fit model that predicts Price 
# given Food and interaction with East 


# use interact_plot in library(interactions)
# to visualize interaction




