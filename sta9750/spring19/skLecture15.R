
#' # Introduction to `data.frame`s
#' 
#' We'll use the dataset `mpg`, which is in the `ggplot2` library. First, we load it:
#' 
## ------------------------------------------------------------------------
data(mpg) 

#' 
#' 
#' The function `str` gives us some information about the variables in the dataset:
#' 
## ------------------------------------------------------------------------


#' 
#' With `data.frame`s we can extract variables using `$`. For example, if we want to look at `year`:
#' 


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

#' 
#' We can use `summary` to create a quick table (note that `summary` didn't work well with `character` variables):
#' 
## ------------------------------------------------------------------------


#' 
#' The default ordering of the categories in a factor is alphabetical:
#' 
## ------------------------------------------------------------------------
 
#' How can we reorder the levels of a factor? The answer is 
#' 
## ------------------------------------------------------------------------




#' 
#' # Lists

#' For example, suppose that we have a `vector` and a `matrix`:
#' 
## ------------------------------------------------------------------------
v = 1:6
m = matrix(c(1,0,0,1),byrow=T,nrow=2)

#' 
#' Then, the following code creates a `list` whose entries are the vector `v` and the matrix `m`:
#' 
## ------------------------------------------------------------------------

#' 
#' We can access, say, the second element of the list with
#' 
## ------------------------------------------------------------------------

#' 
#' And we can do things such as 
#' 
## ------------------------------------------------------------------------

#' 
#' We can add a new element to the list indexing by a new element
#' 
## ------------------------------------------------------------------------





#' ---

#' # One normal mean
#' 
#' A group of scientists recorded some measurements that are stored in the vector `x`:
#' 
## ------------------------------------------------------------------------
x = c(1,4,2,3,6,9,1,3,9,3)

#' 
#' We can find the mean and standard deviation of `x` as follows:
#' 
## ------------------------------------------------------------------------

#' 
#' The function `summary` provides quantiles, minimum, maximum, etc.
#' 
## ------------------------------------------------------------------------

#' 
#' We can visualize `x` with a histogram or a boxplot, for example. 
#' 
#' The plots below are created using the functions `hist` and `boxplot`, which are in `library(graphics)`:
#' 
## ------------------------------------------------------------------------

#' 
#' We can do $t$-tests and find normal confidence intervals for
#'  the population mean $\mu$ with the function `t.test`. 
#' 
#' For example, if we want to find a 99\% confidence interval for the mean:
#' 
## ------------------------------------------------------------------------

#' 
#' We can change `conf.level` to any confidence level that we want. 
#' If we don't specify anything, the default is 95\% confidence. 
#' We can also change the alternative to 'less' or 'greater'
-------------------------

#' 
#' As always, you can get more information about the function if you type in `?t.test`. 
#' 
#' # Two independent normal means
#' 

  
pharma = read.csv("~/Downloads/pharma.csv")

#' 
#' The data has 2 columns: `group` and `outcome`:
#' 
## ------------------------------------------------------------------------
summary(pharma)

#' 
#' If we want to get summaries by group (means, standard deviations, etc.),
#'  there are different ways to do it. Here's one:
#' 
## ------------------------------------------------------------------------

#' 
#' We'll see other ways of creating summaries by different `levels` of a `factor` later in the semester. 
#' 
#' If we want to plot the outcomes by group, we can create a boxplot:
#' 
## ------------------------------------------------------------------------

#' 
#' We could've also used the command `boxplot(pharma$outcome ~ pharma$group)`,
#'  but I think the command above is cleaner. 
#' 
#' 
#' If we want to create histograms of outcomes by groups, here's an option:
#' 
## ------------------------------------------------------------------------


#' 
#' Some comments on the code:
#' 
#' * `par(mfrow=c(2,1))` tells `R` that we want a plot that has 2 rows and 1 column 
#' 
#' * `xlab` changes the label on the `x`-axis of the plot
#' 
#' The pharmaceutical is interested in knowing whether the population means of 
#' the health outcomes are different at the 0.01 significance level.
#' 
#' We can do a two-sample $t$-test with `t.test`:
#' 
## ------------------------------------------------------------------------
t.test(outcome ~ group, conf.level = 0.99, data = pharma)

#' 
#' # $\chi^2$-tests of independence for categorical variables
#' 
---------------------------
library(openintro)
data(hsb2)

#' 
#' If you want more information about the dataset, you can find it by typing `?hsb2`. 
#' 
#' If we want to get a quick look at the variables in the dataset, we can use `str`:
#' 
## ------------------------------------------------------------------------
str(hsb2)

#' 
#' Suppose that a team of social scientists want to test
#'  whether the distribution of `ses` depends on `race`. First, we can create a table:
#' 
## ------------------------------------------------------------------------

#' 
#' It's hard to see whether `race` depends on `ses` by looking at the raw counts.
#'  We can create columns with row and column percentages with `prop.table`. 
## ------------------------------------------------------------------------

#' 
#' If we want row percentages (i.e. the sum of each row of the table is equal to 1):
#' 
## ------------------------------------------------------------------------

#' 
#' If we want column percentages (i.e. the sum of each column of the table is equal to 1):
#' 
## ------------------------------------------------------------------------

#' 
#' Finally, if we want overall percentages instead (i.e. the sum of all the entries in the table is equal to 1):
#' 
## ------------------------------------------------------------------------


#' 
#' We can create barplots with the `tables` and `prop.tables`:
#' 

#' 
#

#' 
#' # Pairwise comparisons of normal means: Tukey HSD
#' 
#' Let's work again with `hsb2` in `library(openintro)`. 
#' 
#' Suppose that we want to compare the average scores in `math` among the levels of `race` doing pairwise tests
#' 
#' 
#' 
# we can change the confidence level of the corrected intervals with the argument `conf.level`. 
#' 
## ------------------------------------------------------------------------

