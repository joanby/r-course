#Machine Learning
repos <- getOption("repos")
repos["mxnet"]<-"https://s3.amazonaws.com/mxnet-r"
repos
options(repos = repos)
install.packages("mxnet")
install.packages("jpeg")
install.packages("png")

library(devtools)
devtools::install_github("rich-iannone/DiagrammeR")
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")


library(mxnet)
library(png)
library(jpeg)
library(EBImage)

if(!file.exists("../data/tema8/syntex.txt")){
  download.file("http://data.dmlc.ml/mxnet/models/imagenet/inception-bn.tar.gz",
                destfile = "../data/tema8/inception-bn.tar.gz")
  untar("../data/tema8/inception-bn.tar.gz",
        exdir = "../data/tema8/")
  file.remove("../data/tema8/inception-bn.tar.gz")
}

model <- mx.model.load("../data/tema8/Inception-BN", iteration = 126)
synsets <- readLines("../data/tema8/synset.txt")
synsets

elephant <- readImage("../data/tema8/elephant.jpg")
kangaroo <- readImage("../data/tema8/kangaroo.jpg")
leopard <- readImage("../data/tema8/leopard.jpg")

head(elephant)

preproc.image <- function(image, isPng = F){
  n_channels = 3
  if(isPng){
    n_channels = 4
  }
  resized <- resize(image, 224, 224)
  arr <- as.array(resized) * 255
  dim(arr) <- c(224,224,n_channels)
  m <- mean(arr)
  print(paste("Color promedio de la imagen: ",m, sep = " "))
  norm <- arr - m
  dim(norm) = c(224,224,n_channels,1)
  #norm <- norm[,,1:3,]
  return(norm)
}



classify.image <- function(image, isPNG = F){
  image.n <- preproc.image(image, isPNG)
  prob <- predict(model, X = image.n)
  #De todas las categorías, nos quedamos el top 5 de más probables
  sorted.p <- order(prob[,1], decreasing = T)
  max.idx <- sorted.p[1:5]
  result <- data.frame(cat=synsets[max.idx], 
                     prob = 100.0*prob[sorted.p[1:5]])

  display(image)
  result
}


elephant.n <- elephant.n[,,1:3,]
prob <- predict(model, X = elephant.n)
display(elephant)
classify.image(elephant)

classify.image(kangaroo)
display(leopard)
classify.image(leopard)

policy <- readImage("../data/tema8/policy.jpg")
display(policy)
classify.image(policy)

donuts <- readImage("../data/tema8/donuts.jpeg")
display(donuts)
classify.image(donuts)
