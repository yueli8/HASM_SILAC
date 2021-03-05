library(fgsea)
library(tidyverse)
library(data.table)
library(ggplot2)
setwd("/media/hp/04c65089-71ff-4b33-9a30-c21b8c77eda2/li/HASM_SILAC/finally/fgsea")

#AC2_vs_lacZ
res<-read.table("AC2_vs_lacZ_fgsea01.txt")
ranks <- deframe(res)
pathways.kegg<- gmtPathways("c2.cp.kegg.v7.2.symbols.gmt")
pathways<-gmtPathways("c2.cp.v7.2.symbols.gtm")
fgseaRes_kegg<- fgsea(pathways = pathways.kegg, stats  = ranks,  minSize = 1,maxSize  = Inf)
fgseaRes<- fgsea(pathways = pathways, stats  = ranks,  minSize = 1,maxSize  = Inf)
fwrite(fgseaRes_kegg, file="AC2_vs_lacZ_kegg01.txt", sep="\t", sep2=c("", " ", ""))
fwrite(fgseaRes, file="AC2_vs_lacZ01.txt", sep="\t", sep2=c("", " ", ""))


plotEnrichment(pathways.kegg[["KEGG_LYSOSOME"]],
               ranks) + labs(title="LYSOSOME")


#AC6_vs_lacZ
res<-read.table("AC6_vs_lacZ_fgsea01.txt")
ranks <- deframe(res)
pathways.kegg<- gmtPathways("c2.cp.kegg.v7.2.symbols.gmt")
pathways<-gmtPathways("c2.cp.v7.2.symbols.gtm")
fgseaRes_kegg<- fgsea(pathways = pathways.kegg, stats  = ranks,  minSize = 1,maxSize  = Inf)
fgseaRes<- fgsea(pathways = pathways, stats  = ranks,  minSize = 1,maxSize  = Inf)
fwrite(fgseaRes_kegg, file="AC6_vs_lacZ_kegg01.txt", sep="\t", sep2=c("", " ", ""))
fwrite(fgseaRes, file="AC6_vs_lacZ01.txt", sep="\t", sep2=c("", " ", ""))

