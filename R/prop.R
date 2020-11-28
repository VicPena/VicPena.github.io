#################################
# CIs and tests for proportions #
#################################

# Confidence intervals:
# 1. Ranges of values that are "plausible" given the data
# 2. Random intervals with long-run guarantee that 
# they trap the "true" population values with relative frequency equal 
# to confidence level (e.g. 95% CIs trap the truth 95% of the time)
# 3. Useful because they quantify our uncertainty; not just "one value"

# Hypothesis tests
# Operationally, they work like this:
# 1. Set null and alternative hypothesis, as well as a significance level
# 2. Collect data and find p-value
# 3. Compare p-value against significance level:
#      if p-value < significance level => reject the null
#      if p-value >= significance level => fail to reject the null
# This procedure has a long-run guarantee: for example, 
# if you set your significance level at 5%, you will wrongly
# reject the null 5% of the time 

## One proportion 


# Do people ever regret getting a tattoo?
# In a 2012 poll by Harris Interactive, 
# 59 out of 423 respondents said yes. 
# Based on the data in this study, 
# find a 99% confidence interval the proportion of people 
# with tattoos who regret getting one. 

# use prop.test, conf.level = 0.99
prop.test(59, 423, conf.level= 0.90)

# test p = 0.2 against p less than 0.2
prop.test(59, 423, p = 0.2, alternative = "less")

## Two proportions


#  In a study about online dating, 
# 9 out of 40 males lied about their age
# and 5 out of 40 females lied about their age. Find a 95% confidence
# interval for the difference
# (% of men who lie about their age) - (% of women who lie about their age).

# use prop.test
prop.test(c(9, 5), c(40, 40))


# test H0: men and women lie at the same rate
# against H1: men and women lie at different rates

