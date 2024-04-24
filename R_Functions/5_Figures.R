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

#Figure: ratio of clustered multi-AZ synapses
df_Pos_WT <- df_Pos[df_Pos$Genotype == 'WT',]
df_Pos_B2 <- df_Pos[df_Pos$Genotype == 'B2',]
df_Neg_WT <- df_Neg[df_Pos$Genotype == 'WT',]
df_Neg_B2 <- df_Neg[df_Pos$Genotype == 'B2',]

Exp5_plot(df_Pos_WT,base_folder)
Exp5_plot(df_Neg_WT,base_folder)
Exp5_plot(df_Pos_B2,base_folder)
Exp5_plot(df_Neg_B2,base_folder)




















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