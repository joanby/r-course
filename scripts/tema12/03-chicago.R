#Crimenes de Chicago
install.packages(c("ggmap", "maps"))
library(ggmap)
library(maps)

crimes <- read.csv("../data/tema12/chicago-full-crimes.csv")

crimes$Date <- strptime(crimes$Date, format = "%m/%d/%y %H:%M")
head(crimes)

chicago <- get_map(location = "chicago", zoom = 11)
ggmap(chicago) +
  geom_point(data = crimes[1:500,], aes(x=Longitude, y = Latitude))


counts <- as.data.frame(table(round(crimes$Longitude,2),
                              round(crimes$Latitude,2)
                              )
                        )
counts$Lon <- as.numeric(as.character(counts$Var1))
counts$Lat <- as.numeric(as.character(counts$Var2))
counts$Var1 <- NULL
counts$Var2 <- NULL

summary(counts)

ggmap(chicago) +
  geom_tile(data = counts, aes(x = Lon, y = Lat, alpha = Freq),
            fill = "red")
