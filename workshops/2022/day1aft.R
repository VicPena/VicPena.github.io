############
# Overview #
############
# - Getting data into R
# - Basic summaries: intro, grouping, aggregate data 
# - Exercises
# - Plots

####################
# More data.frames #
####################

# subset rows with slice

# subset columns with filter

# can also subset by exclusion



# creating data.frames from scratch:
df = data.frame(var1 = c(1, 2, 3), 
                dog = c("A","B","C"))
df

# can rename rows and columns of data.frame with rownames & colnames
colnames(df) = c("var1", "var2")
rownames(df) = c("Ann","Bob","Carl")
df

# adding new variables to a data.frame
# using mutate
# e.g. add c("X","Y", NA)
# (the marker for missing data in R is NA Not Available)









#######################
# Getting data into R #
#######################

# We can use the Import Dataset menu in Rstudio

# We can use code as well... It's pretty painful, though
# If you're interested in learning that, check out the 
# Datacamp course
# https://app.datacamp.com/learn/courses/introduction-to-importing-data-in-r


# Read in:
# http://users.stat.ufl.edu/~winner/data/nba_ht_wt.csv

# Read in interfaith dating data
# description: http://users.stat.ufl.edu/~winner/data/interfaith.txt
# data: http://users.stat.ufl.edu/~winner/data/interfaith.dat


# change column names 
colnames(interfaith) = c("ses", "religion", "gender", "interfaith", "count")
interfaith
# convert variables to factors

# change levels to something interpretable



## ----------------------------- ##
## Basic data summaries with `R` ##
## ----------------------------- ##

# - count and summarize
# - group_by
# - introduction to ggplot

# load mpg
?mpg
data(mpg)
str(mpg)

# glimpse

# summary

#####################
# Tables with count #
#####################

# table of make

# create a column with percentages

# table of make and year

# export tables with write.csv


# exercise: with the NBA data, create a table of Pos
# and save it into a csv
data(iris)


#####################################
# summary statistics with summarize #
#####################################

# median of cty, std deviation of hwy, minimum of displ

############
# group_by #
############
# summary statistics by groups

# means and std deviation of cty by class

# Exercise: 
# find means and std deviations of hwy by manufacturer


# we can use group_by with count as well

# for example, what if we want to find the percentage
# of toyotas that are SUVs?

# Exercise:
# find the percentage of Toyotas that are 4wd (Hint: use drv variable)

###############################
# Working with aggregate data #
###############################

# the interfaith dating data 
# are "grouped" or in aggregate format

# find table of interfaith status


# find percentage of interfaith dating for 
# Catholics and Protestants separately

#############
# Exercises #
#############

data("absenteeism")
?absenteeism

# find average days of absence and std dev by
# ethnicity status

# do the same but for all combinatiosn of ethnicity
# stsatus and sex

# find percentages of lrn (learner status)
# by ethnicity

######################################
# Plots (more to come on Wednesday!) #
######################################

# ggplot(data) +
# aes(x = , y = , color = , ...) +
# geom_histogram(), geom_boxplot(), geom_point()... +
# other options

# histogram displ

# can play around with scales, titles, etc

# boxplot displ

# boxplot displ by make

# qplot of hwy against cty 

