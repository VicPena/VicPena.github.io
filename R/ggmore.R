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
ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() 

# add title
ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() +
  ggtitle("Math vs read") +
  theme(plot.title = element_text(hjust = 0.5))

# change x and y labels
ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() +
  ggtitle("Math vs read") +
  theme(plot.title = element_text(hjust = 0.5)) +
    xlab("reading scores") +
      ylab("math scores")

# change x and y limits
ggplot(hsb2) +
  aes(x = read, y = math) +
  geom_point() +
  ggtitle("Math vs read") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("reading scores") +
  ylab("math scores") +
  xlim(0, 100) +
  ylim(0, 100)




# math scores by ses
ggplot(hsb2) +
  aes(x = math, color = ses) +
  geom_density()

# change theme
# Default themes: theme_minimal, theme_bw theme_light, etc.
# https://ggplot2.tidyverse.org/reference/ggtheme.html
ggplot(hsb2) +
  aes(x = math, color = ses) +
  geom_density() +
  theme_bw()


# library(ggthemes): https://github.com/jrnold/ggthemes
library(ggthemes)
# some themes in ggthemes: theme_tufte, theme_wsj, theme_economist, theme_fivethirtyeight
ggplot(hsb2) +
  aes(x = math, color = ses) +
  geom_density() +
  theme_fivethirtyeight()


# change colors
ggplot(hsb2) +
  aes(x = math, color = ses) +
  geom_density() +
  theme_fivethirtyeight() +
  scale_color_manual(values = c("lightblue", "lightblue3", "lightblue4"))

# race and ses
ggplot(hsb2) +
  aes(x = ses, fill = race) +
  geom_bar()

# change color
ggplot(hsb2) +
  aes(x = ses, fill = race) +
  geom_bar() +
  scale_fill_manual(values = c("salmon", "seagreen", "royalblue", "rosybrown3"))
  
  
# change color palette: https://ggplot2.tidyverse.org/reference/scale_brewer.html
ggplot(hsb2) +
  aes(x = ses, fill = race) +
  geom_bar() +
  scale_fill_brewer(palette = "Blues")







