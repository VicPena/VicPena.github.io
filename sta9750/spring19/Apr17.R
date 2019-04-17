library(openintro)
library(dplyr)
data(hsb2)

## dplyr and tidyr cheat sheet:
# http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

## select

# select math, race, gender
sub1 = hsb2 %>% select(math, race, gender)

# exclude math, race, gender
sub2 = hsb2 %>% select(-math, -race, -gender)

## filter

# score > 70 in math AND public school
hsb2 %>% filter(math > 70, schtyp == 'public')

# score > 70 in math OR public school
hsb2 %>% filter(math > 70 | schtyp == 'public')

## mutate 

# find average score: read, write, science and socst
hsb2 =  hsb2 %>% mutate(avg=(read+write+science+socst)/4)

## arrange

# sort data by average score in ascending order
hsb2 %>% arrange(avg)

# sort data by average score in descending order
hsb2 %>% arrange(desc(avg))

## group_by and summarizing

# find median and std deviation in math score by
# socioeconomic status
hsb2 %>% group_by(ses) %>% 
  summarize(medMath = median(math), sdMath = sd(math))

# find table with socioeconomic status of students
# with math score > 70
hsb2 %>% filter(math > 70) %>% group_by(ses) %>% summarize(count=n())


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
data %>% 
  gather(key=treatment, value=outcome, Treat1, Treat2, Treat3)

# convert data from wide to long
# uneven number of observations by treatment
uneven = data
uneven[4:5,3] = NA 
uneven[5,1] = NA
uneven

long = uneven %>% 
  gather(key = treatment, value = outcome, Treat1:Treat3) %>% 
  na.omit

## spread: long to wide

# unfortunately, the obvious thing to do doesn't work
long %>% spread(key = treatment, value = outcome)

# add row numbers
long = long %>% group_by(treatment) %>% mutate(id=row_number())

# then, we can spread
long %>% spread(key = treatment, value = outcome)

## unite
drinks = tibble(spirit = c("gin","sparkling wine", "rum","red wine"),
                mixer = c("tonic", "OJ", "coke", "coke"))

# unite spirit & mixer
united = drinks %>% unite(name, spirit, mixer, sep = ' & ')
  
## separate
united %>% separate(name,  into = c("spirit", "mixer"),
                    sep = ' & ')


