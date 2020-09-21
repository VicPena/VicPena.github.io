##########################
# group_by and summarize #
##########################

library(tidyverse)
library(gapminder)
data(gapminder)
?gapminder

# average life expectancy by continent?
gapminder %>% group_by(continent) %>% summarize(lifeExpCont = mean(lifeExp) )
  
# average life expectancy by continent in 1952?
gapminder %>% filter(year == 1952) %>% group_by(continent) %>% summarize(lifeExpCont = mean(lifeExp) )

# average population by continent in 1997?
gapminder %>% filter(year == 1997) %>% group_by(continent) %>% summarize(avgPopCont = mean(pop) )

# how many countries in each continent had a GDP over $10k in 2007?
gapminder %>% filter(year == 2007 & gdpPercap > 10000) %>% group_by(continent) %>% summarize(count = n())

# find average life expectancy by continent in 1952 and 2007?
year1952 = gapminder %>% filter(year == 1952) %>% group_by(continent) %>% summarize(lifeExpCont = mean(lifeExp) )
year2007 = gapminder %>% filter(year == 2007) %>% group_by(continent) %>% summarize(lifeExpCont = mean(lifeExp) )
year1952$lifeExp2007 = year2007$lifeExpCont
year1952  

# in 2007, what % of countries in Europe had population over 50 million?
sub = gapminder %>% filter(year == 2007 & continent == "Europe")
cond = sub$pop > 5e7
100*prop.table(table(cond))
