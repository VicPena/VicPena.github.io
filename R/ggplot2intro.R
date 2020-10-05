###########################
# Intro to ggplot2: qplot #
###########################

# Handout: https://vicpena.github.io/sta9750/plots.html
library(tidyverse)
data(diamonds)
?diamonds


#########################
# Categorical variables #
#########################

# qplot: quick plot

# barplot of cut
qplot(cut, data = diamonds) + 
  ggtitle("Quality of diamonds") + 
  xlab("quality") +
  ylab("count") + 
  coord_flip() +
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(text=element_text(size=15))

# some options:
# xlab, ylab: labels
# ggtitle: title
# coord_flip: flip coordinates
# theme: change "general appearance of plot"
# theme(plot.title = element_text(hjust = 0.5)): center title
# theme(text=element_text(size=15)): change font sizes to 15


################
# Quantitative #
################

# histogram of price
qplot(price, bins = 100, data = diamonds)

# can change num of bins

# density plot: smoothed out histogram
qplot(price, geom = "density", data = diamonds)

# boxplot
qplot(price, geom = "boxplot", data = diamonds) + coord_flip()


##############################
# Categorical vs categorical #
##############################

# cut (quality) vs color
qplot(cut, fill = color , data = diamonds) + 
  coord_flip() + 
  ggtitle("Quality vs color") +
  scale_fill_brewer(palette = "Pastel1")

# barplot



# scale_fill_brewer
# https://ggplot2.tidyverse.org/reference/scale_brewer.html

###############################
# Categorical vs quantitative #
###############################

# price vs cut (quality)

# side-by-side boxplots
# adding color, getting rid of legend, and flipping coordinates
qplot(x = cut, y = price, fill = cut, geom = "boxplot", data = diamonds) + 
  theme(legend.position="none") +
  coord_flip() 

# faceting by a variable: "group_by" 
qplot(price, facets = cut ~ ., data = diamonds) # by row
qplot(price, facets = . ~ cut, data = diamonds) # by column

################################
# Quantitative vs quantitative #
################################

#  scatterplot
# add non-smoothed trend
qplot(x = carat, y = price, data = diamonds) + geom_smooth()

# force linear trend
qplot(x = carat, y = price, data = diamonds) + geom_smooth(method = "lm")



