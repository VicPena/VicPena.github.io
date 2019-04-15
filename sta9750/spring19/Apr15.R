

## Prediction

# predict for nyctest

# create new dataset from scratch
# predict price for restaurant on east side with food = 20, decor = 5


## More ggplot2


library(ggplot2)
data(diamonds)


#' We can create scatterplots with colored dots of different shapes
#' 
#'  carat vs price, color-coded by cut, and shapes by cut



#' We can plot colored smoothed curves (potentially overlaid on points; not recommended, though).

#' We can plot panels with colored dots:

#' Double panels!

#' Double panels of colored dots...

#' How can we plot the relationship
#' between depth, carat and price?
#' 



# Create 2 plot figure w/ price and cut

#' 
#' Unfortunately, `par(mfrow=c(,))` doesn't work with `ggplot`. 
#' Fortunately, we have `grid.arrange` in `library(gridExtra)`:
#' 


#' Let's create a stacked % barplot:
## ------------------------------------------------------------------------

#' We can stretch out the bars:
## ------------------------------------------------------------------------

#' We can also create side-by-side bars:
## ------------------------------------------------------------------------

#' 
#' We can use the same structure to produce a color-coded scatterplot:
#' carat vs price, color-coded by cut
## ------------------------------------------------------------------------




#' 
#' 
#' ## Intro to the `library(dplyr)`

library(dplyr)
library(openintro)
data(hsb2)

#' 
#' ### `select`: select / drop variables
#' 

# select math, race, gender, ses


#' exclude variables `math`, `race`, `gender`, and `ses`:
#' 

#' Filter observations

# Math > 70 and public school


#' Math > 70 or public school



#' ### `mutate`: transform variables
#' 
#' 
# compute average score in math, science, socst, write, read

#' 
#' 
#' ### `arrange`: sort 
#' 
#' 
#' For example, if you want to sort by `avg`:
#' 
## ------------------------------------------------------------------------

#' 
#' If you want to sort in descending order
#' 
## ------------------------------------------------------------------------

#' 
#' 
#' ### `group_by` and `summarize`: obtain summaries by variables
#' 
#' Median, mean and sd scores by race
#' 
## ------------------------------------------------------------------------




