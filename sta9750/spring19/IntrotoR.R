#' ---
#' title: "Introduction to `R` "
#' author: "Víctor Peña"
#' output:
#'   html_document:
#'     toc: true
#'     theme: cosmo
#' ---
#' 
#' 
#' 
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

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
#' If we want to print a variable, we can type its name. For example:
#' 
## ------------------------------------------------------------------------
fourthvariable

#' 
#' We can see the "type" of the variables using the function `class`:
#' 
## ------------------------------------------------------------------------
class(firstvariable)
class(thirdvariable)
class(fourthvariable)

#' 
#' The names of the types of these variables are pretty intuitive but here's an explanation:
#' 
#' * `numeric` variables can take on numerical values
#' 
#' * `logical` variables can take on the values `TRUE` and `FALSE`
#' 
#' * `character` variables are characters
#' 
#' 
#' ## Operations with variables
#' 
#' We can add, subtract, multiply, divide, and exponentiate `numeric` variables:
#' 
## ------------------------------------------------------------------------
firstvariable+secondvariable
firstvariable-secondvariable
firstvariable*secondvariable
firstvariable^secondvariable # exponentiation

#' 
#' We can combine operations. For example, we can compute the average of `firstvariable` and `secondvariable` as
#' 
## ------------------------------------------------------------------------
(firstvariable+secondvariable)/2

#' 
#' `R` has a built-in `mean` function, which we'll see later.
#' 
#' We can't add, subtract, multiply, divide or exponentiate `character` variables (try it out: it'll give you an error), but we can add, subtract, multiply, divide or exponentiate `logical` variables. If the variable is `TRUE` it'll be treated as a `1`; if it's `FALSE`, it'll be treated as a `0`:
#' 
## ------------------------------------------------------------------------
logi1 = TRUE
logi2 = FALSE

#' 
## ------------------------------------------------------------------------
logi1+logi2 
logi1*logi2 
logi1/logi2 
logi1^logi2

#' 
#' We can combine `logical` and `numeric` variables in operations. Again, `TRUE` will be assigned `1`, and `FALSE` will be assigned `0`.
#' 
#' Finally, we can do operations without using variables at all:
#' 
## ------------------------------------------------------------------------
6/2*(2+1+TRUE)

#' 
#' ## Arithmetic functions
#' 
#' R has built-in functions such as `sqrt`, `exp`, `log`, ...
#' 
## ------------------------------------------------------------------------
sqrt(4)
exp(firstvariable)
log(10, base=2)

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
#' And we can create ranges of values with `:`
#' 
## ------------------------------------------------------------------------
1:10
10:6

#' 
#' ## Operations with vectors
#' 
#' We can add, multiply, divide, etc. all the components of a `numeric` vector by the same number:
#' 
## ------------------------------------------------------------------------
x1+5
x1*5
x1/5

#' 
#' We can add and subtract vectors of the same length:
#' 
## ------------------------------------------------------------------------
x2 = c(7, 8, 9, 10, 11, 12)
x1+x2
x1-x2

#' 
#' Similarly, we can do **componentwise** multiplication and division:
#' 
## ------------------------------------------------------------------------
x1*x2
x1/x2

#' 
#' If two vectors are of different lengths, we have to be careful! `R` won't give us a warning message:
#' 
## ------------------------------------------------------------------------
x1
x3 = c(2,3)
x1+x3
x1*x3 

#' 
#' We can compute the dot product of 2 `numeric` vectors of the same length:
#' 
## ------------------------------------------------------------------------
t(x1)%*%x2

#' 
#' We can compute means, standard deviations, variances, etc:
#' 
## ------------------------------------------------------------------------
mean(x1)
sd(x1)
var(x1)

#' 
#' ## `length` and concatenating 
#' 
#' We can find the length of a vector with `length`:
#' 
## ------------------------------------------------------------------------
length(x1)

#' 
#' And we can add values to an existing vector as follows:
#' 
## ------------------------------------------------------------------------
x1
c(x1,10) # add at the end
c(10, x1) # add at the beginning

