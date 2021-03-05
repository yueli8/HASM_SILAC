library(ggplot2)
setwd("/media/hp/04c65089-71ff-4b33-9a30-c21b8c77eda2/li/HASM_SILAC/finally/david/AC2_AC6_finally")
AC2_CC<-read.table("AC2_01_CC.txt", sep="\t", header=TRUE)
S1<- ggplot(AC2_CC, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1


AC6_CC<-read.table("AC6_01_CC.txt", sep="\t", header=TRUE)
S1<- ggplot(AC6_CC, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1


AC6_MF<-read.table("AC6_01_MF.txt", sep="\t", header=TRUE)
S1<- ggplot(AC6_MF, aes(x= Enrichment_Ratio, y=Description, size=Gene_Count, color=P_Value, group=Enrichment_Ratio)) + geom_point(alpha = 25) + theme(axis.text.x = element_text(face="bold",size=20), axis.text.y = element_text(face="bold",size=20))
S1
S1 = S1+scale_color_gradient(low = "red2",  high = "mediumblue", space = "Lab")
S1
S1<-S1 + theme(axis.title.x =element_text(face="bold", size=25), axis.title.y=element_text(face="bold",size=25))
S1