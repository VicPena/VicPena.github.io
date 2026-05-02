##################
## Sorting data ##
##################
data(iris)

# Old R
# ------

# sort: sorting individual vectors

# sort Sepal.Length in increasing order
sort(iris$Sepal.Length)
# sort Species in increasing (alphabetic) order
sort(iris$Species)

# sort Sepal.Length in decreasing order
sort(iris$Sepal.Length, decreasing = T)

# sort iris dataset in increasing order by Sepal.Length

# 1. use order to get indices 
# 2. use output for indexing

iris[order(iris$Sepal.Length),] # increasing
iris[order(iris$Sepal.Length, decreasing = T),] # decreasing
iris[order(-iris$Sepal.Length),] # decreasing, in the notes


# dplyr
# -----

library(dplyr)
# arrange (sort) iris in increasing order by Sepal.Length
iris %>% arrange(Sepal.Length)

# arrange (sort) iris in desc order by Sepal.Length
iris %>% arrange(desc(Sepal.Length))

# arrange (sort) iris in decreasing order by Species, 
# then in increasing order by Petal.Width
iris %>% arrange(Species, Sepal.Length) # sort by scond variable if there are ties
