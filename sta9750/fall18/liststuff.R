## Exercise 3, HW1 in R 
# read-in school data
school = read.csv("C:/Users/vpena/Downloads/school.csv")
school$difference = school$after-school$before
str(school)
summary(school$difference)
sd(school$difference)
hist(school$difference)

# 95% CI for the mean
t.test(school$difference)
?t.test

str(school)

## Lists

v = 1:6
m = matrix(c(1,0,0,1),byrow=T,nrow=2)
# this creates a list whose entries are a vector and a matrix
l = list(v,m)
# you can index them like this
l[[2]][2,1]
l[[1]][4]

# you can add a new element to the list indexing by a new element
v2 = 3:4
l[[3]] = v2


## How to create and subset a dataframe

a = 1:3
b = c("a","b","c")
# data.frames are "matrices" with columns that can
# have mixed types (numeric, factor, date, etc.)
df = data.frame(a,b)
# we can access the columns by their name
df$a
df$b
# or by their column index
df[,1]
df[,2]
# can look at rows like this
df[1,]
df[2,]
# and you can subset using logical conditions, like this:
df[df$a>1,]

