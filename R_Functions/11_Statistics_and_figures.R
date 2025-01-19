library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)

setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./8.6_stats_func.R")
source("./Func_Def_Cumsum_Utility.R")

Exp11_cumsum <- function(df1,df2,outpath,filename,xrange=c(0,15)){
  df1_sort <- get_norm_cumsum(df1,"Distance")
  df2_sort <- get_norm_cumsum(df2,"Distance")
  df <- rbind(df1_sort,df2_sort)
  ggplot(data=df,aes(x=Distance,y=norm_cumsum,color=CTB)) + 
    geom_line() +
    coord_cartesian(xlim=xrange,ylim=c(0,1)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  ggsave(path = outpath,filename=paste(filename,".eps",sep=""))
  ggsave(path = outpath,filename=paste(filename,".png",sep=""))
}

Comp_CTB_at_each_Age_ANOVA <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  df_P2.aov <- aov(reformulate(groupname,yname),data=df_P2)
  print(summary(df_P2.aov))
  df_P4.aov <- aov(reformulate(groupname,yname),data=df_P4)
  print(summary(df_P4.aov))
  df_P8.aov <- aov(reformulate(groupname,yname),data=df_P8)
  print(summary(df_P8.aov))
}


project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_11_beyond1.5/"
filename1 <- paste(project_directory,"Raw_pos.csv",sep="")
filename2 <- paste(project_directory,"Raw_neg.csv",sep="")
df1 <- read.csv(filename1)
df2 <- read.csv(filename2)

#Data prep
{
  #Data prep
  df1_WT <- get_df_WT(df1)
  df1_B2 <- get_df_B2(df1)
  df1_WT_P2 <- get_df_P2(df1_WT)
  df1_WT_P4 <- get_df_P4(df1_WT)
  df1_WT_P8 <- get_df_P8(df1_WT)
  df1_B2_P2 <- get_df_P2(df1_B2)
  df1_B2_P4 <- get_df_P4(df1_B2)
  df1_B2_P8 <- get_df_P8(df1_B2)
  df2_WT <- get_df_WT(df2)
  df2_B2 <- get_df_B2(df2)
  df2_WT_P2 <- get_df_P2(df2_WT)
  df2_WT_P4 <- get_df_P4(df2_WT)
  df2_WT_P8 <- get_df_P8(df2_WT)
  df2_B2_P2 <- get_df_P2(df2_B2)
  df2_B2_P4 <- get_df_P4(df2_B2)
  df2_B2_P8 <- get_df_P8(df2_B2)
}

Exp11_cumsum(df1_WT_P2,df2_WT_P2,project_directory,"WTP2")
Exp11_cumsum(df1_WT_P4,df2_WT_P4,project_directory,"WTP4")
Exp11_cumsum(df1_WT_P8,df2_WT_P8,project_directory,"WTP8")
Exp11_cumsum(df1_B2_P2,df2_B2_P2,project_directory,"B2P2")
Exp11_cumsum(df1_B2_P4,df2_B2_P4,project_directory,"B2P4")
Exp11_cumsum(df1_B2_P8,df2_B2_P8,project_directory,"B2P8")
