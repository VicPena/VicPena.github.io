# read in the speed data first
speed1 = read.csv('~/Downloads/hw2data/speed_gender_height.csv')
speed = na.omit(speed1[,-1])
library(leaps)
allsubs = regsubsets(speed~gender+height+gender*height, data=speed)
plot(allsubs, scale='bic')
plot(allsubs, scale='adjr')
summary(allsubs)


nullmod = lm(speed~1,data=speed)
fullmod = lm(speed~.,data=speed)
# fwd selection with AIC
fwd = step(nullmod, 
           scope=list(lower=nullmod, upper=fullmod), 
           direction='forward')
# backward
backw = step(fullmod, scope=list(lower=nullmod, upper=fullmod), direction='backward')
# stepwise
stepw = step(nullmod, scope=list(lower=nullmod, upper=fullmod), direction='both')

# can change to BIC by adding the command k = log(number of observations)
# for example: 
fwd = step(nullmod, 
           scope=list(lower=nullmod, upper=fullmod), 
           direction='forward', k=log(nrow(speed)))


## hsb2 data
library(openintro)
data('hsb2')
# anova
mod1 = aov(math~ses, data=hsb2)
summary(mod1)
boxplot(math~ses, data=hsb2)
TukeyHSD(mod1) # Tukey for pairwise differences

# math scores as a function of ses and race
mod = aov(math~ses+race,data=hsb2)
# more comparisons
TukeyHSD(mod)
# can check model assumptions 
par(mfrow=c(2,2))
plot(mod)
# cleaning up the output, by rounding the tables:
round(TukeyHSD(mod)$race, 3)


# read in starbucks data
starbucks = read.csv('~/Downloads/hw2data/starbucks.csv')
head(starbucks)

# read in McDonald's data for prediction
newdata = data.frame(item=c('Big Mac','Cheeseburger','McDouble','Chocolate Chip Cookie'),
           fat=c(28,11,17,7),
           carb=c(45,33,34,22),
           fiber=c(3,2,2,1),
           protein=c(24,15,21,2),
           type=c('sandwich','sandwich','sandwich','bakery'))
truth = c(520,290,370,160)

# fitting different models with transformed outcomes/predictors
mod = lm(calories~carb,data=starbucks)
modlogy = lm(log(calories)~carb,data=starbucks)
modlogx = lm(calories~log(carb),data=starbucks)
modloglog= lm(log(calories)~log(carb), data=starbucks)
# predict with the models, changing back to original scale if needed
pred = predict(mod, newdata=newdata, interval='prediction')
predlogy =exp(predict(modlogy, newdata=newdata, interval='prediction'))
predlogx = predict(modlogx, newdata=newdata, interval='prediction')
predloglog = exp(predict(modloglog, newdata=newdata, interval='prediction'))
# compare models in terms of mean squared error:
mean((pred[,1]-truth)^2)
mean((predlogy[,1]-truth)^2)
mean((predlogx[,1]-truth)^2)
mean((predloglog[,1]-truth)^2)
summary(mod) # 44.84%, 3rd best
summary(modlogx)  # 51.46%, 1st truth
summary(modlogy) # 45.15%, worst
summary(modloglog) # 54.46%, 2nd best
