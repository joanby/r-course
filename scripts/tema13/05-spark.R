
library(devtools)
devtools::install_github("apache/spark@v2.2.1", 
                         subdir = "R/pkg")

library(SparkR)
sparkR.session()

iris.df <- createDataFrame(iris)

showDF(iris.df, 5)

sub.iris.df <- select(iris.df, 
                      c("Sepal_Length", "Petal_Length"))  
showDF(sub.iris.df, 5)

library(magrittr)

agr.iris.df <- iris.df %>% groupBy("Species") %>%
  avg("Sepal_Length") %>%
  withColumnRenamed("avg(Sepal_Length)", "Avg_Sepal_Length") %>%
  orderBy("Species")
agr.iris.df$Avg_Sepal_Length <- format_number(agr.iris.df$Avg_Sepal_Length,2)

showDF(agr.iris.df)

createOrReplaceTempView(iris.df, "IrisTable")
collect(sql("SELECT * FROM IrisTable LIMIT 10"))
collect(sql(paste("SELECT Species sp, avg(Sepal_Length) avg_sl, ",
                  "avg(Sepal_Width) avg_sw FROM IrisTable ",
                  "GROUP BY sp ORDER BY avg_sl desc")))



