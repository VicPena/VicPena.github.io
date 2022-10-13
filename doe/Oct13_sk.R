library(tidyverse)
library(FrF2)
library(emmeans)

# From Easterling (2015)

# The eu was a batch of 100 pots processed in one run of the baking and
# cooling process. The response measured was the percent of cracked pots in
# a batch.

# Cooling rate (R): slow (-1) and fast (1)
# Temperature (T): 2000 (-1) and 2060°F (1)
# Clay coefficient of expansion (C): low (-1) and high (1)
# Conveyor belt carrier (D): metal (-1) and rubberized (1)

pot = read_table("http://vicpena.github.io/doe/pot.txt")


# Goal: investigate the effects of four factors on the filtration rate
# of a resin for a chemical process plant. 

# The factors are 
# A = temperature 
# B = pressure 
# C = mole ratio (concentration of chemical formaldehyde)
# D = stirring rate. 

# This experiment was performed in a pilot plant.

resin = read_csv("http://vicpena.github.io/doe/resin.csv")
