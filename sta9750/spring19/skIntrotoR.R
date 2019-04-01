

#' 
#' # Creating variables 
#' 
#' We can create variables by assigning them values:
#' 
## ------------------------------------------------------------------------
firstvariable = 0 
secondvariable = 10
thirdvariable = TRUE
fourthvariable = "hello"

#' 
#' If we want to print a variable, we can type its name. 
#' 
## ------------------------------------------------------------------------

#' 
#' We can see the "type" of the variables using the function `class`:
#' 
## ------------------------------------------------------------------------



#' 
#' ## Operations with variables
#' 
#' We can add, subtract, multiply, divide, and exponentiate `numeric` variables:
#' 
## ------------------------------------------------------------------------


#' We can combine operations. For example, we can compute the average of `firstvariable` and `secondvariable` as
#' 
## ------------------------------------------------------------------------


#' 
#' `R` has a built-in `mean` function, which we'll see later.
#' 
#' We can't add, subtract, multiply, divide or exponentiate `character` variables (try it out: it'll give you an error)
#' 
#' 


#' We can add, subtract, multiply, divide or exponentiate `logical` variables. 
#' If the variable is `TRUE` it'll be treated as a `1`; if it's `FALSE`, it'll be treated as a `0`:
#' 
## ------------------------------------------------------------------------
logi1 = TRUE
logi2 = FALSE



#' Finally, we can do operations without using variables at all:
#' 
## ------------------------------------------------------------------------
6/2*(2+1+TRUE)



#' ## Arithmetic functions
#' 
#' R has built-in functions such as `sqrt`, `exp`, `log`, ...
#' 
## ------------------------------------------------------------------------



#' 
#' If you're not sure how a function works, you can ask for help by writing `?` before the name of the function.
#' 


#' #  Vectors
#' 
#' We can define vectors as follows:
#' 
## ------------------------------------------------------------------------
x1 = c(1, 2, 3, 4, 5, 6)
y1 = c("a","b","c","d","efg")
z1 = c("a", 2, 3, "e")

#' 
#' We can create ranges of values with `:`
#' 
## ------------------------------------------------------------------------

#' 
#' ## Operations with vectors
#' 
#' We can add, multiply, divide, etc. all the components of a `numeric` vector by the same number:
#' 
## ------------------------------------------------------------------------


#' 
#' We can add and subtract vectors of the same length:
#' 
## ------------------------------------------------------------------------
x2 = c(7, 8, 9, 10, 11, 12)


#' 
#' Similarly, we can do **componentwise** multiplication and division:
#' 
## ------------------------------------------------------------------------


#' 
#' If two vectors are of different lengths, we have to be careful! `R` won't give us a warning message:
#' 
## ------------------------------------------------------------------------
x1
x3 = c(2,3)


#' 
#' We can compute the dot product of 2 `numeric` vectors of the same length as follows
#' 
## ------------------------------------------------------------------------


#' 
#' We can compute means, standard deviations, variances, etc:
#' 
## ------------------------------------------------------------------------



#' 
#' ## `length` and concatenating 
#' 
#' We can find the length of a vector with `length`:
#' 
## ------------------------------------------------------------------------

#' 
#' And we can add values to an existing vector:
#' 
## ------------------------------------------------------------------------

#' 
#' We can concatenate vectors, too:
#' 
## ------------------------------------------------------------------------


#' 
#' 
#' ## Indexing vectors
#' 
#' We can look at particular entries of a vector using brackets.
#' 
## ------------------------------------------------------------------------

#' 
#' We can access subsets of vectors using vectors. For example, if we want to print the third and fifth entries of `x1`:
#' 

#' 
#' We can subset using ranges of values with `:`. For instance, if we want to select the second, third, fourth, and fifth entries of `x1`:
#' 


#' # Matrices
#' 
#' We can create matrices as follows:

A1 = matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE) # read by row 
A2 = matrix(c(1,3,2,4), nrow=2, ncol=2, byrow=FALSE) # read by column

#' 
#' Doing operations with matrices is straightforward:
#' 
## ------------------------------------------------------------------------
 # matrix product
 # componentwise product
 # componentwise addition
 # taking the log of the components

#' 
#' Indexing matrices is similar to indexing vectors. For example, if we want to access the element in the first row and second column of `A1`:
#' 
## ------------------------------------------------------------------------
# accessing entries: rows first, then columns

#' 
#' You can also index by full rows and columns. For example, if you want to select the first row of `A1`:
#' 
## ------------------------------------------------------------------------


#' 
#' If you want to access the second column:
#' 


#' 
#' # Installing libraries
#' 


#' # Introduction to displaying and summarizing data
#' 
library(ggplot2)
data(mpg) 

str(mpg) 

#' We can print the first and last 5 observations in the dataset using `head` and `tail`:

head(mpg)
tail(mpg)

#' 
#' We can index the rows and columns of `mpg` using the same syntax we used for indexing matrices:
#' 


#' 
#' 
#' We can get quick summaries of `numeric` variables using `summary`
#' 


#' 
#' With `data.frames` we can extract variables using `$`. For example, if we want to look at `year`:
#' 
## ------------------------------------------------------------------------

#' 
#' We can tabulate with `table`
#' 
## ------------------------------------------------------------------------



#' 
#' We can plot stuff, too. For example, `hist` does histograms:
#' 
## ------------------------------------------------------------------------


#' 
#' You can learn more about how to change the attributes of the plot with `?hist`.
#' 
#' We can create individual boxplots and boxplots grouped by values of categorical variables:
#' 
## ------------------------------------------------------------------------


#' A nice thing about `ggplot2` is that it has the function `qplot`, which produces good-looking plots by default. 
#' 

#' 
#' `qplot` is smart enough to produce different plots depending on the type of the object. We'll cover `ggplot2` in more detail later in the semester.
