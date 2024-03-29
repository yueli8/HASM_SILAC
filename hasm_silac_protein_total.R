library(limma)
library(proDA)
library(sva)
library(calibrate)
library(ggplot2)
library(fgsea)
library(tidyverse)
library(data.table)

setwd("/media/hp/04c65089-71ff-4b33-9a30-c21b8c77eda2/li/HASM_SILAC/finally/DEP")
#raw data
a_9<-read.table("9samples_raw.txt")
dim(a_9)
a1<-as.matrix(a_9)
eset<-median_normalization(a1)
dim(eset)
design <- model.matrix(~ 0+factor(c(1,1,1,2,2,2,3,3,3)))
colnames(design) <- c("group1", "group2", "group3")
rownames(design) <- colnames(eset)
contrast.matrix <- makeContrasts(group2-group1, group3-group2, group3-group1, levels=design)
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast.matrix)
fit3 <- eBayes(fit2)

AC2_VS_lacZ_DEP<-topTable(fit3, coef=1, number='all', adjust="BH")#coef=1  group2-group1
write.table(AC2_VS_lacZ_DEP,"AC2_VS_lacZ_DEP01.txt")
AC6_VS_lacZ_DEP<-topTable(fit3, coef=3, number='all', adjust="BH")#coef=3  group3-group1
write.table(AC6_VS_lacZ_DEP,"AC6_VS_lacZ_DEP01.txt")

res <- read.table("AC2_VS_lacZ_DEP01.txt", header=TRUE)
head(res)
# Make a basic volcano plot
with(res, plot(logFC, -log10(P.Value), pch=20, main="Volcano plot", xlim=c(-5,7)))
# Add colored points: red if pvalue<0.05, orange of log2FC>1, green if both)
with(subset(res, P.Value<.05 ), points(logFC, -log10(P.Value), pch=20, col="red"))
with(subset(res, abs(logFC)>0.58496), points(logFC, -log10(P.Value), pch=20, col="orange"))
with(subset(res, P.Value<.05 & abs(logFC)>0.58496), points(logFC, -log10(P.Value), pch=20, col="green"))

# Label points with the textxy function from the calibrate plot
#with(subset(res, P.Value<.05 & abs(logFC)>0.58496), textxy(logFC, -log10(P.Value), labs=Gene, cex=.6))
abline(h=1.3,v=0.58496,lty=3)
abline(v=-0.58496,lty=3)
#dev.off()

res <- read.table("AC6_VS_lacZ_DEP01.txt", header=TRUE)
head(res)
# Make a basic volcano plot
with(res, plot(logFC, -log10(P.Value), pch=20, main="Volcano plot", xlim=c(-6,21)))
# Add colored points: red if pvalue<0.05, orange of log2FC>1, green if both)
with(subset(res, P.Value<.05 ), points(logFC, -log10(P.Value), pch=20, col="red"))
with(subset(res, abs(logFC)>0.58496), points(logFC, -log10(P.Value), pch=20, col="orange"))
with(subset(res, P.Value<.05 & abs(logFC)>0.58496), points(logFC, -log10(P.Value), pch=20, col="green"))

# Label points with the textxy function from the calibrate plot
#with(subset(res, P.Value<.05 & abs(logFC)>0.58496), textxy(logFC, -log10(P.Value), labs=Gene, cex=.6))
abline(h=1.3,v=0.58496,lty=3)
abline(v=-0.58496,lty=3)

setwd("/media/hp/04c65089-71ff-4b33-9a30-c21b8c77eda2/li/HASM_SILAC/finally/david/AC2_AC6_finally")
AC2_CC<-read.table("AC2_01_CC.txt", sep="\t", header=TRUE)
S1<- ggplot(AC2_CC, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1

AC6_CC<-read.table("AC6_01_CC.txt", sep="\t", header=TRUE)
S1<- ggplot(AC6_CC, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1


AC6_MF<-read.table("AC6_01_MF.txt", sep="\t", header=TRUE)
S1<- ggplot(AC6_MF, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1

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
