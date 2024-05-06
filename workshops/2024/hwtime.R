##########
# hwtime #
##########

load(url("http://vicpena.github.io/workshops/2024/hw.RData"))


dat$school = factor(dat$school)
table(dat$school)
ggplot(dat) +
    aes(x = school, y = hwtime) +
        geom_boxplot()

library(ggplot2)
library(R2jags)


# Complete pooling
model1 <- "
model
{
  for (i in 1:n) {
    y[i] ~ dnorm(theta, tau)
  }
  
  theta ~ dnorm(20, 0.01)
  tau ~ dgamma(0.01, 0.01)
}
"

# comp = jags(data = dat1,
#                 parameters.to.save = c("theta", "tau"),
#                  model = textConnection(model1))
    

# th_comp = comp$BUGSoutput$sims.list$theta



              
# No pooling
dat2 = list(
    "y" = dat$hwtime,
    "school" = dat$school,
    "n" = length(dat$hwtime),
    "J" = 8
)

model2 = "
model
{
    for (i in 1:n) {
        y[i] ~ dnorm(theta[school[i]], tau[school[i]])
    }
    
    for (j in 1:J) {
        theta[j] ~ dnorm(20, 0.01)
        tau[j] ~ dgamma(0.01, 0.01)
    }
}
"

# no_pool = jags(data = dat2,
#            parameters.to.save = c("theta", "tau"),
#            model = textConnection(model2))

# th_no = no_pool$BUGSoutput$sims.list$theta


# Hierarchical
model3 = "
model
{
  for (i in 1:n) {
	y[i] ~ dnorm(theta[school[i]], tau)
  }

  for (j in 1:J) {
  	theta[j] ~ dnorm(mu, phi)
  }

  # Prior model for mu, sig, and tau
  mu ~ dnorm(20, 0.01)
  s_tau ~ dunif(0, 1000)
  s_phi ~ dunif(0, 1000)
  tau <- pow(s_tau, -2)
  phi <- pow(s_phi, -2)
 
}
"

# hier = jags(data = dat2,
#            parameters.to.save = c("theta", "tau", "phi"),
#            model = textConnection(model3),
#            n.iter =  1e4)

# th_hier = hier$BUGSoutput$sims.list$theta
# s2_obs = 1/hier$BUGSoutput$sims.list$tau
# s2_th = 1/hier$BUGSoutput$sims.list$phi

#  save(dat, dat2, th_hier, th_comp, th_no, s2_obs, s2_th,
#      file = "C:/Users/victor.pena.pizarro/Dropbox/teaching/doctorat/bayes/hw.RData")

###############
# 95% CI plot #
###############


# comp pool
aux_comp = quantile(th_comp, c(0.025, 0.5, 0.975))
aux_comp = data.frame(lower = rep(aux_comp[1], 8),
                      median = rep(aux_comp[2], 8),
                      upper = rep(aux_comp[3], 8),
                      school = factor(1:8))
aux_comp$model = "co. pool"


# no pool
aux_no = t(apply(th_no, 2, 
                 function(x) quantile(x, c(0.025, 0.5, 0.975))))
aux_no = as.data.frame(aux_no)
aux_no$school = factor(1:8)
colnames(aux_no)[1:3] = c("lower", "median", "upper")
aux_no$model = "no pool"

# hierarchical
head(th_hier)
aux = t(apply(th_hier, 2, 
              function(x) quantile(x, c(0.025, 0.5, 0.975))))
aux = as.data.frame(aux)
head(aux)
aux$school = factor(1:8)
colnames(aux)[1:3] = c("lower", "median", "upper")
aux$model = "hierarchical"

df = rbind(aux_comp,
           aux_no,
           aux)

ggplot(df) +
    aes(y = model, x = median, color = model) +
    geom_point() +
    geom_errorbar(aes(xmin = lower, xmax = upper)) +
    facet_wrap(~school, labeller = label_both, nrow = 4) +
    xlab("95% posterior CI for prob. death") + 
    theme_minimal() +
    theme(text=element_text(size=14))

######
# R2 #
######

boxplot(s2_th/(s2_th+s2_obs))



