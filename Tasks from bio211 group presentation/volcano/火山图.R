library(ggplot2)          
inputFile="input.txt"      
outFile="vol.pdf"          
logFCfilter=1               #logFC过滤阈值
fdrFilter=0.05              #矫正后p值阈值ֵ

rt=read.table(inputFile,sep="\t",header=T,check.names=F)

Significant=ifelse((rt$fdr<fdrFilter & abs(rt$logFC)>logFCfilter), ifelse(rt$logFC>logFCfilter,"Up","Down"), "Not")
p = ggplot(rt, aes(logFC, -log10(fdr)))+
    geom_point(aes(col=Significant))+
    scale_color_manual(values=c("green", "black", "red"))+
    labs(title = " ")+
    theme(plot.title = element_text(size = 16, hjust = 0.5, face = "bold"))
p=p+theme_bw()
p
