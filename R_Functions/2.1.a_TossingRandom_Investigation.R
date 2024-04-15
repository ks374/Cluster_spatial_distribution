setwd("D:/Research/Projects/Project_17_4_color_continue/Cluster_spatial_distribution/R_Functions/")
library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)
source("./Func_Def.R")

base_folder <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_2/1a_Direct_ratio_comp/"
inpath <- paste(base_folder,"Raw/",sep="")
outpath <- paste(base_folder,"R_Files/",sep="")
filename <- paste(inpath,"Neg_multi.csv",sep="")
df <- read.csv(filename)

data_summary <- function(data,varname,groupnames){
  require(plyr)
  summary_func <- function(x,col){
    sample_n <- nrow(x[col])
    if(sample_n>1){
      SE = sd(x[[col]],na.rm=TRUE)/sqrt(sample_n)
      alpha = 0.05
      DoF = sample_n - 1
      tscore = qt(p=alpha/2, df=DoF,lower.tail=FALSE)
      Merror = tscore * SE
      c(mean = mean(x[[col]],na.rm=TRUE), se = SE , Margin_error = Merror)
    }else{
      c(mean = mean(x[[col]],na.rm=TRUE), se = 0 , Margin_error = 0)
    }
  }
  data_sum <- ddply(data,groupnames,.fun=summary_func,varname)
  data_sum <- rename(data_sum,c("mean"=varname))
  return(data_sum)
}

df_WT <- df[df$Genotype == 'WT',]
df_WT_Orig <- df_WT[df_WT$Type == 'Orig',]
df_WT_Rand <- df_WT[df_WT$Type == 'Rand',]
df_WT_Orig_2 <- data_summary(df_WT_Orig,'Ratio','Age')
df_WT_Rand_2 <- data_summary(df_WT_Rand,'Ratio','Age')
df_WT_Orig_2$Type = 'Orig'
df_WT_Rand_2$Type = 'Rand'
df_WT_2 <- rbind(df_WT_Orig_2,df_WT_Rand_2)

level_order <- c('P2','P4','P8')

#Figure of sample size 3 vs. 30, error bar: CI. 
ggplot(data=df_WT_2,aes(x=factor(Age,level=level_order),y=Ratio)) +
  geom_bar(aes(fill=Type),stat='identity',na.rm=TRUE,position=position_dodge(0.9)) + 
  geom_errorbar(aes(ymin=Ratio-Margin_error, ymax=Ratio+Margin_error,group=Type), width=.3,position=position_dodge(0.9)) + 
  geom_point(data=df_WT,aes(fill=Type),position=position_dodge(width=0.9),size = 2) +
  #geom_line(data=df_Pos_WT,aes(group=Name),position=position_dodge(width=0.9)) +
  coord_cartesian(ylim=c(-0.1,0.7)) +
  theme_classic()
ggsave(path = outpath,filename="Neg_multi_3vs30_CI.tiff")
ggsave(path = outpath,filename="Neg_multi_3vs30_CI.eps")

df_WT <- df[df$Genotype == 'WT',]
df_WT_Orig <- df_WT[df_WT$Type == 'Orig',]
df_WT_Rand <- df_WT[df_WT$Type == 'Rand',]
df_WT_Rand <- df_WT_Rand[df_WT_Rand$Index == 1,]
df_WT <- rbind(df_WT_Orig,df_WT_Rand)
df_WT_Orig_2 <- data_summary(df_WT_Orig,'Ratio','Age')
df_WT_Rand_2 <- data_summary(df_WT_Rand,'Ratio','Age')
df_WT_Orig_2$Type = 'Orig'
df_WT_Rand_2$Type = 'Rand'
df_WT_2 <- rbind(df_WT_Orig_2,df_WT_Rand_2)
#Figure of 3 vs. 3, error bar: CI. 
ggplot(data=df_WT_2,aes(x=factor(Age,level=level_order),y=Ratio)) +
  geom_bar(aes(fill=Type),stat='identity',na.rm=TRUE,position=position_dodge(0.9)) + 
  geom_errorbar(aes(ymin=Ratio-Margin_error, ymax=Ratio+Margin_error,group=Type), width=.3,position=position_dodge(0.9)) + 
  geom_point(data=df_WT,aes(fill=Type),position=position_dodge(width=0.9),size = 2) +
  geom_line(data=df_WT,aes(group=Name),position=position_dodge(width=0.9)) +
  coord_cartesian(ylim=c(-0.1,0.7)) + scale_y_continuous(expand = c(0, 0)) +
  theme_classic()
