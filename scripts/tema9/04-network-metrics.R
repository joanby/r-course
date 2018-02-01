#Métricas
library(igraph)

load("../data/tema9/bipartite-graph.Rdata")
load("../data/tema9/meetup-hiking-d-graph.Rdata")
load("../data/tema9/meetup-hiking-graph.Rdata")

degree(bg)
plot.igraph(g)
plot.igraph(bg, layout = layout.bipartite)

degree(bg, "g3")
degree(dg, 15, mode = "out")

options(digits = 3)
degree.distribution(g)

betweenness(bg)
betweenness(bg, "g3")

edge.betweenness(bg)
edge.betweenness(dg, 10)

closeness(bg, mode = "in")


E(g)
E(dg)

neighbors(g,1)
neighbors(bg, "g3")

V(bg)$name[neighbors(bg, "g3")]


neighborhood(g, order = 2, nodes = 1)

#Añadir vértices a un grafo
new.g <- g + vertex(27,28)
new.g <- new.g + edge(27,28)
plot.igraph(new.g)

new.g <- new.g + vertex(28,30,31)
new.g <- delete.vertices(new.g, V(new.g)[degree(new.g)==0])

new.g <- delete.vertices(new.g, 1)


g.sub <- induced.subgraph(g, c(3,6,7,8,9,10,15,21))
plot.igraph(g.sub)
