##########################
# Identifying a maximum  #
##########################

library(tidyverse)
library(gapminder)
data(gapminder)

# Maximum gdpPercap in gapminder dataset?
# ---------------------------------------

# Old R
# which.max: allows us to identify the index (row) of the maximum
which.max(gapminder$gdpPercap)
gapminder[which.max(gapminder$gdpPercap),]

# tidyverse
gapminder %>% arrange(desc(gdpPercap)) # solved by sorting
gapminder %>% filter(gdpPercap == max(gdpPercap)) # solved by picking out maximum

# Maximum gdpPercap in Europe in 2007?
# ------------------------------------

# Old R

# 1. create a subset that only contains data from Europe and 2007
cond1 = gapminder$continent == "Europe" & gapminder$year == 2007
europe2007 = gapminder[cond1,]
# 2. use which.max
europe2007[which.max(europe2007$gdpPercap),]

# tidyverse

# 1. create a subset that only contains data from Europe and 2007
europe2007 = gapminder %>% filter(continent == "Europe" & year == 2007)
# 2. identifying the max
europe2007 %>% arrange(desc(gdpPercap))

# 1. filter out any observations that are not from 2007 (keep 2007 data only)
# 2. group_by(continent): all computations will be done by continent separately
# 3. use filter to get the maximum gdp
gapminder %>% filter(year == 2007) %>% group_by(continent) %>% filter(gdpPercap == max(gdpPercap))
