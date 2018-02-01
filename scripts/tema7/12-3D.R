#Gráficos en 3D
install.packages("plot3D")
library(plot3D)
mtcars <- read.csv("../data/tema7/mtcars.csv")

rownames(mtcars) = mtcars$X
mtcars$X = NULL
head(mtcars)

scatter3D(x=mtcars$disp,
          y=mtcars$wt,
          z=mtcars$mpg,
          clab = c("Millas/Galeón"),
          pch=19,
          cex = 0.5,
          theta = 18, #azimutal
          phi=20, # colatitud
          main="Coches de los 70'",
          xlab = "Desplazamiento (cu.in.)",
          ylab = "Peso (x1000lb)",
          zlab = "Millas por galeón",
          bty = "g")

text3D(x=mtcars$disp,
       y=mtcars$wt,
       z=mtcars$mpg,
       labels = rownames(mtcars),
       add = T, 
       colkey = F, 
       cex = 0.5)


data(VADeaths)
head(VADeaths)
hist3D(z = VADeaths, 
       scale = F, expand = 0.01,
       bty = "g", phi = 30,
       col = "#1188CC", border = "black",
       shade = 0.2, ltheta = 80,
       space = 0.3,
       ticktype = "detailed")


scatter3D(x = mtcars$disp,
          y = mtcars$wt,
          z = mtcars$mpg,
          type = "h")



