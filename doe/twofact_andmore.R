########################
# Batteries Montgomery #
########################

battery = read.csv("https://vicpena.github.io/doe/battery.csv")
battery$type = factor(battery$type)
battery$temp = factor(battery$temp)

# plot the data
ggplot(battery) +
  aes(x = temp, y = life, fill = type) +
  geom_boxplot() +
  theme_minimal()

# fit the model with sum-to-zero constraints
options(contrasts = c("contr.sum", "contr.poly"))
mod = aov(life ~ type*temp, data = battery)

# check model assumptions
par(mfrow = c(1,2))
plot(mod, which = 1:2)

# find coefficients
dummy.coef(mod)

# find ANOVA table
summary(mod)

# interaction plot
library(emmeans)
# emmip(mod, color ~ x-axis | facet)
emmip(mod, type ~ temp)

#############
# Bike data #
############# 

# A lab experiment was performed to 
# compare mountain bike tires of 
# two different brands, 1 and 2. To this end,
# the tires were put on a simulation machine
# allowing for three different
# undergrounds (soft, rocky and extreme).
# Each combination of brand and underground
# was performed three times (using a new tire each time). The response
# was the driven kilometers until tread depth
# was reduced by a pre-defined amount. 


# We want to know if there are differences between
# brands and terrains; we also want to know if the
# effect of the terrain depends on the brand


book.url = "https://stat.ethz.ch/~meier/teaching/book-anova"
bike = readRDS(url(file.path(book.url, "data/bike.rds")))

ggplot(bike) +
  aes(x = underground, y = dist, color = brand) +
  geom_point()

mod = aov(dist ~ brand*underground, data = bike)
summary(mod)
emmip(mod, brand ~ underground)
TukeyHSD(mod)

        
        
##########################
# Three factor model     #
# Blood pressure example #
##########################

df = read.csv("http://vicpena.github.io/doe/threeway.csv")

# one-way: drug vs bp
ggplot(df) +
  aes(x = drug, y = bp) +
  geom_point() 

# two-way: drug vs bp by feed
ggplot(df) +
  aes(x = drug, y = bp) +
  geom_point() +
  facet_grid(~ feed)

# two-way: drug vs bp by diet
ggplot(df) +
  aes(x = drug, y = bp) +
  geom_point() +
  facet_grid(~ diet)

# three-way relationship
ggplot(df) +
  aes(x = drug, y = bp) +
  geom_point() +
  facet_grid(feed ~ diet)

# aov: fit model, check assumptions, do anova table
mod = aov(bp ~ drug*feed*diet, data = df)
summary(mod)
plot(mod)
# TukeyHSD(mod)

# interaction plot with emmip
library(emmeans)
emmip(mod,  ~ drug | diet +  feed)
?emmip

