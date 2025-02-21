library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)

setwd("D:/Research/Projects/Project_17_4_color_continue/Cluster_spatial_distribution/R_Functions/")
source("./8.6_stats_func.R")
source("./Func_Def_Cumsum_Utility.R")
source("./Func_Def_basics.R")

Exp13_cumsum <- function(df1,df2,outpath,filename,xrange=c(0,12)){
  df1_sort <- get_norm_cumsum(df1,"Distance")
  df2_sort <- get_norm_cumsum(df2,"Distance")
  df1_sort$Type <- 'clu'
  df2_sort$Type <- 'iso'
  df <- rbind(df1_sort,df2_sort)
  ggplot(data=df,aes(x=Distance,y=norm_cumsum,color=Type)) + 
    geom_line() +
    coord_cartesian(xlim=xrange,ylim=c(0,1)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  ggsave(path = outpath,filename=paste(filename,".eps",sep=""))
  ggsave(path = outpath,filename=paste(filename,".png",sep=""))
}

Exp13_violin <- function(df1,df2,outpath,filename){
  df1_sum <- data_summary(df1,'Distance','Name')
  df2_sum <- data_summary(df2,'Distance','Name')
  df1_sum$Type <- 'clu'
  df2_sum$Type <- 'iso'
  df <- rbind(df1,df2)
  df_sum <- rbind(df1_sum,df2_sum)
  df_sum$Sample <- substring(df_sum$Name,5,5)
  ggplot() + 
    geom_violin(data=df,aes(x=Type,y=Distance),na.rm=TRUE) +
    geom_point(data=df_sum,aes(x=Type,y=Distance),na.rm=TRUE) +
    geom_line(data=df_sum,aes(x=Type,y=Distance,group=Sample)) +
    #coord_cartesian(ylim=c(0,1)) +
    #scale_y_continuous() +
    theme_classic()
  ggsave(path = outpath,filename=paste(filename,".eps",sep=""))
  ggsave(path = outpath,filename=paste(filename,".png",sep=""))
}

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_13/"
filename <- paste(project_directory,"Exp13_all.csv",sep="")
df <- read.csv(filename)

df <- df[df['CTB'] == 'Neg_Pos',]
#Data prep
{
  #Data prep
  df_WT <- get_df_WT(df)
  df_B2 <- get_df_B2(df)
  df_WT_P2 <- get_df_P2(df_WT)
  df_WT_P4 <- get_df_P4(df_WT)
  df_WT_P8 <- get_df_P8(df_WT)
  df_B2_P2 <- get_df_P2(df_B2)
  df_B2_P4 <- get_df_P4(df_B2)
  df_B2_P8 <- get_df_P8(df_B2)
  df_WT_P2_clu <- get_df_clu(df_WT_P2)
  df_WT_P2_iso <- get_df_iso(df_WT_P2)
  df_WT_P4_clu <- get_df_clu(df_WT_P4)
  df_WT_P4_iso <- get_df_iso(df_WT_P4)
  df_WT_P8_clu <- get_df_clu(df_WT_P8)
  df_WT_P8_iso <- get_df_iso(df_WT_P8)
  df_B2_P2_clu <- get_df_clu(df_B2_P2)
  df_B2_P2_iso <- get_df_iso(df_B2_P2)
  df_B2_P4_clu <- get_df_clu(df_B2_P4)
  df_B2_P4_iso <- get_df_iso(df_B2_P4)
  df_B2_P8_clu <- get_df_clu(df_B2_P8)
  df_B2_P8_iso <- get_df_iso(df_B2_P8)
}

#Exp13_cumsum(df_WT_P2_clu,df_WT_P2_iso,project_directory,"WTP2")
#Exp13_cumsum(df_WT_P4_clu,df_WT_P4_iso,project_directory,"WTP4")
#Exp13_cumsum(df_WT_P8_clu,df_WT_P8_iso,project_directory,"WTP8")
#Exp13_cumsum(df_B2_P2_clu,df_B2_P2_iso,project_directory,"B2P2")
#Exp13_cumsum(df_B2_P4_clu,df_B2_P4_iso,project_directory,"B2P4")
#Exp13_cumsum(df_B2_P8_clu,df_B2_P8_iso,project_directory,"B2P8")


Exp13_violin(df_WT_P2_clu,df_WT_P2_iso,project_directory,"WTP2")
Exp13_violin(df_WT_P4_clu,df_WT_P4_iso,project_directory,"WTP4")
Exp13_violin(df_WT_P8_clu,df_WT_P8_iso,project_directory,"WTP8")
Exp13_violin(df_B2_P2_clu,df_B2_P2_iso,project_directory,"B2P2")
Exp13_violin(df_B2_P4_clu,df_B2_P4_iso,project_directory,"B2P4")
Exp13_violin(df_B2_P8_clu,df_B2_P8_iso,project_directory,"B2P8")