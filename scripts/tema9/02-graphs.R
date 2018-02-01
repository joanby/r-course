#Representación de grafos
install.packages("Matrix")
load("../data/tema9/meetup-hiking.Rdata")
unique(users$user_id)
unique(users$group_id)


library(Matrix)
group_membership = sparseMatrix(users$group_id, users$user_id, x=T)
head(group_membership)
adjacency <- t(group_membership) %*% group_membership

head(summary(adjacency))

users_edgelist <- as.data.frame(summary(adjacency))
summary(users_edgelist)

users_edgelist.upper <- users_edgelist[users_edgelist$i<
                                         users_edgelist$j,]
save(users_edgelist.upper, file = "../data/tema9/meetup-hiking-edgelist.Rdata")
