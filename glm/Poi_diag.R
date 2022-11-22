data = read.csv("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv")
data$prog = factor(data$prog)
levels(data$prog) = c("General", "Academic","Vocational") 
mod_pois = glm(num_awards ~ prog + math, data = data, family = "poisson")

#######
# LRT #
#######

# compare additive model against model with interaction

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

library(tidyverse)
data$resp_resid = residuals(mod_pois, type = "response")

# histogram of response residuals

# proportion of positive and negative residuals

# residuals against number of awards


#####################
# Pearson residuals #
#####################

data$pear_resid = residuals(mod_pois, type = "pearson")

# histogram of Pearson resids

# find observations with abs(Pearson resid) > 2.5


######################
# Deviance residuals #
######################

data$dev_resid = residuals(mod_pois)

# histogram of deviance resids


######################
# Difference in fits #
######################

beta_hat = coef(mod_pois)
diff_betas = matrix(0, 
                    nrow = nrow(data), 
                    ncol = length(beta_hat))
diff_logLik = numeric(length(data))
for (i in 1:nrow(data)) {
  dat = data[-i,]
  mod_poi = glm(num_awards ~ prog + math,
                data = dat,
                family = "poisson")
  diff_betas[i,] = coef(mod_poi) - beta_hat
  diff_logLik[i] = logLik(mod_poi)-logLik(mod_pois)
}
data$diff_logLik = diff_logLik 

# plot diff in loglike vs num_awards


# find top 3 observations with highest change in loglike



