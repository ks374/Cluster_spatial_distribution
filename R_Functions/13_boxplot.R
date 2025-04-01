library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)
library(ggbeeswarm)

setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./8.6_stats_func.R")
source("./Func_Def_Cumsum_Utility.R")
source("./Func_Def_basics.R")

Exp13_box <- function(df1,df2,outpath,filename){
  df1_sum <- data_summary(df1,'Distance','Name')
  df2_sum <- data_summary(df2,'Distance','Name')
  df1_sum$Type <- 'clu'
  df2_sum$Type <- 'iso'
  df <- rbind(df1,df2)
  df_sum <- rbind(df1_sum,df2_sum)
  df_sum$Sample <- substring(df_sum$Name,5,5)
  ggplot() + 
    geom_boxplot(data=df,aes(x=Type,y=Distance),width=0.5,alpha=0.5,outlier.shape=NA,na.rm=TRUE) +
    geom_quasirandom(data=df,aes(x=Type,y=Distance),size=1,alpha=0.7,width=0.2) +
    scale_fill_brewer(palette = "Pastel1") +
    scale_color_brewer(palette = "Dark2") +
    geom_point(data=df_sum,aes(x=Type,y=Distance),size=5,na.rm=TRUE) +
    geom_line(data=df_sum,aes(x=Type,y=Distance,group=Sample)) +
    coord_cartesian(ylim=c(0,20)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  ggsave(path = outpath,filename=paste(filename,".eps",sep=""))
  ggsave(path = outpath,filename=paste(filename,".png",sep=""))
}

set.seed(123)
project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_13_figure4_revisit/"
filename <- paste(project_directory,"Exp13_all.csv",sep="")
df <- read.csv(filename)

df <- df[df['CTB'] == 'Pos_Pos',]
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


Exp13_box(df_WT_P2_clu,df_WT_P2_iso,project_directory,"WTP2")
Exp13_box(df_WT_P4_clu,df_WT_P4_iso,project_directory,"WTP4")
Exp13_box(df_WT_P8_clu,df_WT_P8_iso,project_directory,"WTP8")
Exp13_box(df_B2_P2_clu,df_B2_P2_iso,project_directory,"B2P2")
Exp13_box(df_B2_P4_clu,df_B2_P4_iso,project_directory,"B2P4")
Exp13_box(df_B2_P8_clu,df_B2_P8_iso,project_directory,"B2P8")