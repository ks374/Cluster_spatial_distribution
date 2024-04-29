library(ggplot2)
library(readxl)
library(dplyr)
library(tidyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
#source("./Func_Def_Experiment_5.R")

in_directory <- paste(project_directory,"Data/Experiment_7/Reconstructed/",sep="")
infile_neg_neg <- paste(in_directory,"Neg_neg.csv",sep="")
infile_neg_pos <- paste(in_directory,"Neg_pos.csv",sep="")
infile_pos_neg <- paste(in_directory,"Pos_neg.csv",sep="")
infile_pos_pos <- paste(in_directory,"Pos_pos.csv",sep="")

df <- read.csv(infile_pos_pos)
df <- filter(df,!is.na(trans1))

No_Sample_Name = 'WTP4'

df_2 <- df[df$No_sample == No_Sample_Name,]
df_2_Clu <- df_2[df_2$Type == 'Clustred',]
df_2_Iso <- df_2[df_2$Type == 'Isolated',]
df_2_Clu$Sort <- sort(df_2_Clu$trans1,na.last=TRUE)
df_2_Clu <- drop_na(df_2_Clu,Sort)
df_2_Clu$Cumsum <- cumsum(df_2_Clu$Sort / sum(df_2_Clu$Sort))
df_2_Iso$Sort <- sort(df_2_Iso$trans1,na.last=TRUE)
df_2_Iso <- drop_na(df_2_Iso,Sort)
df_2_Iso$Cumsum <- cumsum(df_2_Iso$Sort / sum(df_2_Iso$Sort))

colors <- c("1" = "#FF0000","2" = "#000000")
ggplot(data = df_2_Clu,aes(x=Sort,y=Cumsum)) + 
  geom_line(aes(color="1"),na.rm=TRUE,linewidth=1) + 
  geom_line(data = df_2_Iso,aes(color="2"),na.rm=TRUE,linewidth=1) + 
  labs(color = "Legend") + 
  coord_cartesian(ylim=c(0.0,1.0),xlim=c(0.0,9.0)) + 
  scale_color_manual(values=colors) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0)) +
  theme_classic()

#ggsave("D:/Reaearch/Projects/Project_17_4_color_continue/Data/CTB_specific/Comp_near_comp_2/Comp_pos_comp_pos_thre_1.5/WTP2.png")
#ggsave("D:/Reaearch/Projects/Project_17_4_color_continue/Data/CTB_specific/Comp_near_comp_2/Comp_pos_comp_pos_thre_1.5/WTP2.eps")

