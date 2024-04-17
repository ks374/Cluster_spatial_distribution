library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_Experiment_2.1.a.R")

base_folder <- paste(project_directory,"/Data/Experiment_2/1a_Direct_ratio_comp/",sep="")
inpath <- paste(base_folder,"Raw/",sep="")
outpath <- paste(base_folder,"R_Files/",sep="")

#Data preparation
filename <- paste(inpath,"Neg_multi.csv",sep="")
df_neg_multi <- get_norm_clustering_df(read.csv(filename))
df_neg_multi$Type <- 'multi'
filename <- paste(inpath,"Neg_single.csv",sep="")
df_neg_single <- get_norm_clustering_df(read.csv(filename))
df_neg_single$Type <- 'single'
filename <- paste(inpath,"Pos_multi.csv",sep="")
df_pos_multi <- get_norm_clustering_df(read.csv(filename))
df_pos_multi$Type <- 'multi'
filename <- paste(inpath,"Pos_single.csv",sep="")
df_pos_single <- get_norm_clustering_df(read.csv(filename))
df_pos_single$Type <- 'single'
df_pos <- rbind(df_pos_multi,df_pos_single)
df_neg <- rbind(df_neg_multi,df_neg_single)

df_pos_WT <- df_pos[df_pos$Genotype=='WT',]
df_pos_B2 <- df_pos[df_pos$Genotype=='B2',]
df_neg_WT <- df_neg[df_neg$Genotype=='WT',]
df_neg_B2 <- df_pos[df_neg$Genotype=='B2',]

#Write the datasets
write.csv(df_pos_WT,paste(outpath,"Pos_WT.csv",sep=""))
write.csv(df_pos_B2,paste(outpath,"Pos_B2.csv",sep=""))
write.csv(df_neg_WT,paste(outpath,"Neg_WT.csv",sep=""))
write.csv(df_neg_B2,paste(outpath,"Neg_B2.csv",sep=""))

#Plot: 
get_figure_norm_clustering_effect(df_pos_WT,outpath,yrange=c(0,6.0))
get_figure_norm_clustering_effect(df_pos_B2,outpath,yrange=c(0,6.0))
get_figure_norm_clustering_effect(df_neg_WT,outpath,yrange=c(0,6.0))
get_figure_norm_clustering_effect(df_neg_B2,outpath,yrange=c(0,6.0))

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
  geom_bar(stat='identity')
ggsave(path = Eta_directory,filename='WT_Eta.png')
df_B2 <- df[df$Genotype=='B2',]
ggplot(data=df_B2,aes(x=No_sample,y=Eta.2)) + 
  geom_bar(stat='identity')
ggsave(path = Eta_directory,filename='B2_Eta.png')