#' 
#' We can concatenate vectors, too:
#' 
## ------------------------------------------------------------------------
c(x1, x2)

#' 
#' 
#' ## Indexing vectors
#' 
#' We can look at particular entries of a vector using brackets.
#' 
## ------------------------------------------------------------------------
x1
x1[1] # first entry
x1[4] # 4th entry
x1[length(x1)] # last entry

#' 
#' In `R`, indices start at `1` (in some other programming languages, indices start at `0`).
#' 
#' We can access subsets of vectors using vectors. For example, if we want to print the third and fifth entries of `x1`:
#' 
## ------------------------------------------------------------------------
x1[c(3,5)]

#' 
#' We can subset using ranges of values with `:`. For instance, if we want to select the second, third, fourth, and fifth entries of `x1`:
#' 
## ------------------------------------------------------------------------
x1[2:5]

#' 
#'  
#' # Matrices
#' 
#' We can create matrices as follows:
#' 
## ------------------------------------------------------------------------
A1 = matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE) # read by row 
A2 = matrix(c(1,3,2,4), nrow=2, ncol=2, byrow=FALSE) # read by column

#' 
#' Doing operations with matrices is straightforward:
#' 
## ------------------------------------------------------------------------
A1%*%A2 # matrix product
A1*A2 # componentwise product
A1+A2  # componentwise addition
log(A1) # taking the log of the components

#' 
#' Indexing matrices is similar to indexing vectors. For example, if we want to access the element in the first row and second column of `A1`:
#' 
## ------------------------------------------------------------------------
A1[1,2] # accessing entries: rows first, then columns

#' 
#' You can also index by full rows and columns. For example, if you want to select the first row of `A1`:
#' 
## ------------------------------------------------------------------------
A1[1,]

#' 
#' If you want to access the second column:
#' 
## ------------------------------------------------------------------------
A1[,2]

#' 
#' # Installing libraries
#' 
#' Statisticians use `R` because there are many libraries that contain useful functions. We can install libraries with `install.packages`. For example, if we want to install `ggplot2`, which is a useful library for plotting:
#' 
## ---- eval = FALSE-------------------------------------------------------
## install.packages('ggplot2')

#' 
#' Once the library is installed, we can load it using `library()`. If we want to load `ggplot2`, we need to type:
#' 
## ------------------------------------------------------------------------
library(ggplot2)

#' 
#' # Introduction to `data.frame`s
#' 
#' We'll use the dataset `mpg`, which is in the `ggplot2` library. First, we load it:
#' 
## ------------------------------------------------------------------------
data(mpg) 

#' 
#' The class of the dataset is `data.frame` (and others), which are matrices that have columns that can have different types.
#' 
#' The function `str` gives us some information about the variables in the dataset:
#' 
## ------------------------------------------------------------------------
str(mpg) 

#' 
#' We can print the first and last 5 observations in the dataset using `head` and `tail`:
#' 
## ------------------------------------------------------------------------
head(mpg)
tail(mpg)

#' 
#' We can index the rows and columns of `mpg` using the same syntax we used for indexing matrices:
#' 
## ------------------------------------------------------------------------
mpg[3:7,c(1,4:5)]

#' 
#' With `data.frame`s we can extract variables using `$`. For example, if we want to look at `year`:
#' 
## ------------------------------------------------------------------------
mpg$year

#' 
#' We can also index by logical conditions. For instance, if we want to work with the subset of Toyota cars:
#' 
## ------------------------------------------------------------------------
mpg[mpg$manufacturer == "toyota",]

#' 
#' # Factors
#' 
#' `factor` is a variable type in `R` useful for encoding categorical variables. Defining them is easy:
#' 
## ------------------------------------------------------------------------
fac1 = factor(c("dog","cat","cat","dog"))

#' 
#' We can use `summary` to create a quick table (note that `summary` didn't work well with `character` variables):
#' 
## ------------------------------------------------------------------------
summary(fac1)

#' 
#' The default ordering of the categories in a factor is alphabetical, which isn't always the best or most intutive. We can see the different categories (in `R` lingo, levels) of a factor and its ordering using `levels`:
#' 
## ------------------------------------------------------------------------
levels(fac1)

