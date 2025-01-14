library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)

setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./8.6_Statistics_revisit.R")


Comp_Type_at_each_Age_pairedT <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  if (groupname=="CTB"){
    df_P2_Pos <- as.numeric(unlist(df_P2[df_P2$CTB=='Pos',][yname]))
    df_P2_Neg <- as.numeric(unlist(df_P2[df_P2$CTB=='Neg',][yname]))
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,alternative='greater',paired=TRUE)
    print(df_P2.t)
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,paired=TRUE)
    print(df_P2.t)
    df_P4_Pos <- as.numeric(unlist(df_P4[df_P4$CTB=='Pos',][yname]))
    df_P4_Neg <- as.numeric(unlist(df_P4[df_P4$CTB=='Neg',][yname]))
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,alternative='greater',paired=TRUE)
    print(df_P4.t)
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,paired=TRUE)
    print(df_P4.t)
    df_P8_Pos <- as.numeric(unlist(df_P8[df_P8$CTB=='Pos',][yname]))
    df_P8_Neg <- as.numeric(unlist(df_P8[df_P8$CTB=='Neg',][yname]))
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,alternative='greater',paired=TRUE)
    print(df_P8.t)
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,paired=TRUE)
    print(df_P8.t)
  }
  if (groupname=="Type"){
    df_P2_Pos <- as.numeric(unlist(df_P2[df_P2$Type=='Multi_orig',][yname]))
    df_P2_Neg <- as.numeric(unlist(df_P2[df_P2$Type=='Singl_orig',][yname]))
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,alternative='greater',paired=TRUE)
    print(df_P2.t)
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,paired=TRUE)
    print(df_P2.t)
    df_P4_Pos <- as.numeric(unlist(df_P4[df_P4$Type=='Multi_orig',][yname]))
    df_P4_Neg <- as.numeric(unlist(df_P4[df_P4$Type=='Singl_orig',][yname]))
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,alternative='greater',paired=TRUE)
    print(df_P4.t)
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,paired=TRUE)
    print(df_P4.t)
    df_P8_Pos <- as.numeric(unlist(df_P8[df_P8$Type=='Multi_orig',][yname]))
    df_P8_Neg <- as.numeric(unlist(df_P8[df_P8$Type=='Singl_orig',][yname]))
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,alternative='greater',paired=TRUE)
    print(df_P8.t)
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,paired=TRUE)
    print(df_P8.t)
  }
}

#Figure 3, revisit, experiment 10:
{
{
  project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
  filename <- paste(project_directory,"Raw_2.xlsx",sep="")
  df <- read.xlsx(filename,sheet=1)
  df <- get_df_WT(df)
  df <- get_df_Pos(df)
  df <- get_rid_of_rand(df)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(project_directory,"3_WT_Pos.txt")
  sink(file=outfile)
  Comp_Type_at_each_Age_pairedT(df,yname,groupname)
  sink(NULL)
}
{
  project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
  filename <- paste(project_directory,"Raw_2.xlsx",sep="")
  df <- read.xlsx(filename,sheet=1)
  df <- get_df_B2(df)
  df <- get_df_Pos(df)
  df <- get_rid_of_rand(df)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(project_directory,"3_B2_Pos.txt")
  sink(file=outfile)
  Comp_Type_at_each_Age_pairedT(df,yname,groupname)
  sink(NULL)
}
{
  project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
  filename <- paste(project_directory,"Raw_2.xlsx",sep="")
  df <- read.xlsx(filename,sheet=1)
  df <- get_df_WT(df)
  df <- get_df_Neg(df)
  df <- get_rid_of_rand(df)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(project_directory,"3_WT_Neg.txt")
  sink(file=outfile)
  Comp_Type_at_each_Age_pairedT(df,yname,groupname)
  sink(NULL)
}
{
  project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
  filename <- paste(project_directory,"Raw_2.xlsx",sep="")
  df <- read.xlsx(filename,sheet=1)
  df <- get_df_B2(df)
  df <- get_df_Neg(df)
  df <- get_rid_of_rand(df)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(project_directory,"3_B2_Neg.txt")
  sink(file=outfile)
  Comp_Type_at_each_Age_pairedT(df,yname,groupname)
  sink(NULL)
}
}