library(tidyverse)
library(FrF2)

# From Easterling (2015)

# The eu was a batch of 100 pots processed in one run of the baking and
# cooling process. The response measured was the percent of cracked pots in
# a batch.

# Cooling rate (R): slow (-1) and fast (1)
# Temperature (T): 2000 (-1) and 2060°F (1)
# Clay coefficient of expansion (C): low (-1) and high (1)
# Conveyor belt carrier (D): metal (-1) and rubberized (1)

pot = read_table("http://vicpena.github.io/doe/pot.txt")

design = FrF2(nruns = 16, 
              nfactors = 4,
              factor.names = c("R", "T", "C", "D"),
              randomize = FALSE)
design = add.response(design, pot$Cracked)

DanielPlot(design)
mod = aov(pot.Cracked ~ C + R + D + C*R, data = design)
summary(mod)
par(mfrow = c(1,2))
plot(mod, 1:2)

library(emmeans)
emmip(mod, C ~ R | D)
# R = -1
# C = - 1
# D = 1

# Goal: investigate the effects of four factors on the filtration rate
# of a resin for a chemical process plant. 

# The factors are 
# A = temperature 
# B = pressure 
# C = mole ratio (concentration of chemical formaldehyde)
# D = stirring rate. 

# This experiment was performed in a pilot plant.

resin = read_csv("http://vicpena.github.io/doe/resin.csv")
design = FrF2(nruns = 16, nfactors = 4, 
              randomize = FALSE)


design = add.response(design, resin$Rate)
DanielPlot(design)
# A, A:D, D, C
design
mod = aov(resin.Rate ~ A + D + C + A*D, data = design)
summary(mod)
emmip(mod, A ~ D | C)
# refit without C
mod2 = aov(resin.Rate ~ A + D + A*D, data = design)
emmip(mod2, A ~ D)


# Volants without W
des = FrF2(nruns = 16, nfactors = 3, randomize = FALSE)
y = c(35, 62, 28, 55, 49, 48, 34, 45,
      18, 47, 31, 56, 26, 31, 39, 44)
des = add.response(des, y)

DanielPlot(des)
mod = aov(y ~ A + A*C, data = des)
summary(mod)
emmip(mod, A ~ C)


# add in W
des2 = FrF2(nruns = 16, nfactors = 4, randomize = FALSE)
y = c(35, 62, 28, 55, 49, 48, 34, 45,
      18, 47, 31, 56, 26, 31, 39, 44)

des2 = add.response(des2, y)
DanielPlot(des2)
mod = aov(y ~ A + B*D + D + A*C, des2)
summary(mod)
