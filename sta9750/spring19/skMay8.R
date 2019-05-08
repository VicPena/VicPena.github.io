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

# Change the scale to prices in $1k dollars
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

# Changing labels in plot without changing variable
ggmap(map, 
      base_layer = ggplot(aes(x=lon, y=lat), data = corvallis)) + 
  geom_point(aes(color=prices))+
  scale_color_brewer(palette = "Greens", 
                     name = "Price (in $1k)",
                     labels = c("[0.001, 175]",
                                "(175, 250]",
                                "(250, 300]",
                                "(300, 350]",
                                "(350,19100]"))


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
lonq = quantile(crime$lon, probs=c(0.01,0.99), na.rm = T)
latq = quantile(crime$lat, probs=c(0.01,0.99), na.rm = T)

# create new map

minlong = lonq[1]
maxlong = lonq[2]
minlat = latq[1]
maxlat = latq[2]



# exclude observations outside of new map that have missing data


# take a sample of rows to create plots faster
nsamp = 5e3
crime2  = crime2[sample(1:nrow(crime2), nsamp),]

# plot crime on map

# create a surface plot with bins with geom_bin2d

# can change number of bins

# contours with geom_density_2d


# filled contours by levels
# with stat_density_2d(aes(fill = ..level..), geom = "polygon")


# facets by type of offense


# by hour

# divide hour into
# Morning [6-12), 
# afternoon [12, 5),
# evening [5, 8), 
# night [8, 23), 
# late night [0, 6)


# distribution of crimes by new variable

# use new variable to create plot with color-coding


##
## Field goal data
##

# change column names to yards, success, and week


# look at the data, see what's going on

# fit logistic regression model

# confusion matrix

# good predictions

# bad predictions

# prop.table

# df betas: influential observations


# predict on a grid of week and yards

# plot results nicely


# roc 
# sensitivity: true positive rate
# specificity: true negative rate
prob = predict(mod, type="response")
fg$prob = prob
library(pROC)
g = roc(success ~ prob, data = fg)
plot(g)  
g
