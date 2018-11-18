# reading in treatment data; your path will be different
treats = read.csv("~/Downloads/midterm 3/treats.csv")

# boxplot
boxplot(treats$improvement~treats$treatment)

# converting to treatment to numeric
treatnumeric = as.numeric(treats$treatment)
treatnumeric
improv = treats$improvement

# treating treatment as a quantitative predictor
# induces some assumptions that need to be checked
plot(y=improv, x=treatnumeric)
mod = lm(improv~treatnumeric)
abline(mod)
# here it isn't a great idea

# it would be even worse if the treatments had been coded like this
treatnumeric2 = treatnumeric
treatnumeric2[treatnumeric==2] = 3
treatnumeric2[treatnumeric==3] = 2
plot(y=improv, x=treatnumeric2)
mod2 = lm(improv~treatnumeric2)
abline(mod2)

# we can convert back from numeric to factor
treatfactor = as.factor(treatnumeric)
treatfactor
str(treatfactor)
modf = lm(improvement~treatment, data=treats)
summary(modf)
 

## speed / height / gender data
speed =  read.csv("hw2data 2/speed_gender_height.csv")
speed = na.omit(speed) # omit missing data
speed = speed[,-1] # delete first column

# different models
mod = lm(speed~gender+height,data=speed)
mod2 = lm(speed~gender+height+gender*height,data=speed)
mod3 = lm(speed~gender, data=speed)
mod2 = lm(speed~gender*height,data=speed) # equivalent to mod2
mod2 = lm(speed~.*., data=speed) # equivalent to mod2
summary(mod2)
mod3 = lm(speed~gender:height,data=speed) # interaction only model

summary(mod2)
summary(mod3)

library(leaps)
library(effects)

# effect plots, from library effects
plot(allEffects(mod))
plot(allEffects(mod2))

# all subsets selection with leaps
out = regsubsets(speed~gender*height, data=speed)
plot(out, scale='adjr')
summary(out)
