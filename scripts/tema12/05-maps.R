#Maps
install.packages("maps")
library(maps)

map("world")
map("world", interior = F)
map("world", fill = TRUE, col = palette(rainbow(8)))

map("world", "tanzania")

map("france", sqmi = F)
map("italy")
map("world", "spain", sqmi = F)
map("usa", sqmi = F)

map("state" sqmi = F)
map("state", interior=F)
map("county")

map("state", "new jersey")
map("county", "new jersey")
