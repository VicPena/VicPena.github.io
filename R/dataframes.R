##########################
## Intro to data.frames ##
##########################

# work with iris dataset
?iris
data(iris)



# str

# summary

# head

# tail

# we can index the same way we indexed matrices

# subset the first 20 rows

# exclude the third column

# subset rows 1 through 10 and exclude first two columns


# we can extract variables using $ followed by the name of the variable
# e.g. create a new variable that extracts "Species" out of iris


# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), var2 = c("A","B","C"))
df

# can rename rows and columns of data.frame with rownames & colnames


# adding new variables to a data.frame
# e.g. add var3 below to df
var3 = c("X","Y","Z")

