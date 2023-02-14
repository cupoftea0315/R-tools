library(limma)
inputFile="input.txt"      
logFCfilter=1              
adj.P.Val.Filter=0.05       
rt=read.table(inputFile, header=T, sep="\t", check.names=F)
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>0,]
sampleName1=c()
files=dir()
files=grep("S1.txt$", files, value=T)
for(file in files){
  rt=read.table(file, header=F, sep="\t", check.names=F)      
  geneNames=as.vector(rt[,1])     
  uniqGene=unique(geneNames)    
  sampleName1=c(sampleName1, uniqGene)
}
sampleName2=c()
files=dir()
files=grep("S2.txt$", files, value=T)
for(file in files){
  rt=read.table(file, header=F, sep="\t", check.names=F)      
  geneNames=as.vector(rt[,1])      
  uniqGene=unique(geneNames)       
  sampleName2=c(sampleName2, uniqGene)
}
conData=data[,sampleName1]
treatData=data[,sampleName2]
data=cbind(conData,treatData)
conNum=ncol(conData)
treatNum=ncol(treatData)
Type=c(rep("con",conNum),rep("treat",treatNum))
design <- model.matrix(~0+factor(Type))
colnames(design) <- c("con","treat")
fit <- lmFit(data,design)
cont.matrix<-makeContrasts(treat-con,levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2)
allDiff=topTable(fit2,adjust='fdr',number=200000)
allDiffOut=rbind(id=colnames(allDiff),allDiff)
write.table(allDiffOut, file="all.txt", sep="\t", quote=F, col.names=F)
diffSig=allDiff[with(allDiff, (abs(logFC)>logFCfilter & P.Value < adj.P.Val.Filter )), ]
diffSigOut=rbind(id=colnames(diffSig),diffSig)
write.table(diffSigOut, file="diff.txt", sep="\t", quote=F, col.names=F)
