#' ---
#' title: "Linear regression with `R` "
#' author: "Víctor Peña"
#' output:
#'   html_document:
#'     toc: true
#'     theme: cosmo
#' ---
#' 
#' 
#' 
#' ---
#' # Commenting out some stuff
#' ---
#' 
#' ---
#' # Don't print messages, errors, warnings
#' ---
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(error = FALSE, message = FALSE, warning = FALSE)

#' 
#' # Reviews of Italian restaurants in Manhattan
#' 
#' 
## ---- echo = FALSE-------------------------------------------------------
nyc = read.csv("~/spring19/STA9750/nyc.csv")

#' 
#' We'll analyze a dataset in Sheather (2009) that has information about 150 Italian restaurants in Manhattan that were open in 2001 (some of them are closed now). The variables are:
#' 
#' * `Case`: case-indexing variable 
#' 
#' * `Restaurant`: name of the restaurant
#' 
#' * `Price`: average price of a meal and a drink 
#' 
#' * `Food`: average [Zagat](www.zagat.com) rating of the quality of the food (from 0 to 25)
#' 
#' * `Decor`: same as above, but with quality of the decor 
#' 
#' * `Service`: same as above, but with quality of service
#' 
#' * `East`: it is equal to `1` if the restaurant is on the East Side (i.e. east of Fifth Ave)
#' 
#' In our analysis, the response variable will be `Price`. 
#' 
#' ## Exploratory data analysis
#' 
#' The function `pairs` creates a scatterplot matrix:
#' 
## ------------------------------------------------------------------------
pairs(nyc[,-c(1,2)])

#' 
#' I wrote `nyc[,-c(1,2)]` instead of `nyc` so that the first two variables, `Case` and `Restaurant`, are not plotted.
#' 
#' We can get quick and dirty summaries of the variables with `summary`:
#' 
## ------------------------------------------------------------------------
summary(nyc[,-c(1,2)])

#' 
#' The function `ggpairs` in `library(GGally)` produces the equivalent plot, but with `ggplot2`:
#' 
## ---- message=FALSE------------------------------------------------------
library(GGally)
ggpairs(nyc[,-c(1,2)])

#' 
#' Do you see any interesting patterns?
#' 
#' ## Fitting regression models with the `lm` function
#' 
#' Fitting regression models with `R` is easy. For example, we can fit a model where the outcome is `Price` and the predictors are `Food`, `Decor`, `Service`, and `East` with the code
#' 
## ------------------------------------------------------------------------
mod = lm(Price ~ Food + Decor + Service + East, data = nyc)

#' 
#' Calling the object `mod` only gives us coefficients:
#' 
## ------------------------------------------------------------------------
mod

#' 
#' If we want $p$-values, $R^2$, and more, we can get them with `summary()`:
#' 
## ------------------------------------------------------------------------
summary(mod)

#' 
#' We can get diagnostic plots by `plot`ting the model. That will give us 4 diagnostic plots. We can arrange them in a figure with 2 rows and 2 columns with `par(mfrow=c(2,2))`:
#' 
## ------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(mod)

#' 
#' If, for some reason, we want them in 1 row and 4 columns:
#' 
## ------------------------------------------------------------------------
par(mfrow=c(1,4))
plot(mod)

#' 
#' The instruction `par(mfrow=c(<rows>, <columns>)` isn't specific to "models". We can use it to arrange figures with multiple rows and columns of plots in `library(graphics)`. Unfortunately, it doesn't work with `ggplot2`. The analogue instruction for `ggplot2` is `grid.arrange` (see `ggplot2` handout for examples).
#' 
#' We can extract diagnostics from `mod`. For example, if we want to extract Cook's distances and plot them against observation number, we can use:
#' 
## ------------------------------------------------------------------------
cookd = cooks.distance(mod)
plot(cookd)

#' 
#' Other useful functions are `hatvalues` (for leverages), `residuals` (for residuals), and `rstandard` (for standardized residuals).
#' 
#' ## Automatic model selection
#' 
#' ### Backward, forward, and stepwise
#' 
#' Backward selection with AIC:
## ------------------------------------------------------------------------
step(mod, direction='backward')

#' 
#' If we want to do forward selection, we have to give a starting model and a bigger model that contains the all the variables that we might want to include in our model.
#' 
## ------------------------------------------------------------------------
nullmod = lm(Price ~ 1, data = nyc) # no variables
fwd = step(nullmod, 
           scope=list(upper=mod), 
           direction='forward')

#' 
#' In the code above, the starting point was a model with no variables (`nullmod`) and the model that included the variables under consideration is `mod` (which contains `Food`, `Service`, `Decor`, and `East`).
#' 
#' We can do forward selection starting with a model that has some variable(s) already. For example, we can start with a model that has `Service` already in.
## ------------------------------------------------------------------------
mod2 = lm( Price ~ Service, data = nyc)
fwd = step(mod2, 
           scope=list(upper=mod), 
           direction='forward')

#' 
#' We can do stepwise regression with `direction = 'both'`. In stepwise regression, variables can get in or out of the model. We can specify the smallest and biggest model in our search with `scope`. For example, if we want to start our stepwise search with a model has `Service` as a predictor and we want to restrict our search to models that include `Service` and potentially include all the other predictors:
#' 
## ------------------------------------------------------------------------
mod2 = lm( Price ~ Service, data = nyc)
fwd = step(mod2, 
           scope=list(lower=mod2, upper=mod), 
           direction='both')

#' 
#' We can change our selection criterion to BIC by adding the command `k = log(number of observations)`. For example,
#' 
## ------------------------------------------------------------------------
n = nrow(nyc) 
step(mod, direction='backward', k = log(n))

#' 
#' 
#' **Sources:**
#' 
#' * Sheather, Simon. *A modern approach to regression with R.* Springer Science & Business Media, 2009.
#' 
#' * [Multiple and logistic regression](https://www.datacamp.com/courses/multiple-and-logistic-regression), Datacamp course by [Ben Baumer](http://www.science.smith.edu/~bbaumer/w/). 
#' 
#' 
