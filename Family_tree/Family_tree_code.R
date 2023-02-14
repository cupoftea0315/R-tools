getwd()
# install.packages("BiocManager")
# BiocManager::install("ggtree")

df<-read.csv("D:/.R-code templates/Family_tree/ggtree_example.csv",
             row.names = 1)
head(df)

hc<-hclust(dist(df))

library(ggplot2)
pdf(file = "ggtree_example.pdf",
    width = 7,height = 7,
    family = "serif")
ggtree(hc,layout = "circular")+
  xlim(0,5)+
  geom_tiplab2(offset=0.1,size=2)+
  geom_highlight(node = 152,fill="red")+
  geom_highlight(node=154,fill="steelblue")+
  geom_highlight(node = 155,fill="green")+
  geom_cladelabel(node=152,label="AAA",
                  offset = 1.2,barsize = 2,
                  vjust=-0.5,color="red")+
  geom_cladelabel(node=154,label="BBB",
                  offset = 1.2,barsize = 2,
                  hjust=1.2,color="steelblue")+
  geom_cladelabel(node=155,label="CCC",
                  offset = 1.2,barsize = 2,
                  hjust=-1,color="green")
dev.off()
