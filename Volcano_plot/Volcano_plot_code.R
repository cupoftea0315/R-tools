# dev.new()
getwd()

df <- read.csv("Volcano_plot/volcano_plot_example_data.csv",
               header = TRUE, stringsAsFactors = FALSE)
head(df)
dim(df)
df$group <- ifelse(df$logFC>=2&df$P.Value<=0.05, "Up", 
                   ifelse(df$logFC<=-2&df$P.Value<=0.05, "Down", "Not sig"))
table(df$group)
df$pvalue_log10 <- (-log10(df$P.Value))
df_sig <- df[df$pvalue_log10>=10,]
head(df_sig)
dim(df_sig)

library(ggplot2)
library(ggrepel)
ggplot(df,aes(x=logFC,y=-log10(P.Value))) + geom_point(aes(color=group)) +
  scale_color_manual(values=c("dodgerblue","gray","firebrick")) +
  geom_label_repel(data=df_sig,aes(x=logFC,y=-log10(P.Value),label=gene_name)) +
  labs(y="-log10(pvalue)",x="log(Fold Change)") +
  theme_bw()
