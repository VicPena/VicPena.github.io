######################
# library(tidyverse) #
######################

install.packages("tidyverse")
library(tidyverse)



##########################
## Subsetting variables ##
##########################

data(iris)
# first second and fifth column of iris
# can also subset by telling R to exclude



# select creates subsets of variables
# for example, create a subset of iris with
# first, second, and fifth columns

# order matters: if you want to get variable 5 first in the new dataset


# we can use variable names,
# e.g. Sepal.Length, Sepal.Width, Species

# nb: don't have to type "iris$ " all the time, which is nice

# you can exclude variables too
# e.g. exclude Sepal.Length and Sepal.Width
