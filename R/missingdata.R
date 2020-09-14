
##################
## Missing data ##
##################

# missing data are marked with NA
x = c(1:5, NA)
x

# applying functions to vectors with missing data is tricky


# arithmetic with NAs is NA


# is.na can be used to filter NAs


# complete.cases and na.omit are useful
data("airquality")

# load in airquality
?airquality
summary(airquality)

# run is.na on a data.frame

# complete.cases: TRUE if there is no missingness at all

# select complete cases
# can also create a subset with incomplete cases


# na.omit: keep complete cases only
