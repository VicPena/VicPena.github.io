################# 
# One-way ANOVA #
#################


# Example: Comparing 3 treatments

# reading data
library(tidyverse)
wide = matrix(c(4, 7, 9,
                2, 6, 12,
                6, 5, 6,
                6, 7, 11,
                5, 6, 10,
                6, 4, 11,
                2, 7, 9,
                6, 5, 10), byrow = T, ncol = 3)
wide = as.data.frame(wide)
colnames(wide) = c("T1", "T2", "T3")

# converting from wide to long format
df = wide %>% pivot_longer(cols = c(T1, T2, T3),
                              names_to = "treat",
                              values_to = "outcome")
df$treat = factor(df$treat)


# fitting model (-1 excludes intercept)
mod = aov(outcome ~ treat - 1, data = df) 
# coefficients
dummy.coef(mod)
# confidence intervals
confint(mod)


# conversion to sum-to-zero
options(contrasts = c("contr.sum", "contr.poly")) 
# refit model
mod_sum = aov(outcome ~ treat, data = df)
dummy.coef(mod_sum)
confint(mod_sum)

# checking normality
plot(mod, which = 2)
# checking equality of variances
boxplot(outcome ~ treat,  data = df)

# ANOVA table
summary(mod)

# Tukey HSD
TukeyHSD(mod, conf.level = 0.95)



