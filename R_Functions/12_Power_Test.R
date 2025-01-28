library(ggplot2)
library(pwr)
library(plyr)
library(openxlsx)

setwd("E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/")
source("./Func_Def_basics.R")
source("./8.6_stats_func.R")
source("./Func_Power_Test.R")

project_directory <- "E:/File/Work/2024/eLife manuscript/Data/V7_Contain_all_raw/All_figure_Statistics/Fig. 1/"
filename <- paste(project_directory,"Fig.1DEF.xlsx",sep="")
outfile <- paste(project_directory,"Fig.1E_Power.txt",sep="")

df <- read.xlsx(filename)
Fig1_Comp_CTB(df,'Comp_V_Density',outfile)