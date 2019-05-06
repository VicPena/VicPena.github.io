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

# Plot the points, without map

# Plot map + points

# Add color-coding by price


##
# Alternative: plot in a discrete scale instead
##

# Use cut & quantile function

x = 0:100

# find quartiles


# you can specify any probabilities that you want
probs=c(0, 0.2, 0.4, 0.6, 0.8, 1)

# cut with specified breaks
cut(x, breaks = quants)


# Now, apply this to corvallis data


# Plot with prices


# Improve color scale

# R Color Brewer has a variety of scales
# Sequential, qualitative, and divergent
library(RColorBrewer)
display.brewer.all()

# Pick Greens palette, scale_color_brewer


# Better breaks and legend

# look at current breaks

# we can round to better-looking values...

# re-do cutting


# plot again


# If the scale were continuous, the command is
# scale_color_distiller
# For example
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=price))+
  scale_color_distiller(palette = "Purples")

# Different options to improve legend
# 1. Change the scale to prices in $1k dollars

# re-do cutting

# plot map


# 2. Force R to display scale with all the 0s 




# Facets by type of building (class)

# first summary of types of building
table(corvallis$class)

# try out facet_wrap
finalmap+facet_wrap(~class)

# new dataset without missing or empty class

# plot again

##
# Manual scales
##

# Go to https://htmlcolorcodes.com/color-picker/
# Pick a color and go to shades

# e.g.
manscales = c("#3aff99", "#33df86", "#2bbf73", "#249f60", "#1d804d")

# plot again

##
## Crime data
## 

data("crime") # it's in ggmap
str(crime)


# plot types of offense

# get map

# plot map

# map is very big!
quantile(crime$lon, probs=c(0.01,0.99), na.rm = T)
quantile(crime$lat, probs=c(0.01,0.99), na.rm = T)

# create new map


# exclude observations outside of new map that have missing data

# take a sample of rows to create plots faster
nsamp = 5e3
crime2  = crime2[sample(1:nrow(crime2), nsamp),]

# plot crime on map


# create a surface plot with bins (geom_bin2d)

# can change number of bins


# contours (geom_density_2d)

# filled contours by levels (stat_density_2d)
# stat_density_2d(aes(fill = ..level..), geom = "polygon")


# facets by type of offense


# by hour


# divide hour into
# Morning [6-12), 
# afternoon [12, 5),
# evening [5, 8), 
# night [8, 23), 
# late night [0, 6)


# distribution of crimes by hours

# use new variable to create plot


# how about using hours as facet?

