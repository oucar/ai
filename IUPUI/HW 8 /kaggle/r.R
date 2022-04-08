data <- read.csv('dolphin_network.csv')
View(data)

install.packages("igraph")
library(igraph)

# help("read.graph")
# graph_from_data_frame
g <- graph_from_data_frame(data)

# This graph in DN has 62 nodes and 158 edges, has labels
summary(g)

# Number of nodes
vcount(g)

# Number of edges
ecount(g)

# Print nodes
V(g)

# Print a sample of 10 edges
E(g)[sample(1:ecount(g), 10)]

# Visualizing the graph
coords = layout.fruchterman.reingold(g)
plot(g, layout=coords, vertex.label=NA, vertex.size=5)



#g1 <- graph( edges=c(1, 2, 2, 3, 3, 4,4,5,5,1),  directed=T )
#diameter(g1) # gives 4
#g2 <- graph( edges=c(1, 2, 2, 3, 3, 4,4,5,5,1),  directed=F )
#diameter(g2) # gives 2