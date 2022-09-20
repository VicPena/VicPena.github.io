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

# Example: Doughnuts
# During cooking, doughnuts absorb fat in various
# amounts. Lowe wished to learn if the amount
# absorbed depends on the type of fat used
# For each of four fats, six batches
# of doughnuts were prepared. The data 
# in the table below are the grams of fat
# absorbed per batch, coded by deducting 100g
# to give simpler figures

mat = matrix(c(64, 78, 75, 55,
               72, 91, 93, 66,
               68, 97, 78, 49,
               77, 82, 71, 64,
               56, 85, 63, 70,
               95, 77, 76, 68), byrow = T, ncol = 4)
colnames(mat) = c("T1", "T2", "T3", "T4")
mat = as.data.frame(mat)

dough = mat %>% pivot_longer(cols = c(T1, T2, T3, T4),
                             names_to = "type",
                             values_to = "fat")

# plot data

# run aov 

# check assumptions

# run global test

# run pairwise comparisons





