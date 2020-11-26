defMat<-read.csv("https://raw.githubusercontent.com/ochyzh/POLS478/master/defmat1914.csv", header=T)\
head(defMat)

defMat<-defMat %>% arrange(name1, name2) %>%
  pivot_wider(names_from=name2,values_from=ally)

defMat<-defMat[,-1]

library(igraph)
mygraph<-graph_from_adjacency_matrix(as.matrix(defMat),
                                     weighted=NULL,mode="directed",
                                     diag=FALSE)

mygraph<-delete.vertices(mygraph, which(degree(mygraph)==0))
plot(mygraph, vertex.color="turquoise", vertex.size=15, edge.arrow.size=.2, vertex.label.cex=.6)
