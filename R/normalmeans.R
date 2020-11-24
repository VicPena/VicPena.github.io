###########################################
# Confidence intervals & Hypothesis tests #
###########################################

library(tidyverse)

# Inference on population means (based on normal dist'n)
#-------------------------------------------------------

# one mean
#---------

# Assumptions:
# 1. observations are independent
# 2. if sample size is small (n < 30), data are roughly bell-shaped 
# and thin-tailed
# 3. if sample size is big, data don't have to look bell-shaped;
# thin-tailedness is enough


# scientists recorded some measurements stored in x
x = c(1,4,2,3,6,9,1,3,9,3)

# visualize data
library(tidyverse)
qplot(x)

mean(x)

# provide a 99% confidence interval for the population mean
# (interval based on normal distribution)
t.test(x, conf.level = 0.99)

# Test H0: population mean is equal to 0 
#      H1: population mean is NOT equal to 0

# pre-set a signifcance level (usually it's 5%, which is 0.05)
# we find the p-value 
# compare the p-value against the significance level
# if p-value is less than significance level, then we reject the null
# if p-value is greater than the significance level, we fail to reject the null
# Conclusion: I reject the null hypothesis at the 0.05 significance level
# because p-value (0.001774) is smaller than 0.05.

# H0: true mean is equal to 5
# H1: true mean is less than 5


# Test H0: population mean is equal to 5
#      H1: population mean is less than 5
t.test(x, mu = 5, alternative = "less"  )
# Conclusion: fail to reject null hypothesis (pop. mean is equal to 5)
# at the 5% significance level because the p-value (0.1808) is greater
# than 0.05.

# comparing two means
#---------------------

# A pharmaceutical is interested in knowing whether 
# their new treatment is significantly different 
# than the current gold standard. 
# They collected a sample of 40 individuals:
# 20 of them were assigned the new treatment, 
# and 20 of them were assigned the current treatment. 
# The outcome is on an ordinal scale that goes 
# from 0 to 100, where 0 is "bad" and 100 is "great".

# read in the data
pharma = read.csv("https://vicpena.github.io/sta9750/fall18/pharma.csv")
str(pharma)

# find means and standard deviations by group
pharma %>% group_by(group) %>% summarize(avgOutcome = mean(outcome), sdOutcome = sd(outcome))

# visualize the data
qplot(y = outcome, x = group, data  = pharma) + geom_boxplot()

# find 95% confidence interval for difference
# (pop mean current treatment) - (pop mean new treatment)

# Test H0: treatments are the same
#      H1: treatments are different
t.test(outcome ~ group, data = pharma )

# Next up: proportions
