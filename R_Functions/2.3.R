library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_Experiment_2.1.a.R")

base_folder <- paste(project_directory,"/Data/Experiment_2/2.3/",sep="")
inpath <- paste(base_folder,"Raw/",sep="")
outpath <- paste(base_folder,"R_Files/",sep="")

#Get 1vs 10 plots for each replicate. 
Name_list <- c('WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C',
               'WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C',
               'B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C')

filename <- paste(inpath,"Pos_multi.csv",sep="")
df_pos <- read.csv(filename)
filename <- paste(inpath,"Neg_multi.csv",sep="")
df_neg <- read.csv(filename)

#Get 1vs10 plots
plot_1vs10_batch(df_pos)
plot_1vs10_batch(df_neg)