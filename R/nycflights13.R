# NYC flights data
# https://r4ds.had.co.nz/relational-data.html
library(nycflights13)
library(tidyverse)

str(airlines)
str(airports)
str(planes)
str(weather)
str(flights)


# add weather information to flights data
df = flights %>% left_join(weather)

# add plane information to flights data
df2 = flights %>% left_join(planes, by = "tailnum")
str(planes)
df3 = flights %>% left_join(planes)

# add destination airport name info to flights
str(flights)
str(airports)
df4 = flights %>% left_join(airports, by = c("dest" = "faa"))

# compute average arrival delay by destination
# sort in descending order by average delay 
str(flights)
flights %>% group_by(dest) %>% 
  summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
  arrange(desc(avgDelay)) %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  select(name, avgDelay)

# -------

####################
# TopHat exercises #
####################

# What is the average arrival delay of flights that departed from EWR, JFK, and LGA?
flights %>% group_by(origin) %>% 
  summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
  arrange(desc(avgDelay)) %>%
  left_join(airports, by = c("origin" = "faa")) %>%
  select(name, avgDelay)

# What airline had the highest average arrival delay time in 2013?
str(flights)
flights %>% group_by(carrier) %>%
  summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
  arrange(desc(avgDelay)) %>%
  left_join(airlines) %>%
  select(carrier, name, avgDelay)
