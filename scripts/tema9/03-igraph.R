#igraph
install.packages("igraph")
library(igraph)
load("../data/tema9/meetup-hiking-edgelist.Rdata")

users_edgelist.filtered <- users_edgelist.upper[users_edgelist.upper$x>15,]
nrow(users_edgelist.filtered)
head(users_edgelist.filtered)

#reescalar los identificadores de usuario
uids <- unique(c(users_edgelist.filtered$i, users_edgelist.filtered$j))

i <- match(users_edgelist.filtered$i, uids)
j <- match(users_edgelist.filtered$j, uids)

new.graph <- data.frame(i, j, x = users_edgelist.filtered$x)

#representar grafos con igraph
g <- graph.data.frame(new.graph, directed = F)
g
save(g, file = "../data/tema9/meetup-hiking-graph.Rdata")
plot.igraph(g, vertex.size = 20)

plot.igraph(g, layout = layout.circle, vertex.size = 20)

plot.igraph(g, edge.curved = T, vertex.color = "pink", edge.color = "blue")

V(g)$size = degree(g)*4
plot.igraph(g, edge.curved = T, vertex.color = "pink", edge.color = "blue")

color <- ifelse(degree(g)>5,"red", "blue")
size <- degree(g)*4
plot.igraph(g, vertex.label = NA,
            layout = layout.fruchterman.reingold,
            vertex.color = color,
            vertex.size = size)

E(g)$x 
plot.igraph(g, edge.curved =T, edge.color = "black", 
            edge.width = (E(g)-min(E(g))+1)/5)



#Grafo dirigido
dg <- graph.data.frame(new.graph, directed=T)
save(dg, file = "../data/tema9/meetup-hiking-d-graph.Rdata")
plot.igraph(dg, edge.curved = T, edge.color = "black",
            vertex.label.cex = 0.5)

#Grafo con pesos en las aristas
new.graph.w <- new.graph
names(new.graph.w) <- c("i","j","weight")
wg<-graph.data.frame(new.graph.w,directed=F)
wg
E(wg)$weight
plot.igraph(wg, edge.label = E(wg)$weight)



#Obtener la matriz de adyacencia de un grafo
get.adjacency(g, type = "lower")
get.adjacency(g, type = "upper", attr = "x")

#Obtener la lista de aristas a partir de un grafo
get.data.frame(g)
V(g)$size = degree(g)
get.data.frame(g, "vertices")
get.data.frame(g, "both")


#Grafo bipartito
g1 <- rbinom(10,1,0.5)
g2 <- rbinom(10,1,0.5)
g3 <- rbinom(10,1,0.5)
g4 <- rbinom(10,1,0.5)
g5 <- rbinom(10,1,0.5)

membership <- data.frame(g1,g2,g3,g4,g5)
names(membership)
rownames(membership) <- c("u1","u2","u3","u4","u5","u6","u7","u8","u9","u10")
rownames(membership)

bg <- graph.incidence(membership)
bg
V(bg)$type
V(bg)$name

layout <- layout.bipartite(bg)
save(bg, file = "../data/tema9/bipartite-graph.Rdata")
plot(bg, layout=layout, vertex.size = 15)



#Proyección de un grafo bipartito
p <- bipartite.projection(bg)
p

plot(p$proj1, vertex.size = 15)
plot(p$proj2, vertex.size = 20)
