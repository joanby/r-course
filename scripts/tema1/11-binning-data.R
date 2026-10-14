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
# El paquete dummies se retiró de CRAN y no funciona con R 4.3 o posterior: fastDummies hace lo mismo
# (las columnas nuevas se llaman State_NJ en vez de State.NJ y van al final)
install.packages("fastDummies")
library(fastDummies)

students.dummy <- dummy_cols(students, remove_selected_columns = TRUE) # en el vídeo: dummy.data.frame(students, sep = ".")
names(students.dummy)

dummy_cols(students["State"], remove_selected_columns = TRUE) # en el vídeo: dummy(students$State, sep=".")

dummy_cols(students, select_columns = c("State", "Gender"), remove_selected_columns = TRUE) # en el vídeo: dummy.data.frame(students, names = c("State", "Gender"), sep = ".")
