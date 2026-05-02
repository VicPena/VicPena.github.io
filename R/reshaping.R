####################################
# gather: from wide to long format #
####################################

library(tidyverse)

set.seed(110289)
n = 5
wide = round(tibble(Treat1=rnorm(n), Treat2=rnorm(n,1,1), Treat3=rnorm(n)),3)

# gather(key = "name of factor", value = "name of outcome", <columns to gather>)
wide %>% gather(key = "treat", value = "outcome", Treat1, Treat2, Treat3)


# From long to wide? Use spread() function (but be careful: see notes)


####################################
# Creating and modifying variables #
####################################

# read in hsb2
hsb2  = read.csv("http://vicpena.github.io/sta9750/spring19/hsb2.csv") 
str(hsb2)

# Exercise:
# ---------
# create a new variable with the avg score in the 5 tests


# old R
avg = (hsb2$read+hsb2$write+hsb2$math+hsb2$science+hsb2$socst)/5
hsb2$average = avg
head(hsb2)

# tidyverse: mutate
hsb2 %>% mutate(average2 = (read+write+math+science+socst)/5 ) %>% select(-average)

# Exercise:
# --------
# create a new subset of the data with only 2 variables:
# 1. average score in exams
# 2. new variable that takes on the values "white" and "nonwhite"

# old R: create white / nonwhite variable

# ifelse
hsb2$white = ifelse(hsb2$race == "white", "yes", "no" )
head(hsb2)

hsb3 = hsb2 %>% select(average, white)
hsb3

# Exercise:
# ---------
# we can use mutate_at for type conversions
femrole = read.table("http://users.stat.ufl.edu/~winner/data/femrole.dat", header=F)

# convert V1, V2, V3, V4 to factors
femrole2 = femrole %>% mutate_at(c("V1","V2","V3","V4"), factor)
str(femrole2)

# mutate_if: same idea, more advanced (see notes)
