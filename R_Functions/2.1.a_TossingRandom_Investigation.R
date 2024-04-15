library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(code_directory)
source("./Func_Def_Experiment_2.1.a.R")
base_folder <- paste(project_directory,"Data/Experiment_2/1a_Direct_ratio_comp/",sep="")
inpath <- paste(base_folder,"Raw/",sep="")
outpath <- paste(base_folder,"R_Files/",sep="")

#3 vs. 30 plot
filename <- paste(inpath,"Neg_multi.csv",sep="")
df <- read.csv(filename)
#get_3_vs_30_plot(df)

#Comparison of an individual replicate:
outpath <- paste(base_folder,"R_Files/1vs10Plots/",sep="")
Name_list <- c('WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C',
               'WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C',
               'B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C')
plot_1vs10_batch(read.csv(paste(inpath,"Neg_single.csv",sep="")),yrange=c(0.0,1.0))