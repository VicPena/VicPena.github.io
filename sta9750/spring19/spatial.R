library(ggmap)
minlong = min(corvallis$lon)
maxlong = max(corvallis$lon)
minlat = min(corvallis$lat)
maxlat = max(corvallis$lat)

bbox = c(left = minlong-0.1*(maxlong - minlong),
         right = maxlong+0.1*(maxlong- minlong),
         bottom = minlat-0.1*(maxlat-minlat),
         top = maxlat+0.1*(maxlat-minlat))

# Get map at zoom level 5: map_5
map = get_stamenmap(bbox, zoom = 13)
# different map types, different zooms
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + geom_point()

# Map color to year built
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=year_built))+
  xlab("longitude")+
  ylab("latitude")+
  ggtitle("Year houses were built in corvallis, OR")

# Map size to bedrooms
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=as.factor(bedrooms)))

# Map color to price 
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=price))

# What is max price?
library(dplyr)
corvallis %>% filter(price == max(price))

# Plot price after taking out outlier


# facets by type of building (class)
ggmap(map,
      base_layer = ggplot(aes(lon, lat), data = corvallis)) + 
      geom_point()+facet_wrap(~class)

# bedrooms by class
ggmap(map,
      base_layer = ggplot(aes(lon, lat), data = corvallis)) + 
  geom_point(aes(color=bedrooms))+facet_wrap(~class)

# year built by class
ggmap(map,
      base_layer = ggplot(aes(lon, lat), data = corvallis)) + 
  geom_point(aes(color=year_built))+facet_wrap(~class)



##
## polygons, lines, etc.
##

# Add a point layer with color mapped to ward
ggplot(ward_sales, aes(lon, lat)) + 
  geom_point(aes(color=as.factor(ward)))

# Add a point layer with color mapped to group
ggplot(ward_sales, aes(lon, lat)) + geom_point(aes(color=as.factor(group)))

# Add a path layer with group mapped to group
ggplot(ward_sales, aes(lon, lat)) + geom_path(aes(group=group))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(lon, lat))) +
  geom_polygon(aes(group = group, fill=group))

# extent = "normal" and maprange, zoom out
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = ward))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = num_sales))

# Repeat again, but map fill to avg_price
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = avg_price), alpha = 0.8)

# 
corvlm = corvallis[complete.cases(corvallis),]
corvlm = corvlm %>% filter(class == 'Dwelling')
mod1 = lm(log(price) ~ year_built+total_squarefeet+condition+bedrooms+full_baths , data = corvlm)
modstep = step(mod1)
summary(modstep)
plot(modstep)

