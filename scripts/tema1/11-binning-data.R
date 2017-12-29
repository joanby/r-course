students <- read.csv("../data/tema1/data-conversion.csv")

bp <- c(-Inf, 10000, 31000, Inf)
names <- c("Low", "Average", "High")

students$Income.cat <- cut(students$Income, breaks = bp, labels = names)
students$Income.cat2 <- cut(students$Income, breaks = bp)
students$Income.cat3 <- cut(students$Income, 
                            breaks = 4, 
                            labels = c("Level 1", "Level 2", 
                                       "Level 3", "Level 4")
                            )


#dummy variables
students <- read.csv("../data/tema1/data-conversion.csv")
install.packages("dummies")
library(dummies)

students.dummy <- dummy.data.frame(students, sep = ".")
names(students.dummy)

dummy(students$State, sep=".")

dummy.data.frame(students, names = c("State", "Gender"), sep = ".")
