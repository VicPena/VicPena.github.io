## HW1 with R!
## Date: Oct 31st, 2018


################
## Exercise 1 ##
################

# part 1
# read in the vector
x = c(1,4,2,3,6,9,1,3,9,3)
# compute mean and sd
mean(x)
sd(x)
# summary stats
summary(x)
# histogram, boxplot
hist(x, col='orange')
boxplot(x)
library(ggplot2)
qplot(x)

# part 2
?t.test # help on t-test
# default is 95% confidence level, H0: mu = 0, two-sided (not equal) alternative
t.test(x)
t.test(x, mu=5, conf.level = 0.99)
t.test(x, conf.level = 0.99)


## Exercise 2

# part 1 
# I read in the data using the import wizard 
pharma = read.csv("C:/Users/vpena/Downloads/pharma.csv")
# summaries
summary(pharma)

# can access the variables in the dataset by 
# writing the name of the dataset with $ 
pharma$group
pharma$outcome

# create new variables with data from subgroups
outcurrent = pharma$outcome[pharma$group=='current']
outnew = pharma$outcome[pharma$group=='new']
# summaries by group
summary(outcurrent)  
summary(outnew)
sd(outcurrent)
sd(outnew)
# plots by group
hist(outcurrent)
hist(outnew)
boxplot(pharma$outcome~pharma$group)

# the following command prepares R for plotting 1 row and 2 columns
par(mfrow=c(1,2))  
hist(outcurrent)
hist(outnew)
# same with 2 rows 1 column
par(mfrow=c(2,1))
hist(outcurrent)
hist(outnew)

# plotting with qplot, which is in library(ggplot2)
qplot(x=pharma$group, y=pharma$outcome)
qplot(x=pharma$group, y=pharma$outcome, geom='boxplot')
qplot(pharma$outcome, fill=pharma$group, geom='histogram')
qplot(pharma$outcome, fill=pharma$group)

# part 2, 3 ,4
t.test(outnew,outcurrent) # two-sided alternative
t.test(outnew,outcurrent, alternative='greater')
wilcox.test(outnew,outcurrent) # non-parametric test
shapiro.test(outcurrent) # test if current is normal; it's not
t.test(outcome~group,data=pharma)


#################
## Exercise 4  ##
#################

# I read in the data with the import manager
drill = read.csv("C:/Users/vpena/Downloads/drill.csv")
# structure of the dataset, 2 factors (categorical)
str(drill)
# can make tables with table, save it in a variable
tab = table(drill$collegegrad,drill$opinion)
table(drill$opinion,drill$collegegrad)


prop.table(tab) # marginal proportions
prop.table(tab, margin = 1) # row props
prop.table(tab, margin = 2) # column props
chisq.test(tab) # chi-squared test
margin.table(tab,1) # marginal counts by row
margin.table(tab,2) # counts by columns

# barplot; annoying to put right labels, but the code works in general:
barplot(tab,legend=levels(drill$collegegrad))


# % of college grads who don't know
# and % noncollege grads who don't know
prop.table(tab, margin = 1)


# create new opinion variable
drill$newopinion = ifelse(drill$opinion=='dontknow','no','yes' )
# this variable collapses "oppose" and "support" into "yes" (i.e. they have an opinion)
tab2 = table(drill$newopinion,drill$collegegrad)
chisq.test(tab2) # chisq test with new variable

