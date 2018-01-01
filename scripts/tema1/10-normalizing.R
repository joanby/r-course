housing <- read.csv("../data/tema1/BostonHousing.csv")

housing.z <- scale(housing, center = TRUE, scale = TRUE)
housing.mean <- scale(housing, center = TRUE, scale = FALSE)
housing.sd <- scale(housing, center = FALSE, scale = TRUE)
housing.none <- scale(housing, center = FALSE, scale = FALSE)

#sd = sqrt(sum(x^2)/(n-1))

scale.many = function(dataframe, cols){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], "z", sep = ".")
    dataframe[name] <- scale(dataframe[,col])
  }
  cat(paste("Hemos normalizado ", length(cols), " variable(s)"))
  dataframe
}

housing <- scale.many(housing, c(1, 3, 5:8))
