# Overview
# - Univariate plots
# - Bivariate plots
# - More than two variables
# - Exercises
# - Improving plots 
# - Interactive plots with plotly


####################
# Univariate plots #
####################
# Reference for plots:
# http://www.cookbook-r.com/Graphs/


library(tidyverse)
install.packages("openintro")
library(openintro)

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

# Plot of race



###################
# Bivariate plots #
###################

# two numerical variables: scatterplot
# one numerical one categorical: boxplots, histograms
# two categorical: barplots

# Plot of math against read

# add in trend

# force trend to be linear


# 


# Plot of ses against race


# position = "dodge"

# position = "fill"

# add in percentages 



# Plot of math (numerical) against ses (categorical)


# facet_wrap (graphical group_by)




#####################################
# More than 2 variables in one plot #
#####################################

# ggplot(<data>)
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)
# geom_point(), geom_col(), geom_line(), geom_smooth()... 
# facetting
# xlab, ylab, xlim, ylim, ggtitle, ...


# math scores vs reading scores by gender


# math scores vs reading scores by gender and ses


# math scores vs reading vs write by gender and ses




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


###################
# improving plots #
###################
library(tidyverse)


# change theme
# Default themes: theme_minimal, theme_bw theme_light, etc.


# library(ggthemes): https://github.com/jrnold/ggthemes
install.packages("ggthemes")
library(ggthemes)
# some themes in ggthemes: theme_tufte, theme_wsj, theme_economist, theme_fivethirtyeight



# change colors
# List of colors: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

data(hsb2)
# math vs write by ses
# scale_color_manual(values = )
# scale_color_palette(palette = " ")
# https://ggplot2.tidyverse.org/reference/scale_brewer.html

# race and ses
# scale_fill_manual(values = )


#################################
# Interactive plots with plotly #
#################################

install.packages("plotly")
library(plotly)

# repeat plot life exp (numeric) v gdp per capita (numeric) 
# using data from 2007 only
# add in countries as labels


# save ggplot 

# run ggplotly on saved plot
