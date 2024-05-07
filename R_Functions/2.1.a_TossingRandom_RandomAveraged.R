setwd("D:/Research/Projects/Project_17_4_color_continue/Cluster_spatial_distribution/R_Functions/")
library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)
source("./Func_Def_Experiment_2.1.a.R")

base_folder <- "D:/Research/Projects/Project_17_4_color_continue/Data/Experiment_2/1a_Direct_ratio_comp/"
inpath <- paste(base_folder,"Raw/",sep="")
outpath <- paste(base_folder,"R_Files/",sep="")
Name_list <- c('WTP2','WTP4','WTP8','B2P2','B2P4','B2P8')

#Dot-dot replicate comparison. 
filename <- paste(inpath,"Pos_multi.csv",sep="");
out_path <- paste(outpath,"3v3LinkedDots/",sep="");
for (x in 1:6){
  Plot_3v3_linked_dots(filename,Name_list[x],out_path,yrange=c(0.0,1.0))
}

#Bar plots with data points: 
out_path <- paste(outpath,"3v3LinkedDots/",sep="");
yrange <- c(-0.2,1)

filename <- paste(inpath,"Pos_multi.csv",sep="");
Sel_genotype <- "WT"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
Sel_genotype <- "B2"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
filename <- paste(inpath,"Neg_multi.csv",sep="");
Sel_genotype <- "WT"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
Sel_genotype <- "B2"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
filename <- paste(inpath,"Pos_single.csv",sep="");
Sel_genotype <- "WT"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
Sel_genotype <- "B2"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
filename <- paste(inpath,"Neg_single.csv",sep="");
Sel_genotype <- "WT"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)
Sel_genotype <- "B2"
barandpoints_3v3_plot(filename,out_path,Sel_genotype,yrange)