##
## Field goal data
##

colnames(fg) = c("yards", "success", "week")
library(GGally)
fg$success = as.factor(fg$success)
ggpairs(fg)
# easier to make the fg if you're closer
qplot(success, yards, data = fg, geom = 'boxplot')
# there might be a "week" effect.. not very clear
qplot(success, week, data = fg, geom = 'boxplot')

mod = glm(success ~ week + yards, data = fg, family="binomial")

# confusion matrix
preds = ifelse(predict(mod, type = 'response') >= 0.5, 1, 0)
tab = table(preds, fg$success)

# good predictions
sum(diag(tab))/nrow(fg)
# bad predictions
1-sum(diag(tab))/nrow(fg)

round(prop.table(tab),3)

# roc 
# sensitivity: true positive rate
# specificity: true negative rate
prob = predict(mod, type="response")
fg$prob = prob
library(pROC)
g = roc(success ~ prob, data = fg)
plot(g)  
g

# df betas


# predict on a grid of week and yards
weekseq = min(fg$week):max(fg$week)
yardseq = min(fg$yards):max(fg$yards)
pred = expand.grid(weekseq, yardseq)
colnames(pred) = c("week", "yards")
pred$preds = predict(mod, newdata = pred, type = 'response')
ggplot(pred) + 
  aes(x=week, y=yards, color=preds) +
  geom_point(size=8) +
  scale_color_gradient(low="red", high="green")+
  theme(text=element_text(size=15))


##
## Interfaith dating dataset
##

# change column names and factor levels
interfaith = interfaith.dat
colnames(interfaith) = c("ses",
                           "religion",
                           "gender",
                           "interfaith",
                           "count")
interfaith$ses = as.factor(interfaith$ses)
levels(interfaith$ses) = c("low", "medium", "high")

interfaith$religion = as.factor(interfaith$religion)
levels(interfaith$religion) = c("protestant", "catholic")


interfaith$gender = as.factor(interfaith$gender)
levels(interfaith$gender) = c("male", "female")

interfaith$interfaith = as.factor(interfaith$interfaith)
levels(interfaith$interfaith) = c("yes", "no")



library(dplyr)
library(ggplot2)
library(tidyr)
library(GGally)

# transform dataset using uncount

# do ggpairs


# plot of ses

# plot of ses, ordered by frequency

# get the data in table form with dplyr

# ascending order

# descending order

# coordinate flip + change options

# ses by religion

# ses by interfaith

# religion by interfaith

# gender by interfaith



levels(inter$interfaith)
# create ordered factor
inter2 = factor(inter$interfaith, levels=c("no", "yes"), ordered = TRUE)

# fit logistic regression model, additive effects

# confusion table with 0.5 threshold
predict(mod1, newdata = data.frame(religion=c("catholic","protestant")), type='response')
tab1 = table(ifelse(predict(mod1, type='response')>0.5, 1, 0), inter2)
tab1 
sum(diag(tab1))/nrow(inter)
prob = predict(mod1, type="response")

#  ROC curve
library(pROC)
g = roc(inter2 ~ prob)
plot(g)  
g

# model with 2-way interactions
modinter = step(glm(inter2 ~ ses+religion+gender+religion*ses+gender*ses+religion*gender , family="binomial", data=inter))
summary(modinter)

# confusion table at 0.5
tab2 = table(ifelse(predict(modinter, type='response')>0.5, 1, 0), inter2)

# ROC
prob2 = predict(modinter, type="response")
library(pROC)
g = roc(as.numeric(inter2) ~ prob2)
plot(g)  
g

# display predictions

