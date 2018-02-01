#MySQL y bases de datos relacionales
install.packages("RODBC")
install.packages("RJDBC")

install.packages("ROracle")
install.packages("RMySQL")

library(RODBC)
odbcDataSources()

con <- odbcConnect("myodbc",
                   uid = "jb",
                   pwd = "1234")

custData <- sqlQuery(con, "select rating from RecommendationSystem.Rating limit 5;")

custData

customers <- c("Juan Gabriel", "Ricardo", "María")
orderdate <- as.Date(c('2018-01-25', '2017-12-31', '2017-12-1'))
orderamount <- c(350, 44.65, 105.32)
orders <- data.frame(customers, orderdate, orderamount)

sqlSave(con, orders, "RecommendationSystem.Orders", append = F)

df <- sqlQuery(con, "select * from RecommendationSystem.Orders")
df


library(RMySQL)
con <- dbConnect(MySQL(),
                 dbname = "RecommendationSystem",
                 host = "127.0.0.1", 
                 port = 3306, 
                 username = "jb",
                 password = "1234")


ac <- dbReadTable(con, "Accomodation")
head(ac)

df <- dbGetQuery(con, "select * from Accomodation where title like '%chalet%'")
df

dbWriteTable(con, "Orders", orders, row.names = F)

dbReadTable(con, "Orders")


rs <- dbSendQuery(con, paste("SELECT a.location, max(a.price)",
                             "FROM Accomodation a ", 
                             "GROUP BY a.location ",
                             "ORDER BY max(a.price) DESC"))

while(!dbHasCompleted(rs)){
  print(fetch(rs, n = 2)) # n = -1 para obtenerlos todos de golpe
}

dbClearResult(rs)
dbDisconnect(con)
dbListConnections(dbDriver("MySQL"))


library(RJDBC)
driver <- JDBC("com.mysql.jdbc.Driver", 
               classPath = "../lib/mysql-connector-java-5.1.45/mysql-connector-java-5.1.45-bin.jar", "'")
con <- dbConnect(driver, "jdbc:mysql://127.0.0.1:3306/RecommendationSystem", 
                 "jb", "1234", useSSL = F)

dbReadTable(con, 'Accomodation')

dbGetQuery(con, "select * from Accomodation")
