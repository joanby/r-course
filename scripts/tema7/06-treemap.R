#Tree Maps
install.packages("treemap")
library(treemap)

branch <- c(rep("branch-1",4), rep("branch-2",2), rep("branch-3",3))
subbranch <- paste("subbranch",c(1,2,3,4,1,2,1,2,3), sep = "-")
values = c(15,4,22,13,11,8,6,1,25)
data <- data.frame(branch, subbranch, values)

treemap(data, index = c("branch", "subbranch"),
        vSize = "values", type = "index")


posts <- read.csv("../data/tema7/post-data.csv")
head(posts)

treemap(posts, 
        index = c("category", "comments"),
        vSize = "views", type = "index")
