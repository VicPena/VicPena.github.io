############
# Overview #
############

# - group_by and summarize
# - Plots: afternoon 

# - Plots: odds & ends
# - Confidence intervals and hypothesis testing
# - Exploratory data analysis: 
#     summary statistics and plots

###################### 
# Plots: odds & ends #
######################

library(tidyverse)
# ggplot, group_by, summarize, mutate, and count
library(openintro)

data(hsb2)

# 1st step: creating a table
# that had the information that we want
# to display using count

# create a plot with ses and race
tab2 = hsb2 %>% count(ses, race)
tab2

# ggplot(...) +
# aes(x =, y = , fill = , ...) +
# geom_col

# geom_col: "geom column"
# geom_histogram: histograms
# ...

# changing scale from proportions to percentages
# in geom_col(position = "fill")
ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
  geom_col(position = "fill") 


ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent) 


# adding counts / percentages to bars
library(openintro)
data(immigration)
immigration
# response to a question: what we should we do
#  with illegal immigrants that are caught?
# political affiliation 

immigration %>% count(response)
immigration %>% count(political)

# have a table that gives me the responses grouped by
# the political affiliation

# the response to the question for conservatives, 
# liberals and moderates separately

immi_counts = immigration %>% group_by(political) %>% count(response)
immi_counts

ggplot(immi_counts) +
  aes(x = political, y = n, fill = response) +
    geom_col()

ggplot(immi_counts) +
  aes(x = political, y = n, label = n, fill = response) +
  geom_col() +
  geom_text(position = position_stack(0.5))

ggplot(immi_counts) +
  aes(x = political, y = n, label = n, fill = response) +
  geom_col(position = "dodge") +
   geom_text(position = position_dodge(0.9))



immi_counts = immi_counts %>% group_by(political) %>%
  mutate(perc = paste(round(100*n/sum(n),1), "%", sep = ""))

ggplot(immi_counts) +
  aes(x = political, y = n, label = perc, fill = response) +
  geom_col(position = "fill") +
  geom_text(position = position_fill(0.5)) + 
  scale_y_continuous(labels = scales::percent) 


# adding error bars to bar plots
# http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization


###########################################
# Confidence intervals & Hypothesis tests #
###########################################

library(tidyverse)

# Inference on population means (based on normal dist'n)
#-------------------------------------------------------


# scientists recorded some measurements stored in x
x = c(1,4,2,3,6,9,1,3,9,3)
df = as.data.frame(x)
df

# visualize data
# numerical variable: boxplot, histogram

# 1st. convert x to data.frame
# ggplot expects inputs of type data.frame
df
# ggplot(..) +
#  aes(x , y ) +
#     geom_boxplot()
ggplot(df) +
  aes(x = x) +
    geom_boxplot()





# provide a 99% confidence interval for the population mean
# (interval based on normal distribution)

# assuming that x is a simple random sample from
# some population and we want to find a confidence interval
# for the population mean 

# an interval based on the t.test 
# the interval will be valid provided that the conditions 
# under which the t.test is valid are satisfied

# x is data.frame and it has a column named x
# if I want to use this variable x into the t.test function
# I have to reference variable x within the data.frame x

# if you have a data.frame called df in R
# and there is a variable called x in it
# we can reference it with the command 
# df$x

# df: x
# variable: x
# x$x
t.test(df$x, conf.level = 0.99)
# 99 percent confidence interval:
# 1.057163 7.142837

# 95% confidence
t.test(df$x, conf.level = 0.95)
# 95 percent confidence interval:
#   1.981931 6.218069

# suppose that I want to find a 95% 
# confidence interval for the read scores
# this a sample of 200 students from a larger population of 
# students... I want to get a confidence interval for the 
# population mean of read scores
t.test(hsb2$read, conf.level = 0.95)
# 95 percent confidence interval:
# 50.80035 53.65965
# 95% confidence interval for the population mean
# of reading scores in the population

hsb2
# scores in read, write, math, science, socst

# 1st. I want to compute a variable that has 
# the average scores in these subjects
# (Hint: use the mutate function to create
# the new variable)
hsb2_male = hsb2 %>% 
            mutate(avg = (read+write+math+science+socst)/5) %>%
                  filter(gender == "male") %>%
                    select(race, avg)
# f, g, h to say x
# f(g(h(x)))
# apply h first, then g, then f 





