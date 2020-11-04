#####################################
# More than 2 variables in one plot #
#####################################

# ggplot(<data>)
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid
# change labels, title, theme

#############
# Hsb2 data #
#############
library(tidyverse)
library(openintro)
data(hsb2)
?hsb2

# math scores vs reading scores 
ggplot(hsb2) +
  aes(x = math, y = read) +
  geom_point()

# now, do math vs read scores scores by ses
# facet_grid: graphical analogue to group_by
ggplot(hsb2) +
  aes(x = math, y = read) +
  geom_point() +
    facet_grid(ses ~ .)

ggplot(hsb2) +
  aes(x = math, y = read) +
  geom_point() +
  facet_grid(. ~ ses) +
    geom_smooth(method = "lm")

ggplot(hsb2) +
  aes(x = math, y = read, color = ses) +
  geom_point()

# math scores
ggplot(hsb2) +
  aes(x = math) +
  geom_boxplot()

# now, do math scores by ses and gender
ggplot(hsb2) +
  aes(x = math) +
  geom_boxplot() +
    facet_grid(ses ~ gender)

#############
# gapminder #
#############

library(gapminder)
data(gapminder)
?gapminder


# plot life exp v gdp per capita using data from 2007 only
gap2007 = gapminder %>% filter(year == 2007)
ggplot(gap2007) +
  aes(x = gdpPercap, y = lifeExp) +
    geom_point() +
      geom_smooth()

# same, but break it up by continent
ggplot(gap2007) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  geom_smooth() +
  facet_grid(continent ~ . ) 

ggplot(gap2007) +
  aes(x = gdpPercap, y = lifeExp, color = continent) +
  geom_point() 


# plot average gdp per capita by continent over the years
cont = gapminder %>% group_by(year, continent) %>% summarize(avgGdp = mean(gdpPercap))
cont

ggplot(cont) +
  aes(x = year, y = avgGdp) +
    geom_point() +
      facet_grid(continent ~ . )


ggplot(cont) +
  aes(x = year, y = avgGdp) +
  geom_line() +
  facet_grid(continent ~ . )

ggplot(cont) +
  aes(x = year, y = avgGdp, color = continent) +
    geom_line()
