library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)

project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
Code_directory <- "E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/"
setwd(Code_directory)
source("./8.6_stats_func.R")
source("./Func_Def_Experiment_2.1.a.R")

Exp10_plot <- function(df,project_directory,lim1,lim2,lim3){
  df <- get_rid_of_rand(df)
  df_P2 <- get_df_P2(df)
  df_P2_2 <- data_summary(df_P2,'Ratio','Type')
  df_P4 <- get_df_P4(df)
  df_P4_2 <- data_summary(df_P4,'Ratio','Type')
  df_P8 <- get_df_P8(df)
  df_P8_2 <- data_summary(df_P8,'Ratio','Type')
  outpath <- project_directory
  
  Exp10_plot_core(df_P2_2,df_P2,outpath,lim1)
  Exp10_plot_core(df_P4_2,df_P4,outpath,lim2)
  Exp10_plot_core(df_P8_2,df_P8,outpath,lim3)
}

Exp10_plot_core <- function(df_2,df,outpath,lim){
  ggplot(data=df_2,aes(x=Type,y=Ratio)) + 
    geom_bar(stat='identity') +
    geom_errorbar(aes(ymin=Ratio-se,ymax=Ratio+se),width=.5) +
    geom_point(data=df) + 
    geom_line(data=df,aes(group=Name)) +
    coord_cartesian(ylim=lim) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  name_string <- deparse(substitute(df))
  name_string <- paste(name_string,"_P2",sep="")
  ggsave(path = outpath,filename=paste(name_string,".eps",sep=""))
  ggsave(path = outpath,filename=paste(name_string,".png",sep=""))
}

#Data preparation
filename <- paste(project_directory,"Raw_2.xlsx",sep="")
df <- read.xlsx(filename)

df_Pos <- get_df_Pos(df)
df_Neg <- get_df_Neg(df)

#Figure: ratio of clustered multi-AZ synapses
df_Pos_WT <- get_df_WT(df_Pos)
df_Pos_B2 <- get_df_B2(df_Pos)
df_Neg_WT <- get_df_WT(df_Neg)
df_Neg_B2 <- get_df_B2(df_Neg)

Exp10_plot(df_Pos_WT,project_directory,c(0.2,0.61),c(0.2,0.61),c(0.2,0.61))
Exp10_plot(df_Pos_B2,project_directory,c(0,0.41),c(0,0.41),c(0,0.41))
Exp10_plot(df_Neg_WT,project_directory,c(0,0.31),c(0,0.31),c(0,0.31))
Exp10_plot(df_Neg_B2,project_directory,c(0,0.41),c(0,0.41),c(0,0.41))