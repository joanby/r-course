m <- matrix(seq(1,16), 4, 4)
m

# 1 -> función aplicada por filas
# 2 -> función aplicada por columnas
# c(1,2) -> función aplicada a elementos

apply(m, 1, min )
apply(m, 2, max)

apply(m, 1, prod)
apply(m, 2, sum)

apply(m, c(1,2), function(x){x^2})


apply(m, 1, quantile, probs = c(0.4, 0.6, 0.8))


colSums(m)
rowSums(m)

colMeans(m)
rowMeans(m)



array3D <- array(seq(1, 32), dim = c(4,4,2))
array3D

apply(array3D, 3, sum)
sum(1:16)
apply(array3D, 3, mean)
apply(array3D, c(1,2), sum)

