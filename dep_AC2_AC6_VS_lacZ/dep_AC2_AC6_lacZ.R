library(limma)
library(proDA)
library(sva)
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
library(calibrate)
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
library(calibrate)
#with(subset(res, P.Value<.05 & abs(logFC)>0.58496), textxy(logFC, -log10(P.Value), labs=Gene, cex=.6))
abline(h=1.3,v=0.58496,lty=3)
abline(v=-0.58496,lty=3)