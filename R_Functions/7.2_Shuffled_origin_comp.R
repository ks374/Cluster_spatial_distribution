library(ggplot2)
library(readxl)
library(dplyr)
library(plyr)
library(tidyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_basics.R")

in_directory <- paste(project_directory,"Data/Experiment_7/Reconstructed/",sep="")
infile_pos_pos_shuffle <- paste(in_directory,"Pos_pos.csv",sep="")
infile_pos_pos_origin <- paste(in_directory,"Pos_pos_original.csv",sep="")

df_shuffle <- read.csv(infile_pos_pos_shuffle)
df_origin <- read.csv(infile_pos_pos_origin)
df_origin$trans1 <- df_origin$Near_dist
df_shuffle <- filter(df_shuffle,!is.na(trans1))
df_origin <- filter(df_origin,!is.na(trans1))

df_shuffle_2 <- data_summary_med(df_shuffle,'trans1','No_sample')
df_origin_2 <- data_summary_med(df_origin,'trans1','No_sample') 
df_origin[6414,]$trans1 == '#NULL!' #Returns TRUE
#STOPPEDHERE!!! Need to drop Null values. 

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

