##########
# ggplot #
##########

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

# Plot of race



###################
# Bivariate plots #
###################

# Plot of math against read



# Plot of ses against race


# Plot of math against ses
# facet_grid (graphical group_by)





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

# now, do math vs read scores scores by ses
# facet_grid: graphical analogue to group_by


# math scores


# now, do math scores by ses and gender

#############
# gapminder #
#############

library(gapminder)
data(gapminder)
?gapminder


# plot life exp v gdp per capita using data from 2007 only


# same, but break it up by continent


# plot average gdp per capita by continent over the years



###########################
# ggplot: improving plots #
###########################
library(tidyverse)

# More: http://www.cookbook-r.com/Graphs/


# ggplot(<data>)

# variables that are in the plot along with their role
# aes(x =, y =, color =, fill = , shape =  , linetype, ...)

# geom_point(), geom_bar(), geom_line(), geom_smooth()... 

# faceting w/ facet.grid

# change labels, title, theme


library(openintro)

data(hsb2)
View(hsb2)

# math vs reading scores
# add title
# change x and y labels
# change x and y limits




# math scores by ses


# change theme
# Default themes: theme_minimal, theme_bw theme_light, etc.
# https://ggplot2.tidyverse.org/reference/ggtheme.html



# library(ggthemes): https://github.com/jrnold/ggthemes
library(ggthemes)
# some themes in ggthemes: theme_tufte, theme_wsj, theme_economist, theme_fivethirtyeight


# change colors

# race and ses

# change color


# change color palette: https://ggplot2.tidyverse.org/reference/scale_brewer.html







