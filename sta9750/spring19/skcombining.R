# datasets with nonalcoholic and alcoholic drinks
nonalcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","polar"), 
                      mixer=c("tonic","orange juice", "coke", "coke","seltzer"))
alcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","IPA","dark and stormy"), 
                   spirit=c("gin","sparkling wine", "rum", "red wine","beer","rum"))

# prices for drinks
nonalcoholic = nonalcoholic %>% mutate(price=c(8, 6, 7, 5, 5))
alcoholic = alcoholic  %>% mutate('$'=c(8, 6, 7, 5, 5, NA))

# how to merge the data?


# reorder the columns so that the spirit comes first:

# extra components for dark and stormy
ds = tibble(name='dark and stormy', 
            spirit='ginger beer', 
            price = 8)

# join dark & stormy with rest of the data


# combine price.x and price.y


# bar where prices 
# are sum of price of mixer + spirit

nonalcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","polar"), 
                      mixer=c("tonic","orange juice", "coke", "coke","seltzer"))  %>% 
  mutate(price=c(3, 2, 2, 2, 5))
alcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","IPA"), 
                   spirit=c("gin","sparkling wine", "rum", "red wine","beer")) %>% 
  mutate(price=c(5, 4, 5, 3, 5))

# join nonalcoholic and alcoholic


# find total price
