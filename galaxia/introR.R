# correu: victor.pena.pizarro@upc.edu

##########################
# Instal-lar R i Rstudio #
##########################

# Ordre importa:
# 1. R: https://cran.r-project.org/
# 2. Rstudio: https://posit.co/download/rstudio-desktop

##################
# Tutorials de R #
##################

# R for Data Science (Eng): https://r4ds.hadley.nz/
# R para ciencia de datos (Esp): https://davidrsch.github.io/r4ds-es/
# Cookbook for R (Eng): http://www.cookbook-r.com/
# Curs de R (Eng): https://vicpena.github.io/R/videos
# Molts més...


########################
# Instal-lar tidyverse #
########################
# conté funcions útils per a
# - manipular dades
# - fer gràfics
install.packages("tidyverse")
# carregar paquet tidyverse
library(tidyverse)

###########################
# Instal-lar nycflights13 #
###########################
# conté les dades que analitzarem
install.packages("nycflights13")
# carregar paquet
library(nycflights13)
# carregar les dades que analitzarem
data(weather)
# fitxer d'ajuda
?weather
# dades meteorològiques horàries del 2013
# de 3 aeroports propers a la ciutat de Nova York
# - La Guardia (LGA), John F. Kennedy (JFK), Newark (EWR)

# estructura de les dades amb str
str(weather)
# estadístics bàsics amb summary
summary(weather)
# desviació típica i variància temperatura
weather |> summarize(sdTemp = sd(temp, na.rm = TRUE), 
                     varTemp = var(temp, na.rm = TRUE))

#########################
# taules de freqüències #
#########################

# taula de freq. origen
weather |> count(origin)
# taula de freq. per mes
weather |> count(month)
# taula de freq. per hora
weather |> count(hour) |> print(n = Inf)
# taula de freq. per mes i origen
weather |> count(month, origin) |> print(n = Inf)
# EXERCICI: taula de freq. d'hores per origen

########################
# estadístics per grup #
########################

# mitjana i desv. tipica temperatura
# per origen
weather |> group_by(origin) |> 
  summarize(avgTemp = mean(temp, na.rm = TRUE), 
            sdTemp = sd(temp, na.rm = TRUE))

# EXERCICI: mitjana i 
#           desv. típica temperatura per mes


# mitjana i desv. tipica de temperatura i precipitacio
# agrupada per mes i origen
# guardar resultat en "monthly_weather"
monthly_weather = weather |> group_by(month, origin) |> 
  summarize(avgTemp = mean(temp, na.rm = TRUE), 
            sdTemp = sd(temp, na.rm = TRUE),
            avgPrec = mean(precip),
            sdPrec = sd(precip)) |> print(n = Inf)


#################
# filtrar dades #
#################

# dades només de La Guardia
lga = weather |> filter(origin == "LGA")
# comprovació
lga |> count(origin)

# dades de JFK a partir de les 13h
jfk_aft = weather |> filter(origin == "JFK", hour >= 13)
# comprovació
jfk_aft |> count(origin, hour)

# dades de EWR amb mesures de temperatura 
# superior a 25 graus Celsius
# dues opcions:
# 1. convertir els 25 Celsius a 77 Fahrenheit 
# 2. crear nova variable amb temperatura en Celsius
#    Temp C = (Temp F - 32)*(5/9)

# creem nova temperatura en Celsius
weather = weather |> mutate(tempC = (temp-32)*(5/9))
str(weather)
ewr_warm = weather |> filter(origin == "EWR",
                             tempC > 25)
# comprovació
ewr_warm |> group_by(origin) |> summarize(min(tempC))

# EXERCICI: trobeu un subconjunt amb les 
#           dades d'agost a JFK i calculeu
#           temperatura mitjana, màxima i mínima en Celsius


###########
# gràfics #
###########

# ggplot: dins de library(tidyverse)
# tots els gràfics tenen la mateixa estructura

# histograma de temperatures
ggplot(weather) +
  aes(x = tempC) +
  geom_histogram()
# boxplot de temperatures
ggplot(weather) +
  aes(x = tempC) +
  geom_boxplot()
# histograma temperatura estratificat per origen
ggplot(weather) +
  aes(x = tempC) +
  geom_histogram() +
  facet_grid(origin ~ .)
# diagrama bivariant de temperatura contra humitat
ggplot(weather) +
  aes(x = tempC, y = humid) +
  geom_point() 
# diagrama bivariant de temperatura contra humitat
# estratificat per origen
ggplot(weather) +
  aes(x = tempC, y = humid) +
  geom_point() +
  facet_grid(origin ~ .)
# grafic sèrie temporal de temperatura
# estratificat per origen
ggplot(weather) +
  aes(x = time_hour, y = tempC, color = origin) +
  geom_line() +
  facet_grid(origin ~ .)

# EXERCICI gràfic serie temporal humitat
# estratificat per origen


# gràfic de mitjana de temperatura per mes i origen
temp_month = weather |> group_by(month, origin) |> 
  summarize(avgTemp = mean(temp, na.rm = TRUE), 
            sdTemp = sd(temp, na.rm = TRUE),
            avgPrec = mean(precip),
            sdPrec = sd(precip)) |> print(n = Inf)
ggplot(temp_month) +
  aes(x = month, y = avgTemp) +
  geom_line() +
  geom_point() +
  facet_grid(origin ~ .)
# gràfic desv tipica de temperatura per mes i origen
ggplot(temp_month) +
  aes(x = month, y = sdTemp) +
  geom_line() +
  geom_point() +
  facet_grid(origin ~ .)
