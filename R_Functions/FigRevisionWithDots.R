library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

Fig2_plotter <- function(df,outfile){
  df_pos <- df[df["CTB"]=='Pos',]
  df_neg <- df[df["CTB"]=='Neg',]
  df_pos_2 <- data_summary(df_pos,B_Near_Comp,Age)
  df_neg_2 <- data_summary(df_neg,B_Near_Comp,Age)
  df_2 <- rbind(df_pos_2,df_neg_2)
  ggplot(data=df_2,aes(x=Age,y=B_Near_Comp,fill=CTB)) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    #geom_errorbar(aes(ymin=Clustered_ratio-se,ymax=Clustered_ratio+se),width=.5,position=position_dodge(0.9)) +
    #geom_point(data=df,position=position_dodge(0.9)) + 
    #geom_line(data=df,aes(group=Name),position=position_dodge(0.9)) +
    #coord_cartesian(ylim=c(0.0,1.0)) +
    #scale_y_continuous(expand = c(0, 0)) +
    #theme_classic()
}
  

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_basics.R")

base_folder <- paste(project_directory,"/First_submission_figure_data_stats/V7/All_figure_Statistics/",sep="")
inpath <- paste(base_folder,"Fig. 2/",sep="")
outpath <- paste(base_folder,"Data/Experiment_8/8_5_FigurewithDots/",sep="")



filename <- paste(inpath,"Fig. 2C.xlsx",sep="")
df <- read_excel(filename)
df_WT <- df[df['Genotype']=='WT',]
df_B2 <- df[df['Genotype']=='B2',]

outfile_WT1 <- paste(outpath,"Fig2CWT.eps",sep="")
outfile_WT1 <- paste(outpath,"Fig2CWT.eps",sep="")
outfile_WT1 <- paste(outpath,"Fig2CWT.eps",sep="")
outfile_WT1 <- paste(outpath,"Fig2CWT.eps",sep="")