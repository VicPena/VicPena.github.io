## Source: Datacamp course "Working with geospatial data with R"

library(ggmap)

minlong = min(corvallis$lon)
maxlong = max(corvallis$lon)
minlat = min(corvallis$lat)
maxlat = max(corvallis$lat)

bbox = c(left = minlong-0.1*(maxlong-minlong),
         right = maxlong+0.1*(maxlong-minlong),
         bottom =minlat-0.1*(maxlat-minlat),
         top = maxlat+0.1*(maxlat-minlat))

# Get map at zoom level 13
map = get_stamenmap(bbox, maptype = 'toner', zoom = 13)
# You can try out different map types, different zooms
# More info: ?get_stamenmap

ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + geom_point()

# Map color to year built
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=year_built))+
  xlab("latitude")+
  ylab("longitude")+
  ggtitle("Year houses were built in Corvallis, OR")

# Map size to bedrooms
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=bedrooms))

# try out bedrooms as discrete scale
corvallis$bedrooms = as.factor(corvallis$bedrooms)
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=bedrooms))

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
      base_layer = ggplot(aes(x = lon, y = lat), data = corvallis)) + 
      geom_point()+facet_wrap(~class)

# bedrooms by class
ggmap(map,
      base_layer = ggplot(aes(x = lon, y = lat), data = corvallis)) + 
  geom_point(aes(color=bedrooms))+facet_wrap(~class)

# year built by class
ggmap(map,
      base_layer = ggplot(aes(x = lon, y = lat), data = corvallis)) + 
  geom_point(aes(color=year_built))+facet_wrap(~class)



##
## polygons, lines, etc.
##

# Add a point layer with color mapped to ward
ward_sales$ward = as.factor(ward_sales$ward)

ggplot(ward_sales, aes(x = lon, y = lat)) + 
  geom_point(aes(color=ward))

# Add a point layer with color mapped to group
ward_sales$group = as.factor(ward_sales$group)
ggplot(ward_sales, aes(x = lon, y = lat)) + geom_point(aes(color=group))

# Add a path layer with group mapped to group
ggplot(ward_sales, aes(x = lon, y = lat)) + geom_path(aes(group=group))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(x = lon, y = lat))) +
  geom_polygon(aes(group = group, fill=group))

# extent = "normal" and maprange, zoom out
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(x = lon, y = lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = ward))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(x = lon, y = lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = num_sales))

# Repeat again, but map fill to avg_price
ggmap(map, 
      base_layer = ggplot(ward_sales, aes(x = lon, y = lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = avg_price), alpha = 0.8)

