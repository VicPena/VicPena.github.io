#############################################
# Mediation analysis with the PROCESS macro #
#############################################

# Playlist with useful videos:
# https://www.youtube.com/watch?v=BfxeBcqIekc&list=PLqdBkA4Dl3KroP6IumUALGao_DFcN8pq1


med_data = read_csv("~/Dropbox/teaching/workshop/2022/mediation.csv")

####################################
# Simple mediation model (model 4) #
####################################
head(med_data)

# y = happiness
# x = grades
# m = self.esteem


model.m = lm(M ~ X, data = myData)
model.y = lm(Y ~ M + X, data = myData)
out = mediate(model.m, model.y, 
              treat = "X", mediator = "M",
              sims = 100, boot = TRUE)

############################
# Parallel mediation model #
############################
# more than one mediator which are unrelated to each other
# y = "happiness",
# x = "grades",
# m = c("self.esteem", "confidence"),


# add in control variable age
# cov = "age" 
# potentially more could be added


# Serial mediation model (model 6)
# http://offbeat.group.shef.ac.uk/FIO/images/model6statdiagram.gif

########################
# Moderation (model 1) #
########################
# w (moderator) = "male"

#################################
# Moderated mediation (model 8) #
#################################






