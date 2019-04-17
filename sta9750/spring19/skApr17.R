library(openintro)
library(dplyr)
data(hsb2)

## dplyr and tidyr cheat sheet:
# http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

## select

# select math, race, gender

# exclude math, race, gender

## filter

# score > 70 in math AND public school

# score > 70 in math OR public school

## mutate 

# find average score: read, write, science and socst

## arrange

# sort data by average score in ascending order

# sort data by average score in descending order

## group_by and summarizing

# find median and std deviation in math score by
# socioeconomic status

# find table with socioeconomic status of students
# with math score > 70

## gather

library(dplyr)
library(tidyr)
set.seed(110289)
n = 5
data = round(tibble(Treat1=rnorm(n), Treat2=rnorm(n,1,1), Treat3=rnorm(n)),3)
data

# convert data from wide to long format
# key: factor that indicates treatment
# value: numerical outcome

# convert data from wide to long
# uneven number of observations by treatment
uneven = data
uneven[4:5,3] = NA 
uneven[5,1] = NA
uneven



## spread: long to wide

# unfortunately, the obvious thing to do doesn't work

# add row numbers
long = long %>% group_by(treatment) %>% mutate(id=row_number())

# then, we can spread

## unite
drinks = tibble(spirit = c("gin","sparkling wine", "rum","red wine"),
                mixer = c("tonic", "OJ", "coke", "coke"))

# unite spirit & mixer

## separate
                   


