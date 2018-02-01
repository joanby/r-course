#Correlation Matrix
library(ggplot2)
library(corrplot)
mtcars <- read.csv("../data/tema7/mtcars.csv")
head(mtcars)
mtcars$X = NULL
mtcars.cor <- cor(mtcars, method = "pearson")

round(mtcars.cor, digits = 2)
corrplot(mtcars.cor)

corrplot(mtcars.cor, method = "shade", 
         shade.col = NA, tl.col = "black", 
         tl.srt = 45)

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", 
                          "#77AADD", "#4477AA"))
corrplot(mtcars.cor, method = "square", 
         tl.col = "black",
         tl.srt = 45, col = col(200), 
         addCoef.col = "black",
         order = "AOE", 
         type = "upper",
         diag = F,
         addshade = "all")



library(reshape2)
mtcars.melted <- melt(mtcars.cor)
head(mtcars.cor)
head(mtcars.melted)

ggplot(data = mtcars.melted, 
       aes(x=Var1, y=Var2,fill=value))+
  geom_tile()



get_lower_triangle <- function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}

get_upper_triangle <- function(cormat){
  cormat[lower.tri(cormat)] <- NA
  return(cormat)
}

reorder_cormat <- function(cormat){
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd)
  cormat <- cormat[hc$order, hc$order]
}



cormat <- reorder_cormat(mtcars.cor)
cormat.ut <- get_upper_triangle(cormat)
cormat.ut.melted <- melt(cormat.ut, na.rm = T)

ggplot(cormat.ut.melted, aes(Var2, Var1, fill = value)) + 
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red",
                       mid = "white", midpoint = 0,
                       limit = c(-1,1), space = "Lab",
                       name="Pearson\nCorrelation")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, vjust=1, 
                                   size = 12, hjust=1))+
  coord_fixed()
