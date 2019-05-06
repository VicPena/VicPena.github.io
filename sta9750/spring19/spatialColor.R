## 
## Color scales in ggplot2 & ggmap
##

## Data source: Datacamp course "Working with geospatial data with R"

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

# Plot the map
ggmap(map)

# Plot the points, without map
ggplot(aes(x=lon, y=lat), data = corvallis) + geom_point()

# Plot map + points
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) 

# Add color-coding by price
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=price))
# Not great: a few points outliers (big $) are messing up the scales


# Maybe taking log(price) helps?
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=log(price)))
# Not great: now the outliers are small values...

##
# Alternative: plot in a discrete scale instead
##

# Use cut & quantile function

# quantile
x = 0:100
quantile(x) # cut into quartiles
# you can specify any probabilities that you want
quants = quantile(x, probs=c(0, 0.2, 0.4, 0.6, 0.8, 1))

# cut with specified breaks
cut(x, breaks = quants)

# include lowest value:
cut(x, breaks = quants, include.lowest = TRUE)


# Now, apply this to corvallis data
quants = quantile(corvallis$price, probs = seq(0, 1, 0.2))

corvallis$prices = cut(corvallis$price,
                        breaks=quants,
                        include.lowest = TRUE)

# Plot with prices
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))

# Improve plot

# 1. Better color scale

# R Color Brewer has a variety of scales
# Sequential, qualitative, and divergent
library(RColorBrewer)
display.brewer.all()

# Pick Greens palette, scale_color_brewer
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens")


# 2. Better breaks and legend

# look at current breaks
quants

# we can round to better-looking values...
breaks2 = c(1, 175000, 250000, 300000, 350000, max(corvallis$price))

# re-do cutting
corvallis$prices = cut(corvallis$price,
                        breaks=breaks2,
                        include.lowest = TRUE)

ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens")
# The numbers are a little hard to read...

# If the scale were continuous, the command is
# scale_color_distiller
# For example
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=price))+
  scale_color_distiller(palette = "Purples")

# Different options to improve legend
# 1. Change the scale to prices in $1k dollars
corvallis$price1k = corvallis$price/1e3 
breaks2 = c(1, 175000, 250000, 300000, 350000, max(corvallis$price))/1e3

# re-do cutting
corvallis$prices = cut(corvallis$price1k,
                        breaks=breaks2,
                        include.lowest = TRUE)

# plot map
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens", name = "Price (in $1k)")
# 1.91e+04 is annoying... can we change it?

# change levels of factor
levels(corvallis$prices)
levels(corvallis$prices)[5] = "(350, 19100]"

# plot again
finalmap = ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens", name = "Price (in $1k)")+
  xlab("latitude")+
  ylab("longitude")

finalmap

# 2. Force R to display scale with all the 0s 

# You'd change levels(corvallis$prices) to the numbers you want



# Facets by type of building (class)
table(corvallis$class)
finalmap+facet_wrap(~class)
# empty values of class
corvallis %>% filter(class == "")
# missing values of class
corvallis %>% filter(is.na(class))

# new dataset without missing or empty class
corvclass = corvallis %>% filter(!is.na(class), class!="")


ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvclass)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens", name = "Price (in $1k)")+
  xlab("latitude")+
  ylab("longitude")+
  facet_wrap(~class)
# good, but not great...
# Mobile Homes are cheap and in a very light shade of green

# Go to https://htmlcolorcodes.com/color-picker/
# Pick a color and go to shades
manscales = c("#3aff99", "#33df86", "#2bbf73", "#249f60", "#1d804d")

ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvclass)) + 
  geom_point(aes(color=prices))+
  scale_color_manual(values=manscales)+  
  xlab("latitude")+
  ylab("longitude")+
  facet_wrap(~class)
# better! (it could be improved, though)

##
## Crime data
## 

data("crime") # it's in ggmap
str(crime)


# plot types of offense
qplot(crime$offense)+theme_bw()

# get map
minlong = min(crime$lon, na.rm = T)
maxlong = max(crime$lon, na.rm = T)
minlat = min(crime$lat, na.rm = T)
maxlat = max(crime$lat, na.rm = T)

bbox = c(left = minlong,
         right = maxlong,
         bottom =minlat,
         top = maxlat)

map = get_stamenmap(bbox, maptype = 'toner', zoom = 7)
ggmap(map) 
str(crime)

# map is very big!
quantile(crime$lon, probs=c(0.01,0.99), na.rm = T)
quantile(crime$lat, probs=c(0.01,0.99), na.rm = T)

# create new map

minlong = -95.75
maxlong = -95
minlat = 29.4
maxlat = 30.25


bbox = c(left = minlong,
         right = maxlong,
         bottom =minlat,
         top = maxlat)


map2 = get_stamenmap(bbox, maptype = 'toner', zoom = 11)

# exclude observations outside of new map that have missing data
crime2 = crime %>% filter(lon > minlong, lon < maxlong, lat > minlat, lat < maxlat) %>%
         na.omit()

# take a sample of rows to create plots faster
nsamp = 5e3
crime2  = crime2[sample(1:nrow(crime2), nsamp),]

# plot crime on map
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
      geom_point(alpha=0.25, color='red')

# create a surface plot with bins
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_bin2d(alpha=0.8)

# can change number of bins
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_bin2d(alpha=0.8, bins = 50)

# contours
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_density_2d()

# filled contours by levels
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
   stat_density_2d(aes(fill = ..level..), geom = "polygon")


# facets by type of offense
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_point(alpha=0.6, color='red')+
  facet_wrap(~offense)

# by hour
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_point(aes(color=hour))

# divide hour into
# Morning [6-12), 
# afternoon [12, 5),
# evening [5, 8), 
# night [8, 23), 
# late night [0, 6)
crime2 
crime2$hours  = cut(crime2$hour,
                       breaks=c(0, 6, 12, 17, 20, 23),
                       include.lowest = TRUE,
                       right = FALSE)

# distribution of crimes by hours
qplot(crime2$hours)

# use new variable to create plot
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_point(aes(color=hours))
# bad plot!

# how about using hours as wrapping?
ggmap(map2, 
      base_layer = ggplot(aes(x=lon, y=lat), data = crime2))+
  geom_point(color='red', alpha=0.6)+
  facet_wrap(~hours)
# there doesn't seem to be strong dependence...
             
