library(mice)

housing.data <- read.csv("../data/tema1/housing-with-missing-value.csv",
                         header = TRUE,
                         stringsAsFactors = FALSE)


columns <- c("ptratio", "rad")

imputed_data <- mice(housing.data[,names(housing.data) %in% columns],
                     m = 5, 
                     maxit = 50, 
                     method = "pmm",
                     seed = 2018)

## pmm - comparación predictiva de medias
## logreg - regresión logistica
## polyreg - regresión logística politómica
## polr - modelo de probabilidades proporcionales. 

summary(imputed_data)


complete.data <- mice::complete(imputed_data)

housing.data$ptratio <- complete.data$ptratio
housing.data$rad <- complete.data$rad

anyNA(housing.data)



impute_arg <- aregImpute(~ptratio + rad, data = housing.data, n.impute = 5)

impute_arg

impute_arg$imputed$rad

