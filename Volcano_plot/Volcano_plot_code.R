getwd()
df <- read.csv("volcano_plot_example_data.csv",header=T,
             stringsAsFactors = F)
head(df)
dim(df)
df$group <- ifelse(df$logFC>=2&df$P.Value<=0.05,"Up",
                 ifelse(df$logFC<=-2&df$P.Value<=0.05,"Down","Not sig"))
table(df$group)
library(ggplot2)
library(ggrepel)
df$pvalue_log10<-(-log10(df$P.Value))
df1<-df[df$pvalue_log10>=10,]
dim(df1)
ggplot(df,aes(x=logFC,y=-log10(P.Value))) + geom_point(aes(color=group)) +
  scale_color_manual(values=c("dodgerblue","gray","firebrick")) +
  geom_label_repel(data=df1,aes(x=logFC,y=-log10(P.Value),label=gene_name)) +
  labs(y="-log10(pvalue)",x="log(Fold Change)") +
  theme_bw()
