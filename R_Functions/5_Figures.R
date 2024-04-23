library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_Experiment_5.R")

#Data preparation
base_folder <- paste(project_directory,"/Data/Experiment_5/R_DataProcessing/",sep="")
filename <- paste(base_folder,"Reconstructed.csv",sep="")
df <- read.csv(filename)
df_Pos <- df[df$CTB=='Pos',]
df_Neg <- df[df$CTB=='Neg',]

df_Pos_WT <- df_Pos[df_Pos$Genotype == 'WT',]
df_Pos_B2 <- df_Pos[df_Pos$Genotype == 'B2',]
df_Neg_WT <- df_Neg[df_Pos$Genotype == 'WT',]
df_Neg_B2 <- df_Neg[df_Pos$Genotype == 'B2',]

Exp5_plot <- function(df){
  df_orig <- df[df$Type=='Orig',]
  df_rand <- df[df$Type=='Rand',]
  df_orig_2 <- data_summary(df_orig,'Clustered_ratio','Age')
  df_rand_2 <- data_summary(df_rand,'Clustered_ratio','Age')
  df_orig_2$Type <- 'Orig'
  df_rand_2$Type <- 'Rand'
  df_2 <- rbind(df_orig_2,df_rand_2)
  ggplot(data=df_2,aes(x=Age,y=Clustered_ratio,fill=Type)) + 
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=Clustered_ratio-se,ymax=Clustered_ratio+se),position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    coord_cartesian(ylim=c(0.0,1.0)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
}

Exp5_plot(df_Pos_WT)








#Write the datasets
write.csv(df_pos_WT,paste(outpath,"Pos_WT.csv",sep=""))
write.csv(df_pos_B2,paste(outpath,"Pos_B2.csv",sep=""))
write.csv(df_neg_WT,paste(outpath,"Neg_WT.csv",sep=""))
write.csv(df_neg_B2,paste(outpath,"Neg_B2.csv",sep=""))

#Plot: 
get_figure_norm_clustering_effect(df_pos_WT,outpath,yrange=c(1,6.0))
get_figure_norm_clustering_effect(df_pos_B2,outpath,yrange=c(1,6.0))
get_figure_norm_clustering_effect(df_neg_WT,outpath,yrange=c(1,6.0))
get_figure_norm_clustering_effect(df_neg_B2,outpath,yrange=c(1,6.0))

#Get statistics: 
Age_level = c('P2','P4','P8')
Experiment21a_batch(df_pos_WT)
Experiment21a_batch(df_pos_B2)
Experiment21a_batch(df_neg_WT)
Experiment21a_batch(df_neg_B2)

#A quick plot of the effect size (Eta^2)
Eta_directory = paste(project_directory,"Data/Experiment_2/1a_Direct_ratio_comp/R_Statistics/",sep="")
Eta_file = paste(Eta_directory,"Summary.csv",sep="")
df <- read.csv(Eta_file)
df$Genotype <- substring(df$No_sample,5,6)
df_WT <- df[df$Genotype=='WT',]
ggplot(data=df_WT,aes(x=No_sample,y=Eta.2)) + 
  geom_bar(stat='identity') +
  coord_cartesian(ylim=c(0,1)) + 
  scale_y_continuous(expand = c(0, 0)) +
  theme_classic()
ggsave(path = Eta_directory,filename='WT_Eta.png')
df_B2 <- df[df$Genotype=='B2',]
ggplot(data=df_B2,aes(x=No_sample,y=Eta.2)) + 
  geom_bar(stat='identity') + 
  coord_cartesian(ylim=c(0,1)) + 
  scale_y_continuous(expand = c(0, 0)) +
  theme_classic()
ggsave(path = Eta_directory,filename='B2_Eta.png')