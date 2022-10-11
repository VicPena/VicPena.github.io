######################
# Drosophila example #
######################

# Response: wing length
# Factors:
# - Sex: M or F
# - Area: A or B
# - Species: Melanogaster and Simulans  


library(tidyverse)

# read data
mosques = read.csv2("http://vicpena.github.io/doe/lab3/Mosques.csv") 

# converting factors 
mosques$Especie = factor(mosques$Especie) 
mosques$Area = factor(mosques$Area)
mosques$Genero = factor(mosques$Genero)

# plotting the data
ggplot(mosques) +
  aes(x = Area, y = Longitud, color = Especie) +
      geom_jitter(size = 5, width = 0.1) +
      facet_wrap(~ Genero)

# fit full model
mod_inter = aov(Longitud ~ Especie*Area*Genero, data = mosques)
summary(mod_inter)
# many non-significant terms

# how to choose a model?
# - backward selection: start with full model,
#  drop variables until model doesn't improve
# - forward selection: start with nothing,
# add variables one by one until model doesn't improve

# we have interactions, so the algorithm gets 
# messy; when we include interactions, we include main effects
# as well

# backward selection

# forward selection


# final model
mod_final = aov(Longitud ~  Genero, data = mosques)
summary(mod_final)
emmip(mod_final, ~ Genero)


##################
# Spring example #
##################

# Response: number of compressions
# until a spring breaks

# Factors: 
# - Length: 10 or 15cm
# - Girth: 5 or 7mm
# - Steel: Type A or B

# design with 8 runs and 3 factors 
# r = 1... 

# When r = 1, can't do F-tests
# if we want to include all interaction terms

# However, when we work with
# complete designs with 2 levels,
# there are strategies that 
# allow us to work around the issue

# read in data
molla = read.csv("http://vicpena.github.io/doe/molla.csv")

# create design matrix with FrF2
library(FrF2)
design = FrF2(nruns = 8,  nfactors = 3, 
              factor.names = c("Longitud", "Gruix", "Tipus"),
              randomize = FALSE)

# there is a standard way of constructing design matrices in 
# full factorial designs

# add in response variable
design = add.response(design, molla$Comp)

# fit model
mod = aov(molla.Comp ~ Longitud*Gruix*Tipus, data = design)
summary(mod)
# since r = 1, can't do any testing


# if none of the effects are significant,
# they come from a Normal(0, sigma2/N) random variable
# -> do a qqplot
DanielPlot(design)

# fit model with terms identified with Daniel plot
mod2 = aov(molla.Comp ~ Longitud + Gruix*Tipus, data = design)
summary(mod2)
library(emmeans)

# take a look at fitted values by 
# combinations of longitud, gruix and tipus
emmip(mod2, Longitud ~ Gruix | Tipus)


###################
# Tubos de escape #
###################

#	En un proceso de fabricación de tubos de escape
# para la industria del automóvil se desea
# optimizar un proceso de soldadura que se 
# realiza en un componente de acero inoxidable.
# Para ello se lleva a cabo un diseño factorial 2^3, considerando los factores:

# A: Caudal de Gas (l/min.):	8  o 12
# B: Intensidad (Amp): 230  o 240
# C: Velocidad cadena (m/min.):	0.6  o 1

# Respuesta: calidad de soldadura

design = FrF2(nruns = 8,  nfactors = 3, 
              factor.names = c("caudal", "intensidad", "velocidad"),
              randomize = FALSE)

calidad = c(10.5, 26, 13.5, 19, 12, 25.5, 16, 21.5)

design = add.response(design, calidad)
mod = aov(calidad ~ caudal*intensidad*velocidad, data = design)
DanielPlot(mod)
mod = aov(calidad ~ caudal+caudal*intensidad, data = design)
emmip(mod, caudal ~ intensidad)
