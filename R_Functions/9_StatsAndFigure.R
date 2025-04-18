library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)
library(pwr)

Exp9_plot <- function(df,lim,outpath){
  df2 <- data_summary(df,'Ratio','Type')
  ggplot(data=df2,aes(x=Type,y=Ratio)) + 
    geom_bar(stat='identity') +
    geom_errorbar(aes(ymin=Ratio-se,ymax=Ratio+se),width=.5) +
    geom_point(data=df) + 
    geom_line(data=df,aes(group=Name)) +
    coord_cartesian(ylim=lim) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  name_string <- deparse(substitute(df))
  ggsave(path = outpath,filename=paste(name_string,".eps",sep=""))
  ggsave(path = outpath,filename=paste(name_string,".png",sep=""))
  
  #Then get paired T test, print to txt file. 
  outfile_name <- paste(name_string,".txt",sep="")
  outfile <- paste(outpath,outfile_name,sep="")
  sink(outfile,append=TRUE)
  df_multi <- df[df$Type == 'multi',]
  df_multi <- df_multi[order(df_multi$Sample),]
  df_singl <- df[df$Type == 'singl',]
  df_singl <- df_singl[order(df_singl$Sample),]
  df_multi_num <- as.numeric(unlist(df_multi['Ratio']))
  df_singl_num <- as.numeric(unlist(df_singl['Ratio']))
  df.t <- t.test(df_multi_num,df_singl_num,alternative='greater',paired=TRUE)
  print(df.t)
  
  #Then write power test for the same file: 
  diff <- df_multi_num - df_singl_num
  diff <- as.vector(na.omit(diff))
  mean_diff <- mean(diff)
  sd_diff <- sd(diff)
  d_paired <- mean_diff / sd_diff
  n <- length(diff)
  power <- pwr.t.test(
    n = n,
    d = d_paired,
    sig.level = 0.05,
    type = "paired",
    alternative = "greater"
  )
  print(power)
  sink(NULL)
}

setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./8.6_stats_func.R")
source("./Func_Def_Experiment_2.1.a.R")

project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_9/Non_norm/"
filename <- paste(project_directory,"Pos_Pos.csv",sep="")
df <- read.csv(filename)
df_WT <- get_df_WT(df)
df_WT_P2 <- get_df_P2(df_WT)
df_WT_P4 <- get_df_P4(df_WT)
df_WT_P8 <- get_df_P8(df_WT)
df_B2 <- get_df_B2(df)
df_B2_P2 <- get_df_P2(df_B2)
df_B2_P4 <- get_df_P4(df_B2)
df_B2_P8 <- get_df_P8(df_B2)

Exp9_plot(df_WT_P2,lim=c(0,1),project_directory)
Exp9_plot(df_WT_P4,lim=c(0,1),project_directory)
Exp9_plot(df_WT_P8,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P2,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P4,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P8,lim=c(0,1),project_directory)

filename <- paste(project_directory,"Neg_Neg.csv",sep="")
df <- read.csv(filename)
df_WT <- get_df_WT(df)
df_WT_P2 <- get_df_P2(df_WT)
df_WT_P4 <- get_df_P4(df_WT)
df_WT_P8 <- get_df_P8(df_WT)
df_B2 <- get_df_B2(df)
df_B2_P2 <- get_df_P2(df_B2)
df_B2_P4 <- get_df_P4(df_B2)
df_B2_P8 <- get_df_P8(df_B2)

Exp9_plot(df_WT_P2,lim=c(0,1),project_directory)
Exp9_plot(df_WT_P4,lim=c(0,1),project_directory)
Exp9_plot(df_WT_P8,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P2,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P4,lim=c(0,1),project_directory)
Exp9_plot(df_B2_P8,lim=c(0,1),project_directory)
