cond = matrix(c("A", "critical", "survived",
                "A", "critical", "died",
                "A", "noncritical", "survived",
                "A", "noncritical", "died",
                "B", "critical", "survived",
                "B", "critical", "died",
                "B", "noncritical", "survived",
                "B", "noncritical", "died"), ncol = 3, byrow = T)
colnames(cond) = c("Hospital", "Status", "Outcome")
df = as.data.frame(cond)
df$Total = c(17, 101, 100, 3, 2, 36, 175, 8)

install.packages("tidyverse")
library(tidyverse)
# uncount: conversió de dades
df2 = df %>% uncount(Total)

# taula amb l'hospital
# i el resultat del procediment
prop.table(table(df2$Hospital, df2$Outcome), 1)

# taula amb hospital, resultat
# gravetat del cas
prop.table(table(df2$Hospital, df2$Outcome, df2$Status), c(1, 3))

prop.table(table(df2$Hospital, df2$Status), 1)


# Exercici 2

# a) extreure una mostra de mida
# 10000 de l'Exp(1) i fer-ne 
# un histograma
mostra = rexp(10000, 1)
hist(mostra)

# b) Simularem 1000 mostres
# de mida 100 d'Exp(1)
# Per a cada mostra
# calcularem la mitjana mostral
# Per tant, tindrem 1000 mitjanes
# i podrem graficar un histograma
# de les mitjanes, que seran
# approximadament normals

mat = matrix(rexp(1000*100, 1), 
              nrow = 1000,
              ncol = 100)

hist(rowMeans(mat))

# Exercici 3 
install.packages("openintro")
library(openintro)
data(hsb2)

# comparar les mitjanes 
# de mates entre estudiants
# que van a escola pública
# i els que van a la privada

# a) Intèrval de confiança 
# per la diferència de mitjanes
# pública - privada
# Alt Gr + 4: ~
t.test(hsb2$math ~ hsb2$schtyp, 
       var.equal = TRUE,
       conf.level = 0.90)

# Per defecte, t.test assumeix que 
# les variàncies dels grups són diferents
# però el model ANOVA que vam veure 
# dimarts assumeix igualtat de variàncies
# Si volem veure l'equivalència, hem de posar
# var.equal = TRUE al t.test per forçar igualtat
# de variàncies

# b) Prova d'hipòtesi amb la t-student
# per comparar mitjana pública vs
# mitjana privada
# Sol: mirar l'output del t.test a la part a)

# c) Prova d'hipòtesi amb la F 
# (vam veure dimarts)
# per comparar mitjana pública vs
# mitjana privada: és el mateix que b)
mod = aov(math ~ schtyp, data = hsb2)
summary(mod)
# p-valors amb aov i t.test
# (assumint var.equal = TRUE) són els mateixos
# i t^2 és igual a F
(-1.3901)^2
