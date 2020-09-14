# Working with aggregate data
# ---------------
# Interfaith dating data
# description: http://users.stat.ufl.edu/~winner/data/interfaith.txt
# data: http://users.stat.ufl.edu/~winner/data/interfaith.dat


# Read it in, change column names, and convert variables to factors
# Then, change levels to something interpretable

# What percentage of catholics are of low socioeconomic status?

# 1. find a logical vector w conditon
cond = inter$religion == "catholic"
# 2. use it for indexing
cath = inter[cond,]
# equivalently, using dplyr
cath = inter %>% filter(religion == "catholic")

# 1. find logical vector
cond2 = cath$ses == "low"
cathlow = cath[cond2,]
# 2. use it for indexing
cathlow

# find %
100*sum(cathlow$count)/sum(cath$count)

# What percentage of protestants are of low socioeconomic status?

# 1. find a logical vector w conditon
cond = inter$religion == "protestant"
# 2. use it for indexing
prot = inter[cond,]

# 1. find logical vector
cond2 = prot$ses == "low"
protlow = prot[cond2,]
# 2. use it for indexing


# find %
100*sum(protlow$count)/sum(prot$count)

# What percentage of catholics are in an interfaith relationship? 
# 1. find a logical vector w conditon
cond = inter$religion == "catholic"
# 2. use it for indexing
cath = inter[cond,]
# equivalently, using dplyr
cath = inter %>% filter(religion == "catholic")

# 1. find logical vector
cond2 = cath$interfaith == "yes"
cathyes = cath[cond2,]
# 2. use it for indexing
cathyes

# find %
100*sum(cathyes$count)/sum(cath$count)

