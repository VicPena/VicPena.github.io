# read in data
midterms = read.csv("C:/Users/vpena/Downloads/midterms.csv")
# structure of the dataset 
str(midterms)

# can create a variable whose entries are 'blue' if
# the observation is a democrat, and red otherwise
coldot = ifelse(midterms$party=='D','blue','red')
coldot
# some plots, pch = 16 for solid dots
plot(x=midterms$year, y=midterms$approval, col=coldot, pch=16)
plot(x=midterms$approval, y=midterms$change, col=coldot, pch=16)
# fit linear model object
mod = lm(change~approval, data=midterms)
# overlay the regression line on the plot
abline(mod)
# summary of the regression
summary(mod)
par(mfrow=c(2,2)) # 2 by 2 matrix of plots 
plot(mod) # diagnostic plots 

# model doesn't fit very well...
# let's try some transformations
midterms$decperc = -midterms$change/435
eps = 0.001
k = -min(midterms$decperc)+eps
midterms$decperc = midterms$decperc+k
modlog = lm(log(decperc)~approval, data=midterms)
modsqrt = lm(sqrt(decperc)~approval, data=midterms)

par(mfrow=c(2,2)) # 2 by 2 matrix of plots 
plot(modlog)

par(mfrow=c(2,2)) # 2 by 2 matrix of plots 
plot(modsqrt) 

# modsqrt seems best

# create a data.frame with entries where we want to predict
appr = data.frame(approval=seq(0,100,0.01)) # seq in jumps of 0.01 from 0 to 100
# predict with the modsqrt
preds = predict(modsqrt, newdata=appr, interval='prediction')
head(preds)
# have to convert back to the original scale
newpreds = preds^2-k
newseats = newpreds*(-435)

# can plot the non-linear relationship (in the original-scale)
# and how the intervals look like
plot(x=midterms$approval, y=midterms$change, col=coldot, pch=16,ylim=c(-100,10))
points(x=appr$approval,y=newseats[,1], type='l')
points(x=appr$approval,y=newseats[,2], type='l')
points(x=appr$approval,y=newseats[,3], type='l')
abline(v=41.9) # current Trump's approval rating
# the prediction is quite wide...

