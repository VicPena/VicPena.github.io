
## chi-squared tests of independence for categorical variables

# read in hsb2
library(tidyverse)
library(openintro)
data(hsb2)

# a team of social scientists want to test 
# whether the distribution of `ses` depends on `race`
ggplot(hsb2) +
  aes(x = ses, fill = race) +
    geom_bar(position = "fill")

# do a chi-squared test 
tab = table(hsb2$ses, hsb2$race)
chisq.test(tab)
