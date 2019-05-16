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

# transform dataset 
inter = interfaith %>% uncount(count)

# logistic regression model, additive effects
inter2 = factor(inter$interfaith, levels=c("no", "yes"), ordered = TRUE)
mod1 = step(glm(inter2 ~ ses+religion+gender , family="binomial", data=inter))
predict(mod1, newdata = data.frame(religion=c("catholic","protestant")), type='response')

# confusion table with 0.5 threshold
# roc 
prob1 = predict(mod1, type="response")
tab1 = table(ifelse(prob1>0.5, 1, 0), inter2)
tab1 

# sensitivity: true positive rate = Prob(classified "yes" given truth is "yes")
76/(76+88)
# specificity: true negative rate = Prob(classified "no" given truth is "no")
265/(265+28)


#  ROC curve
library(pROC)
addroc = roc(inter2, prob1)
plot(addroc)   
abline(v=0.75)

# model with 2-way interactions
modinter = step(glm(inter2 ~ ses+religion+gender+religion*ses+gender*ses+religion*gender , family="binomial", data=inter))
summary(modinter)

# confusion table at 0.5
tab2 = table(ifelse(predict(modinter, type='response')>0.5, 1, 0), inter2)
tab2

# sensitivity: true positive rate = Prob(classified "yes" given truth is "yes")
72/(72+92)
# specificity: true negative rate = Prob(classified "no" given truth is "no")
267/(267+26)


# ROC
prob2 = predict(modinter, type="response")
library(pROC)
interroc = roc(as.numeric(inter2) ~ prob2)
plot(addroc)  
abline(v=0.90)
plot(interroc, add = T, col = 'blue')


# display predictions
interpred = interfaith %>% select(ses, religion, gender)
interpred = unique(interpred)
interpred$preds =  predict(modinter, newdata = interpred, type = 'response')



ggplot(interpred, aes(x=religion, y=preds, group=gender, color=gender))+
  geom_line(size=2)+facet_wrap(~ses)+
  theme(text=element_text(size=32))


## What does it mean to be a man?

# read in the data first

# question 8 variables
raw8 = raw.responses %>% select(starts_with('q0008'))

# go to wide to long format
long = raw8 %>% gather()
str(long)
str(raw8)
1615*12 # right size

# count! 
tab1 = long %>% group_by(value) %>% count
tab1 = tab1 %>% filter(n < 10000)
ggplot(tab1, aes(x = reorder(value,n), y = 100*n/nrow(raw8))) + 
  geom_bar(stat = 'identity') + 
  coord_flip()


