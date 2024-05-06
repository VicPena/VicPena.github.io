#############
# hospitals #
#############

# reading in the data
load(url("http://vicpena.github.io/workshops/2024/hosp.RData"))

library(ggplot2) 
library(R2jags)

# barplot of outcomes
dat2 = data.frame(hospital = rep(dat$hospital, 2),
                  count = c(dat$n-dat$y, dat$y),
                  outcome = factor(rep(c("not dead", "dead"), 
                                       each = nrow(dat))))

ggplot(dat2) +
  aes(x = hospital, y = count, fill = outcome) +
  geom_col() +
  theme_minimal() +
  theme(text=element_text(size=24))

# barplot of proportions (ignores n)
ggplot(dat) +
  aes(x = hospital, y = y/n) +
  geom_col() +
  theme_minimal() +
  ylab("% deaths") +
  theme(text=element_text(size=24))



# complete pooling
model.comp <- "
model
{
 for (i in 1:H) {
  y[i] ~ dbin(theta, n[i])
 }
 theta ~ dbeta(a, b)
}
"


# comp_pool = jags(data=list(H = nrow(dat),
#                           n = dat$n, 
#                           y = dat$y,
#                           a = 0.5, b = 0.5), 
#                 parameters.to.save=c("theta"),
#                 model=textConnection(model.comp))

# traceplot(comp_pool)
# th_comp = comp_pool$BUGSoutput$sims.list$theta


# no pooling
model.no <- "
model
{
 for (i in 1:H) {
  y[i] ~ dbin(theta[i], n[i])
  theta[i] ~ dbeta(a, b)
 }
}
"


# no_pool = jags(data=list(H = nrow(dat),
#                         n = dat$n, 
#                         y = dat$y,
#                         a = 0.5, b = 0.5), 
#               parameters.to.save=c("theta"),
#               model=textConnection(model.no))

# traceplot(no_pool)
#th_no = no_pool$BUGSoutput$sims.list$theta


# partial pooling: hierarchical 
model.hier <- "
model
{
 for (i in 1:H) {
   alpha[i] ~ dnorm(mu, tau)
   y[i] ~ dbin(theta[i], n[i])
   logit(theta[i]) <- alpha[i]
 }
 mu ~ dnorm(0, 0.001)
 tau ~ dgamma(0.01, 0.01)
}
"


# hier = jags(data=list(H = nrow(dat),
#                      n = dat$n, 
#                      y = dat$y), 
#               parameters.to.save=c("theta", "mu", "tau"),
#                model=textConnection(model.hier))

# traceplot(hier)
#th_hier = hier$BUGSoutput$sims.list$theta




###############
# 95% CI plot #
###############


# comp pool
aux_comp = quantile(th_comp, c(0.025, 0.5, 0.975))
aux_comp = data.frame(lower = rep(aux_comp[1], nrow(dat)),
                      median = rep(aux_comp[2], nrow(dat)),
                      upper = rep(aux_comp[3], nrow(dat)),
                      hospital = LETTERS[1:12])
aux_comp$model = "co. pool"


# no pool
aux_no = t(apply(th_no, 2, 
              function(x) quantile(x, c(0.025, 0.5, 0.975))))
aux_no = as.data.frame(aux_no)
aux_no$hospital = LETTERS[1:12]
colnames(aux_no)[1:3] = c("lower", "median", "upper")
aux_no$model = "no pool"

# hierarchical
head(th_hier)
aux = t(apply(th_hier, 2, 
      function(x) quantile(x, c(0.025, 0.5, 0.975))))
aux = as.data.frame(aux)
head(aux)
aux$hospital = LETTERS[1:12]
colnames(aux)[1:3] = c("lower", "median", "upper")
aux$model = "hierarchical"

df = rbind(aux_comp,
           aux_no,
           aux)

ggplot(df) +
   aes(y = model, x = median, color = model) +
   geom_point() +
  geom_errorbar(aes(xmin = lower, xmax = upper)) +
  facet_wrap(~hospital, labeller = label_both, nrow = 4) +
  xlab("95% posterior CI for prob. death") + 
  theme_minimal() +
  theme(text=element_text(size=14))


########################
# Ranking of hospitals #
########################

ranks = t(apply(th_hier, 1, function(x) rank(-x)))
ranks = as.data.frame(ranks)


out = NULL
for (j in 1:ncol(ranks)) {
  rk = as.factor(ranks[,j])
  levels(rk) = 1:12
  aux = as.numeric(prop.table(table(rk)))
  df = data.frame(ranking = 1:12,
                  prob = aux,
                  hospital = LETTERS[j])
  out = rbind(out, df)
}

ggplot(out) +
  aes(x = ranking, y = prob) +
    geom_col() +
    scale_x_continuous(breaks = 1:12) +
    facet_wrap(~ hospital, labeller = label_both) +
    theme_minimal() +
    theme(text=element_text(size=16))
