# adapted from: https://www.youtube.com/watch?v=pGAUHhLYp5Q

################
# read in data #
################
data = read.csv("http://vicpena.github.io/amd/mds.csv", row.names = 1)
head(data)

###############################
# MDS with Euclidean distance #
###############################

# find distance matrix
d_euc = dist(data)
# run cmdscale, put eig = TRUE to get 
# variance explained 
mds_euc = cmdscale(d_euc, k = 2, eig = TRUE)
# find proportion of variance explained
pve = mds_euc$eig/sum(mds_euc$eig)
pve[1:2]
# plot projections onto MDS axes
# first, create a data.frame with $points
df = data.frame(mds_euc$points)
# change column names
colnames(df) = c("var1", "var2")
ggplot(df) +
  aes(x = var1, y = var2) +
      geom_text(label = rownames(df))

# MDS with log-fold change 

lf_dist  = function(data) {
  # not efficient! but gets the job done
  dist = matrix(0, nrow(data), nrow(data))
  for (i in 1:nrow(data)) {
    for (j in 1:nrow(data)) {
      aux = abs(log2(data[i,]/data[j,]))
      dist[i, j] = mean(as.numeric(aux))
    }
  }
  as.dist(dist)
}

# find distance matrix
d_lf = lf_dist(data)
# run cmdscale, put eig = TRUE to get 
# variance explained 
mds_lf = cmdscale(d_lf, k = 2, eig = TRUE)
# find proportion of variance explained
pve_lf = mds_lf$eig/sum(mds_lf$eig)
pve_lf[1:2]

# compare results
# plot projections onto MDS axes
# first, create a data.frame with $points
df_lf = data.frame(mds_lf$points)
# change column names
colnames(df_lf) = c("var1", "var2")
ggplot(df_lf) +
  aes(x = var1, y = var2) +
  geom_text(label = rownames(df))




