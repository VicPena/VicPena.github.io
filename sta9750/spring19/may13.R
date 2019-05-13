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


# df betas
dfbeta(mod)

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

# roc 
# sensitivity: true positive rate
# specificity: true negative rate
prob = predict(mod, type="response")
fg$prob = prob
library(pROC)
g = roc(success ~ prob, data = fg)
plot(g)  
g

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

# transform dataset 
inter = interfaith %>% uncount(count)

# do ggpairs
ggpairs(inter)
str(inter)

# plot of ses
qplot(ses, data=inter)

# plot of ses, ordered by frequency
inter %>% group_by(ses) %>% count()

# ascending order
ggplot(df1,aes(x=reorder(ses,n),y=n))+ geom_bar(stat="identity")
# descending order
ggplot(df1,aes(x=reorder(ses,-n),y=n))+ geom_bar(stat="identity")
# coordinate flip
library(ggthemes)
ggplot(df1,aes(x=reorder(ses,n),y=n/sum(n)))+ 
  geom_bar(stat="identity", fill="orange")+coord_flip()+
  theme_fivethirtyeight()+
  xlab("socioeconomic status")+
  theme(text=element_text(size=32))+
  ggtitle("Proportions of socioeconomic status")+
  ylab("count")


# ses by religion
ggplot(inter, aes(x=ses, fill=religion))+geom_bar(position='fill')

# ses by interfaith
ggplot(inter, aes(x=interfaith, fill=ses))+geom_bar(position='fill')

# religion by interfaith
ggplot(inter, aes(x=interfaith, fill=religion))+geom_bar(position='fill')

# gender by interfaith
ggplot(inter, aes(x=interfaith, fill=gender))+geom_bar(position='fill')+coord_flip()+
  theme_fivethirtyeight()+
  theme(text=element_text(size=32))+
  scale_fill_manual(values=c("lightblue","pink1"))

# if we don't change the order of the levels of interfaith 
# we'd be modeling the probability of non-interfaith dating
levels(inter$interfaith)

# logistic regression model, additive effects
inter2 = factor(inter$interfaith, levels=c("no", "yes"), ordered = TRUE)
mod1 = step(glm(inter2 ~ ses+religion+gender , family="binomial", data=inter))
predict(mod1, newdata = data.frame(religion=c("catholic","protestant")), type='response')

# confusion table with 0.5 threshold
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
tab2
sum(diag(tab2))/nrow(inter)

# ROC
prob2 = predict(modinter, type="response")
library(pROC)
g = roc(as.numeric(inter2) ~ prob2)
plot(g)  
g

# display predictions
interpred = interfaith %>% select(ses, religion, gender)
interpred = unique(interpred)
interpred$preds =  predict(modinter, newdata = interpred, type = 'response')



ggplot(interpred, aes(x=religion, y=preds, group=gender, color=gender))+
  geom_line(size=2)+facet_wrap(~ses)+
  theme(text=element_text(size=32))
