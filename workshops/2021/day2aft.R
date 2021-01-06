##########
# ggplot #
##########

# Reference for plots:
# http://www.cookbook-r.com/Graphs/

# ggmaps: maps!
# gganimate: animations

library(tidyverse)
install.packages("openintro")
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
  aes(x = math) +
    geom_histogram() +
      ggtitle("Math scores") +
        xlim(0, 100) +
          ylim(0, 50) +
            xlab("math scores") + 
              ylab("frequency")

ggplot(hsb2) +
  aes(y = math) +
  geom_boxplot() +
  ggtitle("Math scores") 

# suppose that you want a sequence that goes grom 30 to 100 in steps of 10
seq(30, 100, 10)

# Plot of race
ggplot(hsb2) +
  aes(x = race) +
    geom_bar() +
      ggtitle("Plot of race")


###################
# Bivariate plots #
###################

# two numerical variables

# Plot of math against read
ggplot(hsb2) +
  aes(x = read, y = math) +
    geom_point() +
      geom_smooth()

ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() +
  geom_smooth(method = "lm")

# two categorical variables

# Plot of ses against race
ggplot(hsb2) +
  aes(x = ses, fill = race) +
    geom_bar()
# stacked barplot

ggplot(hsb2) +
  aes(x = ses, fill = race) +
  geom_bar(position = "dodge")
#  side-by-side bars

ggplot(hsb2) +
  aes(x = ses, fill = race) +
  geom_bar(position = "fill")
# column proportions

ggplot(hsb2) +
  aes(x = race, fill = ses) +
  geom_bar(position = "fill")



# Plot of math (numerical) against ses (categorical)
ggplot(hsb2) +
  aes(x = ses, y = math) +
    geom_boxplot()

ggplot(hsb2) +
  aes(x = math, fill = ses) +
    geom_histogram()

# facet_grid (graphical group_by)
ggplot(hsb2) +
  aes(x = math) +
    geom_histogram() +
      facet_grid(ses ~ .)

ggplot(hsb2) +
  aes(x = math) +
  geom_histogram() +
  facet_grid(. ~ ses)

ggplot(hsb2) +
  aes(x = math) +
  geom_histogram() +
  facet_grid(gender ~ ses) # rows first, columns second


ggplot(hsb2) +
  aes(x = math, fill  = gender) +
  geom_histogram() +
  facet_grid(ses ~ gender) # rows first, columns second

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
    geom_point() +
      geom_smooth(method = "lm") + 
        facet_grid(ses ~ .)

ggplot(hsb2) +
  aes(x = math, y = read) +
  geom_smooth(method = "lm") + 
  facet_grid(ses ~ .)

ggplot(hsb2) +
  aes(x = math, y = read, color = ses) +
    geom_smooth(method = "lm", se = FALSE) # se = FALSE gets rid of the confidence interval

ggplot(hsb2) +
  aes(x = math, y = read, color = ses, shape = ses, linetype = ses) +
  geom_point() +
    geom_smooth(method = "lm", se = FALSE) 






#############
# gapminder #
#############

library(gapminder)
data(gapminder)
?gapminder


# ggplot(<data>)+
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)
# geom_point(), geom_bar(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid
# change labels, title, theme

# plot life exp (numeric) v gdp per capita (numeric) using data from 2007 only
year2007 = gapminder %>% filter(year == 2007)
ggplot(year2007) +
  aes(x = (lifeExp), y =(gdpPercap)) +
   geom_point() + geom_smooth() +
    facet_grid(continent ~ .)

year2007 %>% filter(continent == "Oceania")
  



# plot average gdp per capita by continent over the years

# I want separate averages of gdp per capita
# for each combination of year and continent
# I want an average for Africa in 1952, etc.



# create a dataset that has 3 variables
# continent
# year
# average gdp per capita in that continent and year
bycontinent = gapminder %>% group_by(continent, year) %>% summarize(avgGdp = mean(gdpPercap)) 

ggplot(bycontinent) +
  aes(x = year, y = avgGdp, color = continent) +
    geom_point() + geom_line()

ggplot(bycontinent) +
  aes(x = year, y = avgGdp, color = continent) +
  geom_point() + geom_line() +
    facet_grid(. ~ continent)

ggplot(gapminder) +
  aes(x = as.factor(year), y = gdpPercap) +
    geom_boxplot() +
      facet_grid(continent ~ .)

# relationship of gdpcapita versus life expectancy by continent
ggplot(gapminder) + 
  aes(x = gdpPercap, y = lifeExp) +
    geom_point() +
      facet_grid(continent ~ .)

gapminder %>% filter(gdpPercap > 90000)

###########################
# ggplot: improving plots #
###########################
library(tidyverse)






# math scores by ses


# change theme
# Default themes: theme_minimal, theme_bw theme_light, etc.
# https://ggplot2.tidyverse.org/reference/ggtheme.html

# relationship of gdpcapita versus life expectancy by continent
ggplot(gapminder) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_grid(continent ~ .) +
  theme_light()

# library(ggthemes): https://github.com/jrnold/ggthemes
install.packages("ggthemes")
library(ggthemes)
# some themes in ggthemes: theme_tufte, theme_wsj, theme_economist, theme_fivethirtyeight
ggplot(gapminder) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_grid(continent ~ .) +
  theme_excel()


# change colors
ggplot(gapminder) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point(color = "slateblue")

# Have a list of colors: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# race and ses
ggplot(hsb2) +
  aes(x = race, fill = ses) +
    geom_bar(position = "fill") +
      scale_fill_manual(values = c("red", "yellow", "darkgreen")) +
        theme_bw() +
          ggtitle("Race vs ses")


ggplot(hsb2) +
  aes(x = race, fill = ses) +
  geom_bar(position = "fill") +
  scale_fill_brewer(palette = "Accent") +
  theme_bw() +
  ggtitle("Race vs ses")



# change color palette: https://ggplot2.tidyverse.org/reference/scale_brewer.html







