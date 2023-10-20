####################
# cholesterol data #
####################

chol = read.csv("http://vicpena.github.io/pie2/COL.csv",
                sep = ";", dec = ",")

head(chol)

# install.packages("GGally")
library(GGally)
ggpairs(chol)

# model C as a function of A, H, W
# A and H are highly correlated
# this can lead to unreliable (high variance)
# estimation and wide prediction intervals

mod1 = lm(C ~ ., data = chol)
summary(mod1)
confint(mod1)

# we're told that we can transform 
# some of the variables to alleviate
# the issue

# instead of modeling with weights,
# they tell us to model with "excess weights",
# defined as
# EW = W - (-10+0.5*H)
# (-10+0.5*H) is the "ideal" weight
# given a height
chol$EW = chol$W - (-10+0.5*chol$H)
ggpairs(chol)
# EW is essentially uncorrelated with A and H

# let's refit the model
mod2 = lm(C ~ EW + H + A, data = chol)
summary(mod2)
# H is not significant and we take it out of the model
mod3 = lm(C ~ EW + A, data = chol)
summary(mod3)
# everything is highly significant 
# we can interpret the coefficients in terms of unit increases
# (we'll do it in lecture)

# let's validate the model
par(mfrow = c(1,2))
hist(rstudent(mod3))
plot(x = predict(mod3), y = rstudent(mod3))
# all good
n = nrow(chol)
p = 3
stu = sort(rstudent(mod3))
quantile(stu, seq(0.1, 0.9, 0.1))
qnorm(seq(0.1, 0.9, 0.1), mean = 0, sd = 1)
qqnorm(rstudent(mod3))

#############
# lledoners #
#############

dcap =  read.csv("http://vicpena.github.io/pie2/DCAP.csv",
                    sep = ";", dec = ",")


modA = lm(DCrown ~ . , data = DCAP)
modB = lm(log(DCrown) ~ log(PB) + log(PT) + log(HT) + log(A), data = DCAP)
modC = lm(log(DCrown) ~ PB + PT + HT + A, data = DCAP)

par(mfrow = c(2,2))
plot(modA)
par(mfrow = c(2,2))
plot(modB)
par(mfrow = c(2,2))
plot(modC)

#########
# Rugby #
#########



rugby = read.csv("http://vicpena.github.io/pie2/RUGBY2.csv")
head(rugby)

# some correlated variables
library(GGally)
ggpairs(rugby)

# full model
mod_full = lm(T1600 ~ . , data = rugby)
summary(mod_full)

# we take out the weight
mod2 = lm(T1600 ~ . -Peso , data = rugby)
summary(mod2)

# we take out the lifted weight
mod_final = lm(T1600 ~ Altura + T400 , data = rugby)
summary(mod_final)

# residuals look fine
par(mfrow = c(1, 2))
hist(rstandard(mod_final), main = "")
plot(x = predict(mod_final), y = rstandard(mod_final))

# predictions
newdata = data.frame(Altura = 180, Peso = 87, Peso_levanta = 130, T400 = 75)
predict(mod_final, newdata = newdata, interval = "prediction", level = 0.90)
predict(mod_final, newdata = newdata, interval = "confidence", level = 0.95)
