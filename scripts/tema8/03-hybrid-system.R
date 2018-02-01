#Sistemas híbridos : UBCF + Random Selection
library(recommenderlab)
data("MovieLense")
data_frame <- MovieLense[rowCounts(MovieLense)>50,]

train <- data_frame[1:100]
test  <- data_frame[101:110]

hybrid_recom <- HybridRecommender(
  Recommender(train, method = "UBCF"),
  Recommender(train, method = "RANDOM"), 
  weights = c(0.25, 0.75)
)


as(predict(hybrid_recom, test, 3), "list")
