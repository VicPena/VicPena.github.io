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


bbox = c(minlong, maxlong, minlat, maxlat)
names(bbox) = c("left", "right", "bottom", "top")

map2 = get_stamenmap(bbox, maptype = 'toner', zoom = 11)
ggmap(map2)
# exclude observations outside of new map that have missing data
crime2 = crime %>% filter(lon > minlong, 
                          lon < maxlong, 
                          lat > minlat, 
                          lat < maxlat) %>%
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

##
## Field goal data
##

colnames(fg) = c("yards", "success", "week")
library(GGally)
fg$success = as.factor(fg$success)
ggpairs(fg)
# easier to make the fg if you're closer
qplot(success, yards, data = fg, geom = 'boxplot')
# there might be a "week" effect.. not very clear
qplot(success, week, data = fg, geom = 'boxplot')

mod = glm(success ~ week + yards, data = fg, family="binomial")

# confusion matrix
preds = ifelse(predict(mod, type = 'response') >= 0.5, 1, 0)
tab = table(preds, fg$success)

# good predictions
sum(diag(tab))/nrow(fg)
# bad predictions
1-sum(diag(tab))/nrow(fg)

round(prop.table(tab),3)


# df betas
dfbeta(mod)

# predict on a grid of week and yards
weekseq = min(fg$week):max(fg$week)
yardseq = min(fg$yards):max(fg$yards)
pred = expand.grid(weekseq, yardseq)
colnames(pred) = c("week", "yards")
pred$preds = predict(mod, newdata = pred, type = 'response')
ggplot(pred) + 
  aes(x=week, y=yards, color=preds) +
  geom_point(size=8) +
  scale_color_gradient(low="red", high="green")+
  theme(text=element_text(size=15))

# roc 
# sensitivity: true positive rate
# specificity: true negative rate
prob = predict(mod, type="response")
fg$prob = prob
library(pROC)
g = roc(success ~ prob, data = fg)
plot(g)  
g
