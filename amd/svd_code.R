A = matrix(c(1, 2, 2,
             2, 3, 3,
             3, 5, 5), byrow = TRUE, nrow = 3)

B = matrix(c(1, 0, 1,
             2, 1, 4,
             1, 0, 1), byrow = TRUE, nrow = 3)

C = matrix(c(1, 2, 3,
             2 ,3, 5,
             9, 1, 0), byrow = TRUE, nrow = 3)

# find frobenius distance between A and B, type = "F"

# find the SVD of C

# find the best rank 1 approx for C

# find best rank 2 approx for C

# find the error of rank 1 approx 

# find the error of rank 2 approx 

# check that the fact in slide works

############################
# SVD for image processing #
############################

library(imager)
logo = load.image("http://vicpena.github.io/amd/upc.jpeg")
plot(logo)

# convert to grayscale

# convert to matrix

# find rank

# find svd 

# find error in approximation vs rank

# plot rank k approximation: as.cimg(Xk)




# do the same with this other pic
library(imager)
logo = load.image("http://vicpena.github.io/amd/fib.jpeg")
plot(logo)





