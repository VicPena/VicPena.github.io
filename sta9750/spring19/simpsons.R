# table of dr vs outcome
tab = table(operation$doctor, operation$outcome)
tab 

# table with proportions of failures and successes by doctor
prop.table(tab, margin = 1)

# if you want to run a test to compare proportions:
prop.test(tab)
# the proportions you see are proportions of failures...

# tabulate failure / success by difficulty of operation?
# different ways of doing this! 

# fastest way
table(operation$doctor, operation$outcome, operation$difficulty)
# however, this doesn't give us proportions

# another way
easy = operation[operation$difficulty=="easy",]
hard = operation[operation$difficulty=="hard",]

tabeasy = table(easy$doctor, easy$outcome)
tabhard = table(hard$doctor, hard$outcome)

prop.table(tabeasy, margin = 1)
prop.table(tabhard, margin = 1)

# Dr. H. seems better at hard and easy operations 

# How can this be?
# - Dr. Hibbert mainly does hard operations
# - Dr. Nick mainly does easy ones

# Is the proportion tests we did *wrong*?
# - Not really... It is probably true that, at the end 
#  of their careers, Dr N. will probably have had more successful
#  operations than Dr H... But that's not necessarily interesting to us
