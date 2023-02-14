library(VennDiagram)               
files=dir()                        
files=grep("txt$",files,value=T)   
geneList=list()

for(i in 1:length(files)){
    inputFile=files[i]
	if(inputFile==outFile){next}
    rt=read.table(inputFile,header=F)        
    geneNames=as.vector(rt[,1])              
    geneNames=gsub("^ | $","",geneNames)     
    uniqGene=unique(geneNames)               
    header=unlist(strsplit(inputFile,"\\.|\\-"))
    geneList[[header[1]]]=uniqGene
    uniqLength=length(uniqGene)
    print(paste(header[1],uniqLength,sep=" "))
}

venn.plot=venn.diagram(geneList,filename=NULL,fill=rainbow(length(geneList)) )
p<-grid.draw(venn.plot)
