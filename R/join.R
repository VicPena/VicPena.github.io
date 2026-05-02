##
## Joining / merging data
##
# Examples from: https://dplyr.tidyverse.org/reference/join.html

library(tidyverse)
band_members
band_instruments


# mutating joins
# --------------

# inner_join: merge and keep rows that appear in both datasets
band_members %>% inner_join(band_instruments, by = "name")

# left_join: merge and keep rows in "left" dataset 
band_members %>% left_join(band_instruments, by = "name")

# right_join: merge and keep rows in "right" dataset
band_members %>% right_join(band_instruments, by = "name")

# full_join: merge and keep all rows!
band_members %>% full_join(band_instruments, by = "name")


# filtering joins
# ---------------

# semi_join: keep rows in band_members 
#            that have a match in band_instruments
band_members %>% semi_join(band_instruments, by = "name")

band_members
band_instruments

# anti_join: keep rows in band_members 
#            that DON'T have a match in band_instruments
band_members %>% anti_join(band_instruments, by = "name")



# what if join variables have different names?
band_members
band_instruments2

# indicate it in by statement
band_members %>% inner_join(band_instruments2, by = c("name" = "artist"))

# Duplicate rows
# --------------

x = data.frame(key = c(1, 2, 2, 1), 
               val_x = c("x1", "x2", "x3", "x4"))

y = data.frame(key = c(1, 2), 
               val_y = c("y1", "y2"))

x
y

# what happens if we left_join?
x %>% left_join(y, by = "key")

x
y
y %>% left_join(x, by = "key")

# another example
x = data.frame(key = c(1, 2, 2, 3),
               val_x = c("x1", "x2", "x3", "x4"))

y = data.frame(key = c(1, 3, 2, 2),
               val_y = c("y1", "y2", "y3", "y4"))

x
y

x %>% left_join(y, by = "key")