#' 
#' 
## ----echo = FALSE--------------------------------------------------------
hsb2  = read.csv("~/spring19/STA9750/hsb2.csv") # sub this path by the one that's appropriate in your computer

#' 
#' Let's use the `hsb2` dataset (on the course website) to illustrate this point. The dataset contains a variable called `ses`, which is socioeconomic status of the student. It can take on the values `low`, `middle`, and `high`. Unfortunately, the default ordering of the factor is alphabetical, that is:
#' 
## ------------------------------------------------------------------------
levels(hsb2$ses)

#' 
#' The problem with this ordering is that if we create tables, plots, etc. `R` will use this ordering, which is counterintuitive. For instance, if we create a 2 x 2 table of `ses` and `race`, we get
#' 
## ------------------------------------------------------------------------
table(hsb2$ses, hsb2$race)

#' 
#' This is not great. 
#' 
#' How can we reorder the levels of a factor? The answer is 
#' 
## ------------------------------------------------------------------------
hsb2$ses = factor(hsb2$ses, ordered = TRUE, levels = c("low", "middle", "high"))

#' 
#' The code above rewrites the `ses` variable in `hsb2` to an ordered factor whose levels are `low`, `middle`, and `high` (in that order). 
#' 
#' If you don't believe me (and you shouldn't), here's the code to verify that `ses` is now ordered:
#' 
## ------------------------------------------------------------------------
levels(hsb2$ses)
table(hsb2$ses, hsb2$race)

#' 
#' # Lists
#' 
#' We won't say much about `list`s, but they're useful if we want to keep objects of different types in a single place. 
#' 
#' For example, suppose that we have a `vector` and a `matrix`:
#' 
## ------------------------------------------------------------------------
v = 1:6
m = matrix(c(1,0,0,1),byrow=T,nrow=2)

#' 
#' Then, the following code creates a `list` whose entries are the vector `v` and the matrix `m`:
#' 
## ------------------------------------------------------------------------
l = list(v,m)

#' 
#' We can access, say, the second element of the list with
#' 
## ------------------------------------------------------------------------
l[[2]]

#' 
#' And we can do things such as 
#' 
## ------------------------------------------------------------------------
l[[2]][2,1]
l[[1]][4]

#' 
#' We can add a new element to the list indexing by a new element
#' 
## ------------------------------------------------------------------------
v2 = 3:4
l[[3]] = v2

#' 
#' We probably won't see `list`s again in the course, but it's good to know that they exist.
#' 
#' # Basic data summaries with `R`
#' 
#' We can get quick summaries of `numeric` variables with `summary`
#' 
## ------------------------------------------------------------------------
summary(mpg) 

#' 
#' We can tabulate with `table`
#' 
## ------------------------------------------------------------------------
table(mpg$manufacturer) 
table(mpg$manufacturer,mpg$year)
table(mpg$year)

#' 
#' We can plot stuff, too. For example, `hist` does histograms:
#' 
## ------------------------------------------------------------------------
hist(mpg$displ, main="Engine displacement (in litres)",
     col=rainbow(20),
     xlim=c(0,10))

#' 
#' You can learn more about how to change the attributes of the plot with `?hist`.
#' 
#' We can create individual boxplots and boxplots grouped by values of categorical variables:
#' 
## ------------------------------------------------------------------------
boxplot(mpg$displ)
boxplot(mpg$displ~mpg$manufacturer)

#' 
#' These plots are created using the `graphics` library. There are other libraries that you can use to produce plots. One of them is `ggplot2`, which we installed earlier. A nice thing about `ggplot2` is that it has the function `qplot`, which produces good-looking plots by default. For example:
#' 
## ------------------------------------------------------------------------
qplot(mpg$displ)
qplot(mpg$manufacturer)

#' 
#' `qplot` is smart enough to produce different plots depending on the type of the object. We'll cover `ggplot2` in more detail later in the semester.
#' 
#' # Sources
#' 
#' * [Datacamp: introduction to `R`](https://www.datacamp.com/courses/free-introduction-to-r)
#' 
