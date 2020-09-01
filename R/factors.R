
## ------- ##
## Factors ##
## ------- ##

# another way of working with categorical data

# defining factors
chr1 = c("dog", "cat", "cat", "dog")
fac1 = factor(c("dog","cat","cat","dog"))

# summary


# In the iris dataset, how many species of type setosa are there?

# levels: categories contained in factor

# read in hsb2 data
hsb2 = read.csv("http://vicpena.github.io/sta9750/spring19/hsb2.csv")
str(hsb2)
# str, summary, head

# levels of ses
levels(hsb2$ses)

# if you produce summaries, the order will be counterintuitive
# e.g. tabulate ses by race

# reorder levels
hsb2$ses = factor(hsb2$ses, levels=c("low","middle","high"))
levels(hsb2$ses)


