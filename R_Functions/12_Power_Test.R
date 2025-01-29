library(ggplot2)
library(pwr)
library(plyr)
library(openxlsx)

#setwd("D:/Research/Projects/Project_17_4_color_continue/Cluster_spatial_distribution/R_Functions/")
setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./Func_Def_basics.R")
source("./8.6_stats_func.R")
source("./Func_Power_Test.R")

#project_directory <- "D:/Research/Projects/Project_17_4_color_continue/First_submission_figure_data_stats/V7_Contain_all_raw/All_figure_Statistics/"
project_directory <- "E:/File/Work/2024/eLife manuscript/Data/"
filename <- paste(project_directory,"Fig. 1/Fig.1DEF.xlsx",sep="")
df <- read.xlsx(filename)

#Fig. 1E
outfile <- paste(project_directory,"Fig. 1/Fig.1E_Power.txt",sep="")
Fig1_Comp_CTB(df,'Comp_V_Density',outfile)

#Fig. 1F
outfile <- paste(project_directory,"Fig. 1/Fig.1F_Power.txt",sep="")
Fig1_Comp_CTB(df,'Ratio_Comp_V',outfile)

#Fig. S1
outfile <- paste(project_directory,"Fig. 1/Fig.S1_Power.txt",sep="")
Fig1_Comp_CTB(df,'Simp_V_Density',outfile)

#Fig. 2C
filename <- paste(project_directory,"Fig. 2/Fig. 2C.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 2/Fig.2C_Power.txt",sep="")
Fig1_Comp_CTB(df,'B_Near_Comp',outfile)

#Fig. 2D
filename <- paste(project_directory,"Fig. 2/Fig. 2DE.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 2/Fig.2D_S2_Power.txt",sep="")
Fig2_Comp_AZIndex(df,'Volume_um3',outfile)

#Fig. 2E
filename <- paste(project_directory,"Fig. 2/Fig. 2DE.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 2/Fig.2E_S2_Power.txt",sep="")
Fig2_Comp_AZIndex(df,'Ave_Vol',outfile)

#Fig. 3B and C
filename <- paste(project_directory,"Experiment_10_Figure3_normalized/Raw_3_orig.xlsx",sep="")
df <- read.xlsx(filename)
df_Pos <- get_df_Pos(df)
outfile <- paste(project_directory,"Experiment_10_Figure3_normalized/Fig.3_pos_orig_Power.txt",sep="")
FigS3_Comp_Type(df_Pos,'Ratio',outfile)
df_Neg <- get_df_Neg(df)
outfile <- paste(project_directory,"Experiment_10_Figure3_normalized/Fig.3_neg_orig_Power.txt",sep="")
FigS3_Comp_Type(df_Neg,'Ratio',outfile)
filename <- paste(project_directory,"Experiment_10_Figure3_normalized/Raw_3_rand.xlsx",sep="")
df <- read.xlsx(filename)
df_Pos <- get_df_Pos(df)
outfile <- paste(project_directory,"Experiment_10_Figure3_normalized/Fig.3_pos_rand_Power.txt",sep="")
FigS3_Comp_Type(df_Pos,'Ratio',outfile)
df_Neg <- get_df_Neg(df)
outfile <- paste(project_directory,"Experiment_10_Figure3_normalized/Fig.3_neg_rand_Power.txt",sep="")
FigS3_Comp_Type(df_Neg,'Ratio',outfile)

#Fig. S3A
filename <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_1.0/Comp_neg_simp_neg_1.0.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_1.0/Fig. S3A_1.txt",sep="")
FigS3_Comp_Type(df,'Num_Simp_Near_Ratio',outfile)
filename <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_2.0/Comp_neg_simp_neg_2.0.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_2.0/Fig. S3A_2.txt",sep="")
FigS3_Comp_Type(df,'Num_Simp_Near_Ratio',outfile)
filename <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_3.0/Comp_neg_simp_neg_3.0.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_3.0/Fig. S3A_3.txt",sep="")
FigS3_Comp_Type(df,'Num_Simp_Near_Ratio',outfile)
filename <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_4.0/Comp_neg_simp_neg_4.0.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- outfile <- paste(project_directory,"Fig. 3/Comp_Neg_simp_neg_4.0/Fig. S3A_4.txt",sep="")
FigS3_Comp_Type(df,'Num_Simp_Near_Ratio',outfile)

#Fig. S3B
filename <- paste("D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_1.0.csv")
df <- read.csv(filename)
outfile <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Fig. S3B_1.txt"
FigS3_Comp_Type(df,'Ratio',outfile)
filename <- paste("D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_2.0.csv")
df <- read.csv(filename)
outfile <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Fig. S3B_2.txt"
FigS3_Comp_Type(df,'Ratio',outfile)
filename <- paste("D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_3.0.csv")
df <- read.csv(filename)
outfile <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Fig. S3B_3.txt"
FigS3_Comp_Type(df,'Ratio',outfile)
filename <- paste("D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_4.0.csv")
df <- read.csv(filename)
outfile <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_8/8_3_CTBPos_SearchingRadius/Fig. S3B_4.txt"
FigS3_Comp_Type(df,'Ratio',outfile)

#Fig.S3C
filename <- paste(project_directory,"V7_Contain_all_raw/All_figure_Statistics/Fig. S_PosNeg_NegPos/Pos_Neg.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- paste(project_directory,"V7_Contain_all_raw/All_figure_Statistics/Fig. S_PosNeg_NegPos/Pos_Neg.txt",sep="")
FigS3_Comp_Type(df,'Ratio',outfile)
filename <- paste(project_directory,"V7_Contain_all_raw/All_figure_Statistics/Fig. S_PosNeg_NegPos/Neg_Pos.xlsx",sep="")
df <- read.xlsx(filename)
outfile <- paste(project_directory,"V7_Contain_all_raw/All_figure_Statistics/Fig. S_PosNeg_NegPos/Neg_Pos.txt",sep="")
FigS3_Comp_Type(df,'Ratio',outfile)