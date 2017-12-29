install.packages("tidyr")
library(tidyr)

crime.data <- read.csv("../data/tema1/USArrests.csv", 
                       stringsAsFactors = FALSE)
