# dev.new()
getwd()
# install.packages("BiocManager")
# BiocManager::install("ggtree")

df<-read.csv("D:/.R-code templates/R-tools/Family_tree/ggtree_example.csv", 
             row.names = 1)
head(df)

hc <- hclust(dist(df))

library(ggplot2)
ggtree(hc,layout = "circular")+
  geom_tiplab2(offset=0.1,size=2)+
  geom_highlight(node = 152,fill="red")+
  geom_highlight(node = 154,fill="steelblue")+
  geom_highlight(node = 155,fill="green")+
  geom_cladelabel(node=152,label="AAA",
                  offset = 1.5,barsize = 2,
                  vjust=-0.5,color="red")+
  geom_cladelabel(node=154,label="BBB",
                  offset = 1.5,barsize = 2,
                  hjust=1.2,color="steelblue")+
  geom_cladelabel(node=155,label="CCC",
                  offset = 1.5,barsize = 2,
                  hjust=-1,color="green")
