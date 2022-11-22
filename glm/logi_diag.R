data = read.csv("http://vicpena.github.io/glm/lec7.csv")


#############
# Model fit #
#############
mod_fin = glm(def_num ~ student + balance,
              family = "binomial",
              data = data)
summary(mod_fin)



################
# Effect plots #
################
library(interactions)
interact_plot( , 
               pred =  , 
               modx =  ,
               plot.points = TRUE,
               facet.modx = TRUE)


######################
# Response residuals #
######################


# histogram of response residuals by
# values of default


# top 3 observations with highest resid

#####################
# Pearson residuals #
#####################

# histogram of Pearson resids

# top 3 observations with highest Pearson resid


######################
# Deviance residuals #
######################

# histogram of deviance resids

# top 3


######################
# Difference in fits #
######################

# diff in loglike already computed
data$diff_logLik

# plot diff in logLik by default status

# top 3 observations with highest change in loglike 