hsb2

# mutate: creates new columns

# %>%: functions in library(tidyverse)
# - filter: creates subsets of data satisfying logical conditions
# - slice: creates subsets of data using row numbers
# - select: creates subsets of columns
# - group_by & summarize & count
# - mutate

hsb2
# 2nd. I want a 95% confidence interval for that 
# average
t.test(hsb2$avg, conf.level = 0.95)
# 95 percent confidence interval:
# 51.24162 53.52038

# mean of hsb2$avg: 52.381 

# null hypothesis: population mean of avg is 0
# alternative hypothesis: population mean of avg is not 0

# t = 90.657, t-statistic
# df = 199, degree of freedom
# p-value < 2.2e-16
# p-value that is less than 2.2*10^(-16) 
# smaller than any reasonable significance level

# conclusion: reject the null the hypothesis


# if we want to change the null hypothesis to say
# null hypothesis: the population average of avg score 
#                  is 50
t.test(hsb2$avg, mu = 50)
# H0: population mean = median = 50
# H1: population mean = median is not equal to 50

# t = 4.1209, df = 199, p-value = 5.536e-05
# alternative hypothesis: true mean is not equal to 50
# p-value = 5.536*10^(-5) small number
# a number that is smaller than 0.01 so we would reject 
# the null hypothesis that the population average of hsb2$avg
# is equal to 50

# a non-parametric alternative to
# the t-test is the wilcox.test which is based 
# on ranks of the data

# the assumption of normality is suspect in the data
# you can use wilcox.test which does not hinge on that assumption
wilcox.test(hsb2$avg, mu = 50)
# does not assume normality
# null: median is equal to 50
# alternative: median is not equal to 50

# p-value = 0.0001467 
# which is still smaller than 0.01

# H0: median is equal to 50
# H1: median is not equal to 50
# rejecting the null hypothesis

ggplot(hsb2) +
  aes(x = avg) +
    geom_histogram() +
      geom_vline(xintercept = 50, color = "red")

# CI & tests for 
# - one numerical variable




# comparing two numerical means #
#-------------------------------#

# Let's compare the math scores
# for students that go to private school
# against those that go to public school

# null: population avg math score is the 
# same for students that go to private or
# public school

# alt: pop averages are different

# good idea to plot the data 
# numerical: math
# categorical: schtyp
# histograms by groups
# boxplots by group
ggplot(hsb2) +
  aes(x = schtyp, y = math) +
    geom_boxplot()

# t.test
# we are comparing two groups
t.test(hsb2$math ~ hsb2$schtyp)
# df = 45.351: assuming that the variances
# of the groups are not equal
# p-value = 0.1545 > 0.01 significance level
# so the conclusion would be do not reject the null 
# (that the average scores do not depend on the schtyp)
?t.test





# 95% confidence interval for the difference in scores
# public - private
#  [-5.9908645, 0.9789598]
# the interval contains 0 so the null hypothesis cannot be 
# ruled out at the 0.05 significance level

# if I want to change the level of the confidence interval
# I can do so with conf.level
t.test(hsb2$math ~ hsb2$schtyp, conf.level = 0.99)
# 99 percent confidence interval:
# [-7.159029, 2.147124]

# if we don't specify anything the default confidence
# level in t.test is 0.95


t.test(hsb2$math ~ hsb2$schtyp, var.equal = FALSE)
t.test(hsb2$math ~ hsb2$schtyp, var.equal = TRUE)
# assume that the population variances of the groups
# are the same

# ANOVA with a factor that only has two levels
# it's the same as doing the t-test with equal variances
# F = t^2 

# ANOVA:
# - equality of variances


# simulate from two normal distributions
x = rnorm(100, mean = 0, sd = 1)
y = rnorm(100, mean = 0, sd = 10)
df = data.frame(outcome = c(x,y), group = rep(c("x", "y"), each = 100))
df
ggplot(df) +
  aes(x = group, y = outcome) +
    geom_boxplot()

# ANOVA
# - normality
# - equality of variances
# - independence of observations

# some people test the assumptions visually
# - histograms to see if "data look normal"
# - qq-plot: if the data are roughly normally distributed
#            the points (data) lie near a straight line
# - equality of variance can be assessed with a plot like
# the one I just did

