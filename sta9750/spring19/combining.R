# datasets with nonalcoholic and alcoholic drinks
nonalcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","polar"), 
                      mixer=c("tonic","orange juice", "coke", "coke","seltzer"))
alcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","IPA","dark and stormy"), 
                   spirit=c("gin","sparkling wine", "rum", "red wine","beer","rum"))

# prices for drinks
nonalcoholic = nonalcoholic %>% mutate(price=c(8, 6, 7, 5, 5))
alcoholic = alcoholic  %>% mutate('$'=c(8, 6, 7, 5, 5, NA))

# how to merge the data?
# rename the '$' to price
alcoholic = alcoholic %>% rename(price='$')

# then, we can join
join = full_join(nonalcoholic, alcoholic, by=c('name','price'))
join


# reorder the columns so that the spirit comes first:
join = join %>% select(name, spirit, mixer, price)
join

# extra components for dark and stormy
ds = tibble(name='dark and stormy', 
            spirit='ginger beer', 
            price = 8)

# join ds with rest of the data
full_join(join, ds, by='name')

# doesn't look great...

# combine price.x and price.y
full_join(join, ds, by='name') %>%  
mutate(price=coalesce(price.x,price.y)) %>% select(-price.x, -price.y)

# even nicer:
ds = ds %>% mutate(spirit=paste(" ", spirit,sep=""))
final = full_join(join, ds, by='name') %>%  
  mutate(price=coalesce(price.x,price.y)) %>%
  select(-price.x, -price.y)  %>%
  replace(is.na(.),"") %>%
  unite(spirit, spirit.x, spirit.y, sep="")

# bar where prices 
# are sum of price of mixer + spirit

nonalcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","polar"), 
                      mixer=c("tonic","orange juice", "coke", "coke","seltzer"))  %>% 
  mutate(price=c(3, 2, 2, 2, 5))
alcoholic = tibble(name=c("g&t","mimosa","rum and coke","calimocho","IPA"), 
                   spirit=c("gin","sparkling wine", "rum", "red wine","beer")) %>% 
  mutate(price=c(5, 4, 5, 3, 5))

# join
full_join(nonalcoholic, alcoholic, by='name')

# try the obvious thing
# add price.x and price.y
full_join(nonalcoholic, alcoholic, by='name') %>% 
   mutate(total=price.x+price.y)
# doesn't work!

# replace NAs by zeros and add!
full_join(nonalcoholic, alcoholic, by='name') %>% 
  mutate(price.x=coalesce(price.x,0), price.y=coalesce(price.y,0), total=price.x+price.y) %>% 
  select(name, spirit, mixer, total)

