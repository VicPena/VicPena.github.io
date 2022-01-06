############
# Overview #
############
# Plots!
# - Univariate plots (one variable)
# - Bivariate plots (two variables)
# - More than two variables 
# - Exercises
# - Improving plots 
# - Interactive plots with plotly

# Reference for plots:
# http://www.cookbook-r.com/Graphs/


####################
# Univariate plots #
####################


library(tidyverse)


install.packages("openintro")
library(openintro)

# ggplot for plotting


data(hsb2)
View(hsb2)
?hsb2

# ggplot(<dataset>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# add facets, transformations, change themes, etc.

# Numerical data: histograms, boxplots
# Categorical data: barplots

# Plot of math
# histogram
ggplot(hsb2) +
  aes(x = math) +
    geom_histogram(bins = 30)

# boxplot
ggplot(hsb2) +
  aes(x = math) +
  geom_boxplot()


# Plot of race

# 1st step: create a table with counts
# for the variable that I want to display
tab = hsb2 %>% count(race) %>% mutate(perc = 100*n/sum(n))
tab

# ggplot(<dataset>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# add facets, transformations, change themes, etc.


# 2nd: ggplot on the table to create
# the barplot
ggplot(tab) +
  aes(x = race, y = n) +
    geom_col()

ggplot(tab) +
  aes(y = race, x = n) +
  geom_col()

# geom_col: stands for geom_column
tab
# create a plot with the percentages
ggplot(tab) +
  aes(y = race, x = perc) +
    geom_col() +
      xlab("percentages of ethnicities") +
       ylab("ethnicity") +
        xlim(0, 100) +
          ggtitle("Percentages of ethnicities in hsb2 dataset")


ggplot(tab) +
  aes(x = race, y = perc) +
  geom_col() +
  ylab("percentages of ethnicities") +
  xlab("ethnicity") +
  ylim(0, 100) +
  ggtitle("Percentages of ethnicities in hsb2 dataset")
# xlab: x-label
# ylab: y-label
# xlim: limits of the x-axis when the x-axis is numeric
# ylim: limits of the y-axis whenever it is numeric


###################
# Bivariate plots #
###################

# two numerical variables: scatterplot
# one numerical one categorical: boxplots, histograms
# two categorical: barplots stacked or side-by-side


# Plot of math against read
# both numerical variables
# scatter plot

# ggplot(<dataset>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# add facets, transformations, change themes, etc.

# add in trend
ggplot(hsb2) +
  aes(x = read, y = math, color = ses, size = science) +
    geom_point() +
     geom_smooth(se = FALSE) +
      scale_color_manual(values = c("blue","coral2","mediumpurple1")) +
        facet_wrap(ses ~ gender, nrow = 3)


ggplot(hsb2) +
  aes(x = read, y = math, color = gender) +
    geom_point() +
      geom_smooth(method = "lm", se = FALSE)


ggplot(hsb2) +
  aes(x = read, y = math, color = gender) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ gender)




# we can include variables by
# - using color-coding with color
# - sizes of points with size
# - facetting: up to two variables
# if you do facetting with two variables:
#  first: on the rows
#  second variable: columns




# an example of 
# a plot displaying
# - math, read, ses, gender

# by default this is a non-linear trend
# non-linear trend with 95% pointwise confidence interval 
# (shaded region)

ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) 
# method = "linear model"
# se = FALSE gets rid of the shaded region around the line


# xlab, ylab, xlim, ylim, and ggtitle
# all work in all types of ggplots

# Plot of math (numerical) against ses (categorical)

# ggplot(<dataset>) +
# aes(x =, y =, color =, fill = , shape =  , linetype, ...) +
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# add facets, transformations, change themes, etc.

ggplot(hsb2) +
  aes(y = ses, x = math) +
    geom_boxplot()

# facet_wrap (graphical version of group_by)
ggplot(hsb2) +
  aes(x = math) +
    geom_histogram() +
      facet_wrap(~ ses)

ggplot(hsb2) +
  aes(x = math) +
  geom_histogram() +
  facet_wrap(~ race)
# tilde ~ 

ggplot(hsb2) +
  aes(x = math) +
    geom_boxplot() +
      facet_wrap( ~ ses, nrow = 3)




# Plot of ses against race

# 1st step a table
# that has counts of all combinations of ses and race
tab2 = hsb2 %>% count(ses, race)

# 2nd create the plot 
# with ggplot
ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
    geom_col()

ggplot(tab2) +
  aes(x = race, y = n, fill = ses) +
  geom_col()


# geom_col: creates barplots

# position = "dodge"
# install.packages("ggthemes")
library(ggthemes)
library(tidyverse)
barplot = ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
   geom_col(position = "dodge") +
    scale_fill_manual(values = c("lightslateblue",
                                 "olivedrab3",
                                 "plum2",
                                 "firebrick2")) +
     theme_excel_new()

ggplotly(barplot)
# fill: bars
# color: coloring points

# changing colors:
# scale_fill_manual if used fill for defining the colors
# scale_color_manual if used color for defining the colors


# These are the ones that I like best
# position = "fill"
ggplot(tab2) +
  aes(x = ses, y = n, fill = race) +
  geom_col(position = "fill")

bar2 = ggplot(tab2) +
  aes(x = race, y = n, fill = ses) +
  geom_col(position = "fill")

ggplotly(bar2)
tab2



#####################################
# More than 2 variables in one plot #
#####################################

# ggplot(<data>)
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# facetting
# xlab, ylab, xlim, ylim, ggtitle, ...


# math scores vs reading scores by gender
ggplot(hsb2) +
  aes(x = read, y = math, color = gender) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ gender)


# math scores vs reading scores by gender and ses
ggplot(hsb2) +
  aes(x = read, y = math, color = gender) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(ses ~ gender, nrow = 3)

ggplot(hsb2) +
  aes(x = read, y = math, color = science) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ ses, nrow = 3)



ggplot(hsb2)+
  aes(x=read, y=math,color=ses, size=science)+
  geom_point()+
  geom_smooth(se=FALSE)+
  scale_color_manual(values=c('blue','coral2','mediumpurple1'))+
                    facet_wrap(ses~gender, nrow=3)






############################
# Exercises with gapminder #
############################

library(gapminder)
data(gapminder)
?gapminder


# ggplot(<data>)+
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# faceting w/ facet.grid
# change labels, title, theme

# plot life exp (numeric) v gdp per capita (numeric) 
# using data from 2007 only

# use geom_text to label points



# plot average gdp per capita by continent over the years


# relationship of gdpcapita versus life expectancy by continent



#################################
# Interactive plots with plotly #
#################################
install.packages("plotly")
library(plotly)

# plot life exp (numeric) v gdp per capita (numeric) 
# using data from 2007 only
# add in countries as labels
library(gapminder)
data(gapminder)
gapminder

# it is useful to create a dataset that has 
# dta with 2007 only 
# that can be accomplished with a filter! 
# which we saw
gap2007 = gapminder %>% filter(year == 2007)
# plot life exp (numeric) v gdp per capita (numeric) 


# each point is a different country
# how can I identify the countries?

# add in label = country in aes, and save ggplot 
interact = ggplot(gap2007) +
  aes(x = lifeExp, y = gdpPercap, size = pop, label = country, color = continent) +
  geom_point() +
  geom_smooth(se = FALSE)

# run ggplotly function on saved plot
ggplotly(interact)

