
#' We will use the `diamonds` dataset in `library(ggplot2)`, so we load the library and the dataset.
#' 
## ------------------------------------------------------------------------
library(ggplot2)
data(diamonds)



## barplots


# you can change the font size of qplots with theme(text=element_text(size=...))

# you can change the color of the bars 
 
# and flip the coordinates

# you can add a title

---------------------------------------------------------------------
barcut = barcut+ggtitle("Quality of cut")
barcut 

# If you want to center the title: theme(plot.title = element_text(hjust = 0.5))

 

# You can change the general theme quite easily as well: https://ggplot2.tidyverse.org/reference/ggtheme.html


## histograms 

## density plots

## stacked barplots

# you can play around with the color palette with `scale_fill_brewer`. 
# e.g. +scale_fill_brewer(palette="Spectral")

#
# More info [here](https://ggplot2.tidyverse.org/reference/scale_brewer.html) 


## density plots by categories


## side-by-side boxplots are a better alternative:


# you can add color using `fill`:

# the code `theme(legend.position="none")` gets rid of the legend. 

## scatterplots

# you can add smoothed trends with geom_smooth()