##############
## Matrices ##
##############

# matrices have rows and columns

#--------#
# Basics #
#--------#

# defining a matrix
# default is byrow = FALSE

#------------#
# Operations #
#------------#

# number-matrix operations: +, -, *, /
A1*5

# componentwise +, -, *, /

# matrix product %*%

#----------#
# Indexing #
#----------#

A1 = matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE) # read by row 
A2 = matrix(c(1,3,2,4), nrow=2, ncol=2, byrow=FALSE) # read by column

# first row, second column of A1

# first row of A1

# second column of A2




#------------------#
# Useful functions #
#------------------#

# Exercise:
# A class has 3 students: Annie, Bobbie, and Carol
# The class has 2 HW assignments and a final project
# Their grades are as follows:

# Annie's grades: HW1 = 8, HW2 = 7, Project = 9
# Bobbie's grades: HW1 = 6, HW2 = 10, Project = 9
# Carol's grades: HW1 = 9, HW2 = 10, Project = 7

# Define a matrix whose rows are Annie's, Bobbie's, and Carol's grades

# rownames and colnames

# colSums, rowSums, sum, rowMeans, colMeans

# find average grade in HW1, HW2, project

# find average grades for Annie, Bobbie, and Carol 

# HW1 is worth 20% of the grade
# HW2 is worth 20% of the grade
# Project is worth 60% of the grade
# find final numeric grades for Annie, Bobbie, and Carol

