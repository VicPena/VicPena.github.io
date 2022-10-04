########################
# Batteries Montgomery #
########################

battery = read.csv("https://vicpena.github.io/doe/battery.csv")
battery$type = factor(battery$type)
battery$temp = factor(battery$temp)

# plot the data


# fit the model with sum-to-zero constraints
options(contrasts = c("contr.sum", "contr.poly"))


# check model assumptions

# find coefficients

# find ANOVA table

# interaction plot
library(emmeans)
# emmip(mod, color ~ x-axis | facet)


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

# plot data

# fit model, check assumptions, ANOVA table

# interaction plot


##########################
# Three factor model     #
# Blood pressure example #
##########################

df = read.csv("http://vicpena.github.io/doe/threeway.csv")

# one-way: drug vs bp


# two-way: drug vs bp by feed


# two-way: drug vs bp by diet


# three-way relationship


# aov: fit model, check assumptions, do anova table


# interaction plot with emmip