ggsave(path = outpath,filename="Neg_multi_3vs3_CI.tiff")
ggsave(path = outpath,filename="Neg_multi_3vs3_CI.eps")


filename <- paste(inpath,"Pos_multi.csv",sep="")
df <- read.csv(filename)
df_WT <- df[df$Genotype == 'WT',]
df_WT_Orig <- df_WT[df_WT$Type == 'Orig',]
df_WT_Rand <- df_WT[df_WT$Type == 'Rand',]
df_WT_Orig_2 <- data_summary(df_WT_Orig,'Ratio','Age')
df_WT_Rand_2 <- data_summary(df_WT_Rand,'Ratio','Age')
df_WT_Orig_2$Type = 'Orig'
df_WT_Rand_2$Type = 'Rand'
df_WT_2 <- rbind(df_WT_Orig_2,df_WT_Rand_2)
level_order <- c('P2','P4','P8')
ggplot(data=df_WT_2,aes(x=factor(Age,level=level_order),y=Ratio)) +
  geom_bar(aes(fill=Type),stat='identity',na.rm=TRUE,position=position_dodge(0.9)) + 
  geom_errorbar(aes(ymin=Ratio-Margin_error, ymax=Ratio+Margin_error,group=Type), width=.3,position=position_dodge(0.9)) + 
  geom_point(data=df_WT,aes(fill=Type),position=position_dodge(width=0.9),size = 2) +
  #geom_line(data=df_Pos_WT,aes(group=Name),position=position_dodge(width=0.9)) +
  coord_cartesian(ylim=c(-0.1,0.7)) +
  theme_classic()
ggsave(path = outpath,filename="Pos_multi_3vs30_CI.tiff")
ggsave(path = outpath,filename="Pos_multi_3vs30_CI.eps")

#Comparison of an individual replicate:
filename <- paste(inpath,"Pos_multi.csv",sep="")
df <- read.csv(filename)
df_WT <- df[df$Genotype == 'WT',]
df_WT_WTP8B <- df_WT[df_WT$Name == 'WTP8_B',]
df_WT_WTP8B_2 <- data_summary(df_WT_WTP8B,'Ratio','Type')
df_WT_WTP8B_2

ggplot(data = df_WT_WTP8B_2,aes(x=Type,y=Ratio)) + 
  geom_bar(stat='identity') +
  geom_errorbar(aes(ymin=Ratio-Margin_error,ymax=Ratio+Margin_error),width = 0.5) + 
  geom_point(data = df_WT_WTP8B) + 
  coord_cartesian(ylim=c(0.0,0.61)) + 
  scale_y_continuous(expand = c(0, 0)) +
  theme_classic()
ggsave(path = outpath,filename="Pos_multi_try_single_CI.tiff")
ggsave(path = outpath,filename="Pos_multi_try_single_CI.eps")

#Dot-dot replicate comparison. 
filename <- paste(inpath,"Neg_multi.csv",sep="");
out_path <- paste(outpath,"3v3LinkedDots/",sep="");
Plot_3v3_linked_dots(filename,'WTP4',out_path,yrange=c(0.0,0.4))
Plot_3v3_linked_dots(filename,'WTP8',out_path,yrange=c(0.0,0.4))
Plot_3v3_linked_dots(filename,'B2P4',out_path,yrange=c(0.0,0.4))
filename <- paste(inpath,"Neg_single.csv",sep="");
Plot_3v3_linked_dots(filename,'WTP4',out_path,yrange=c(0.0,1))
Plot_3v3_linked_dots(filename,'WTP8',out_path,yrange=c(0.0,1))
Plot_3v3_linked_dots(filename,'B2P4',out_path,yrange=c(0.0,1))