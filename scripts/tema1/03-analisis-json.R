install.packages("jsonlite")
library(jsonlite)


dat.1 <- fromJSON("../data/tema1/students.json")
dat.2 <- fromJSON("../data/tema1/student-courses.json")



install.packages('curl')
library(curl)
url <- "https://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
currencies <- fromJSON(url)

currency.data <- currencies$list$resources$resource$fields


head(dat.1, 3)
dat.1$Email

currency.data[1:5,1:2]
dat.1[c(2,5,8),]
dat.1[,c(2,5)]

head(dat.2,3)
