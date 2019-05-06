## Source: Datacamp course "Working with geospatial data with R"

library(ggmap)
corvallis2 = corvallis
colnames(corvallis2)[c(2,3)] = c("lat","lon")

minlong = min(corvallis2$lon)
maxlong = max(corvallis2$lon)
minlat = min(corvallis2$lat)
maxlat = max(corvallis2$lat)

bbox = c(left = minlat-0.1*(maxlat - minlat),
         right = maxlat+0.1*(maxlat- minlat),
         bottom = minlong-0.1*(maxlong-minlong),
         top = maxlong+0.1*(maxlong-minlong))

# Get map at zoom level 13
map = get_stamenmap(bbox, maptype = 'toner', zoom = 13)
# You can try out different map types, different zooms
# More info: ?get_stamenmap

ggmap(map, 
      base_layer = ggplot(aes(x=lat, y=lon), data = corvallis2)) + geom_point()

# Map color to year built
ggmap(map, 
      base_layer = ggplot(aes(x=lat, y=lon), data = corvallis2)) + 
  geom_point(aes(color=year_built))+
  xlab("latitude")+
  ylab("longitude")+
  ggtitle("Year houses were built in Corvallis, OR")

# Map size to bedrooms
ggmap(map, 
      base_layer = ggplot(aes(x=lat, y=lon), data = corvallis2)) + 
  geom_point(aes(color=bedrooms))

# try out bedrooms as discrete scale
corvallis2$bedrooms = as.factor(corvallis2$bedrooms)
ggmap(map, 
      base_layer = ggplot(aes(x=lat, y=lon), data = corvallis2)) + 
  geom_point(aes(color=bedrooms))

# Map color to price 
ggmap(map, 
      base_layer = ggplot(aes(x=lat, y=lon), data = corvallis2)) + 
  geom_point(aes(color=price))

# What is max price?
library(dplyr)
corvallis2 %>% filter(price == max(price))

# Plot price after taking out outlier


# facets by type of building (class)
ggmap(map,
      base_layer = ggplot(aes(x = lat, y = lon), data = corvallis2)) + 
      geom_point()+facet_wrap(~class)

# bedrooms by class
ggmap(map,
      base_layer = ggplot(aes(x = lat, y = lon), data = corvallis2)) + 
  geom_point(aes(color=bedrooms))+facet_wrap(~class)

# year built by class
ggmap(map,
      base_layer = ggplot(aes(x = lat, y = lon), data = corvallis2)) + 
  geom_point(aes(color=year_built))+facet_wrap(~class)



##
## polygons, lines, etc.
##

ward_sales2 = ward_sales
colnames(ward_sales2)[c(3,4)] = c("lat","lon")

# Add a point layer with color mapped to ward
ward_sales2$ward = as.factor(ward_sales2$ward)

ggplot(ward_sales2, aes(x = lat, y = lon)) + 
  geom_point(aes(color=ward))

# Add a point layer with color mapped to group
ward_sales2$group = as.factor(ward_sales2$group)
ggplot(ward_sales2, aes(x = lat, y = lon)) + geom_point(aes(color=group))

# Add a path layer with group mapped to group
ggplot(ward_sales2, aes(x = lat, y = lon)) + geom_path(aes(group=group))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales2, aes(x = lat, y = lon))) +
  geom_polygon(aes(group = group, fill=group))

# extent = "normal" and maprange, zoom out
ggmap(map, 
      base_layer = ggplot(ward_sales2, aes(x = lat, y = lon)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = ward))

# Repeat, but map fill to num_sales
ggmap(map, 
      base_layer = ggplot(ward_sales2, aes(x = lat, y = lon)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = num_sales))

# Repeat again, but map fill to avg_price
ggmap(map, 
      base_layer = ggplot(ward_sales2, aes(x = lat, y = lon)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = avg_price), alpha = 0.8)

