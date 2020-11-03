###############
# More ggplot #
###############

library(tidyverse)
library(openintro)

data(hsb2)
View(hsb2)
?hsb2

####################
# Univariate plots #
####################

# ggplot(<dataset>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# add facets, transformations, change themes, etc.

# Plot of math
ggplot(hsb2) + 
  aes(x = math) + # the variables that go in the plot along with their role
    geom_histogram() +
      ggtitle("Histogram of math scores") + 
        xlab("math scores in test") +
          ylab("count of students")

# Plot of race
ggplot(hsb2) +
  aes(x = race) +
    geom_bar()

ggplot(hsb2) +
  aes(y = race) +
  geom_bar()


###################
# Bivariate plots #
###################

# Plot of math against read
ggplot(hsb2) +
  aes(x = math, y = read) +
    geom_point() +
      geom_smooth()

ggplot(hsb2) +
  aes(x = math, y = read) +
  geom_point() +
   geom_smooth(method = "lm")

# Plot of ses against race
ggplot(hsb2) +
  aes(x = ses, fill = race) + 
    geom_bar()

ggplot(hsb2) +
  aes(x = ses, fill = race) + 
  geom_bar(position = "dodge")

ggplot(hsb2) +
  aes(x = ses, fill = race) + 
  geom_bar(position = "fill")

# Plot of math against ses
# facet_grid (graphical group_by)
ggplot(hsb2) +
  aes(x = math) +
    geom_histogram() +
      facet_grid(ses ~ .)

ggplot(hsb2) +
  aes(x = math) +
  geom_histogram() +
  facet_grid(. ~ ses)


hsb2 %>% group_by(ses) %>% summarize(mean(math))