# some people run formal hypothesis tests
# - normality: kolmogorov.smirnov, jarque.bera, shapiro.wilk, ...
# - equality of variances: f-test, levene test, ...

# some people do both
mod = lm(hsb2$math ~ hsb2$schtyp)
summary(mod)


## One proportion 


# Do people ever regret getting a tattoo?
# In a 2012 poll by Harris Interactive, 
# 59 out of 423 respondents said yes. 
# Based on the data in this study, 

# find a 99% confidence interval the proportion of people 
# with tattoos who regret getting one. 

# t.test is for numerical variables
# tests or confidence intervals for variables such as
# math scores, reading scores, ages, ..

# prop.test is for proportions
# proportion of the population that regrets getting a tattooo
# the proportion of population that votes for a particular
# political party, so on..

# estimating: prop of people regretting
# getting a tattoo

# x = "number of people regretting the tattoo"
# n = "sample size of the study"

# use prop.test, conf.level = 0.99
prop.test(x = 59, n = 423, conf.level = 0.99)
# 99 percent confidence interval:
#   [0.1006219, 0.1897715]
# Confidence interval for the proportion of people
# who regret getting a tattoo in the general population

# 59 regretted getting the tattoo
# 423 interviewed
59/423 # sample proportion

# interval estimate that quantifies my uncertainty
# in the estimation in some sense
# 99 percent confidence interval:
# [0.1006219, 0.1897715] 
# interval estimate for the population proportion of 
# people who regret getting the tattoo

# 99% confidence intervals contain the unknown
# population parameter 99% of time 

# (I'm making it up)
# null: proportion of people who regret
# getting a tattoo is 0.2 (20%)
# alternative: proportion of people 
# who regret getting a tattoo is not
# 0.2 
prop.test(x = 59, n = 423, p = 0.2, conf.level = 0.99)
# alternative hypothesis: true proportion is not equal to 0.2
# p.value = 0.002281
prop.test(x = 59, n = 423) # required
# default options: p = 0.5, conf.level = 0.95

# p refers to the value of the true proportion 
# under the null hypothesis
# null: true population proportion is equal to p
# alternative: true population proportion is not equal to p

# conf.level refers to the confidence of the confidence
# interval that is given in the output
# confidence interval is an interval estimate of 
# the true proportion
# the higher the confidence level, the wider the interval




# numerical variables:
# null: population mean is equal to 3
# t.test(hsb2$math, mu = 3, conf.level = ...)

# proportions:
# null: population proportion is equal to 0.2
# x = number of people who regret getting a tattoo
# n = sample size of the study
# conf.level = 
# prop.test(x = , n = , p = 0.2, conf.level = ...)


## Two proportions

# OK cupid

#  In a study about online dating, 
# 9 out of 40 males lied about their age
# and 5 out of 40 females lied about their age. 

# can we test whether these sample differences
# are statistically significant or not?

# proportion / percentage:
# how many people in a sample satisfy a certain thing 


# this is going to be a number which is going to be 
# between 0 (nobody satisfies it) and the sample (40 people)

# how many people in my sample regret getting a tattoo
# proportion: 9/40 (men) to 5/40 (women)'

# numerical (average math score)
# numbers that are relative to variable and they
# are not constrained by, for example, the sample size


t.test(x = c(9, 5), n = c(40, 40))
# ignore n
# it gets x
# and it tests
# null hypothesis: mean of x is equal to 0
# alternative hypothesis: mean of x not equal to 0


# answer: yes, we'll use the prop.test
prop.test(x = c(9, 5), n = c(40, 40))
# null: population proportions are the same
# alternative: population proportions differ
# p.value = 0.3774 > 0.01 => do not reject the null

# this gives us a confidence interval as well
# proportion ("first group" - "second group")
# data for men first
# difference in proportions "male - female"
# the interval contains 0 so the difference among
# male and female is not significant

# Does not contain zero
# Differences are positive 
# proportion first group > proportion second group
# [0.1, 0.3]

# [0.0000001, 0.0000003]
# some people like reporting CI for differences
# better than p-values because they contain information
# about magnitude and sign of effects which p-values
# do not contain

# test H0: men and women lie at the same rate
# against H1: men lie more than women


# prop.test(x, n, p )
# Required inputs:
# x = number of successes / events
# n = sample size 
# Optional: 
# p = value of the true proportion that you hypothesize
# under the null hypothesis
# conf.level = confidence level of the test
