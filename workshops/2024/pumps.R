#########
# pumps #
#########

load(url("http://vicpena.github.io/workshops/2024/pumps.RData"))


library(ggplot2) 
library(R2jags)

dat = list(t = c(94.3, 15.7, 62.9, 126, 5.24, 31.4, 1.05, 1.05, 2.1, 10.5),
     x = c( 5, 1, 5, 14, 3, 19, 1, 1, 4, 22), N = 10)


plot(y = dat$x, x = dat$t)


# partial pooling: hierarchical 
model.hier <- "
  model
   {
      for (i in 1 : N) {
         theta[i] ~ dgamma(alpha, beta)
         lambda[i] <- theta[i] * t[i]
         x[i] ~ dpois(lambda[i])
      }
      alpha ~ dexp(1)
      beta ~ dgamma(0.1, 1.0)
   }

"


# hier = jags(data = dat, 
#            parameters.to.save = c("theta", "alpha", "beta"),
#            model = textConnection(model.hier))

# traceplot(hier)
# th_hier = hier$BUGSoutput$sims.list$theta

# are there differences between pumps?
head(th_hier)
aux = t(apply(th_hier, 2, 
              function(x) quantile(x, c(0.025, 0.5, 0.975))))
aux = as.data.frame(aux)
head(aux)
aux$pump = factor(1:10)
colnames(aux)[1:3] = c("lower", "median", "upper")



ggplot(aux) +
    aes(y = pump, x = median, color = pump) +
    geom_point() +
    geom_errorbar(aes(xmin = lower, xmax = upper)) + 
    xlab("95% posterior CI for pump. mean") + 
    theme_minimal() +
    theme(text=element_text(size=14))


