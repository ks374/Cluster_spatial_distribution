library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

Fig2_plotter <- function(df,outpath,filename){
  df_pos <- df[df["CTB"]=='Pos',]
  df_neg <- df[df["CTB"]=='Neg',]
  df_pos_2 <- data_summary(df_pos,'B_Near_Comp','Age')
  df_neg_2 <- data_summary(df_neg,'B_Near_Comp','Age')
  df_pos_2$CTB <- 'Pos'
  df_neg_2$CTB <- 'Neg'
  df_2 <- rbind(df_pos_2,df_neg_2)
  ggplot(data=df_2,aes(x=Age,y=B_Near_Comp,fill=factor(CTB,levels=c("Pos","Neg")))) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=B_Near_Comp-se,ymax=B_Near_Comp+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=Name),position=position_dodge(0.9)) +
    coord_cartesian(ylim=c(2.0,3.0)) +
    scale_y_continuous(expand = c(0,0)) +
    theme_classic()
  ggsave(path=outpath,filename=filename)
}
Fig2D_plotter <- function(df,outpath,filename,yscale){
  df_pos <- df[df["CTB"]=='Pos',]
  df_neg <- df[df["CTB"]=='Neg',]
  df_pos_2 <- data_summary(df_pos,'Volume_um3','Index1')
  df_neg_2 <- data_summary(df_neg,'Volume_um3','Index1')
  df_pos_2$CTB <- 'Pos'
  df_neg_2$CTB <- 'Neg'
  df_2 <- rbind(df_pos_2,df_neg_2)
  ggplot(data=df_2,aes(x=Index1,y=Volume_um3,fill=factor(CTB,levels=c("Pos","Neg")))) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=Volume_um3-se,ymax=Volume_um3+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=paste(Name,Index1)),position=position_dodge(0.9)) +
    coord_cartesian(ylim=yscale) +
    scale_y_continuous(expand = c(0,0)) +
    theme_classic()
  ggsave(path=outpath,filename=filename)
}
Fig2E_plotter <- function(df,outpath,filename,yscale){
  df_pos <- df[df["CTB"]=='Pos',]
  df_neg <- df[df["CTB"]=='Neg',]
  df_pos_2 <- data_summary(df_pos,'Ave_Size','Index1')
  df_neg_2 <- data_summary(df_neg,'Ave_Size','Index1')
  df_pos_2$CTB <- 'Pos'
  df_neg_2$CTB <- 'Neg'
  df_2 <- rbind(df_pos_2,df_neg_2)
  ggplot(data=df_2,aes(x=Index1,y=Ave_Size,fill=factor(CTB,levels=c("Pos","Neg")))) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=Ave_Size-se,ymax=Ave_Size+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=paste(Name,Index1)),position=position_dodge(0.9)) +
    coord_cartesian(ylim=yscale) +
    scale_y_continuous(expand = c(0,0)) +
    theme_classic()
  ggsave(path=outpath,filename=filename)
}

Fig1_plotter <- function(df,outpath,filename,yname,yscale){
  df_pos <- df[df["CTB"]=='Pos',]
  df_neg <- df[df["CTB"]=='Neg',]
  df_pos_2 <- data_summary(df_pos,yname,'Age')
  df_neg_2 <- data_summary(df_neg,yname,'Age')
  df_pos_2$CTB <- 'Pos'
  df_neg_2$CTB <- 'Neg'
  df_2 <- rbind(df_pos_2,df_neg_2)
  ggplot(data=df_2,aes(x=Age,y=!!sym(yname),fill=factor(CTB,levels=c("Pos","Neg")))) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=!!sym(yname)-se,ymax=!!sym(yname)+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=Name),position=position_dodge(0.9)) +
    coord_cartesian(ylim=yscale) +
    scale_y_continuous(expand = c(0,0)) +
    theme_classic()
  ggsave(path=outpath,filename=filename)
}

Fig3_plotter <- function(df,outpath,filename,yname,yscale){
  df_orig <- df[df["Type"]=='Orig',]
  df_rand <- df[df["Type"]=='Rand',]
  df_orig_2 <- data_summary(df_orig,yname,'Age')
  df_rand_2 <- data_summary(df_rand,yname,'Age')
  df_orig_2$Type <- 'Orig'
  df_rand_2$Type <- 'Rand'
  df_2 <- rbind(df_orig_2,df_rand_2)
  ggplot(data=df_2,aes(x=Age,y=!!sym(yname),fill=factor(Type,levels=c("Orig","Rand")))) +
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=!!sym(yname)-se,ymax=!!sym(yname)+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=Name),position=position_dodge(0.9)) +
    coord_cartesian(ylim=yscale) +
    scale_y_continuous(expand = c(0,0)) +
    theme_classic()
  ggsave(path=outpath,filename=filename)
}
  

project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_basics.R")

base_folder <- paste(project_directory,"First_submission_figure_data_stats/V7/All_figure_Statistics/",sep="")
inpath <- paste(base_folder,"Fig. 2/",sep="")
outpath <- paste(project_directory,"Data/Experiment_8/8_5_FigurewithDots/",sep="")

filename <- paste(inpath,"Fig. 2C.xlsx",sep="")
df <- read_excel(filename)
df_WT <- df[df['Genotype']=='WT',]
df_B2 <- df[df['Genotype']=='B2',]

Fig2_plotter(df_WT,outpath,"Fic2CWT.eps")
Fig2_plotter(df_WT,outpath,"Fic2CWT.png")
Fig2_plotter(df_B2,outpath,"Fic2CB2.eps")
Fig2_plotter(df_B2,outpath,"Fic2CB2.png")

#Fig2DE and supplemental: 
filename <- paste(inpath,"Fig. 2DE.xlsx",sep="")
df <- read_excel(filename)
df_WTP2 <- df[df['No_Sample']=='WTP2',]
df_WTP4 <- df[df['No_Sample']=='WTP4',]
df_WTP8 <- df[df['No_Sample']=='WTP8',]
df_B2P2 <- df[df['No_Sample']=='B2P2',]
df_B2P4 <- df[df['No_Sample']=='B2P4',]
df_B2P8 <- df[df['No_Sample']=='B2P8',]
Fig2D_plotter(df_WTP4,outpath,"Fig2D_WTP4.eps",c(0,0.15))
Fig2D_plotter(df_WTP4,outpath,"Fig2D_WTP4.png",c(0,0.15))
Fig2E_plotter(df_WTP4,outpath,"Fig2E_WTP4.eps",c(0,0.04))
Fig2E_plotter(df_WTP4,outpath,"Fig2E_WTP4.png",c(0,0.04))
Fig2D_plotter(df_B2P4,outpath,"Fig2D_B2P4.eps",c(0,0.15))
Fig2D_plotter(df_B2P4,outpath,"Fig2D_B2P4.png",c(0,0.15))
Fig2E_plotter(df_B2P4,outpath,"Fig2E_B2P4.eps",c(0,0.04))
Fig2E_plotter(df_B2P4,outpath,"Fig2E_B2P4.png",c(0,0.04))

Fig2D_plotter(df_WTP2,outpath,"FigS2A_WTP2.eps",c(0,0.15))
Fig2D_plotter(df_WTP2,outpath,"FigS2A_WTP2.png",c(0,0.15))
Fig2D_plotter(df_B2P2,outpath,"FigS2A_B2P2.eps",c(0,0.15))
Fig2D_plotter(df_B2P2,outpath,"FigS2A_B2P2.png",c(0,0.15))

Fig2D_plotter(df_WTP8,outpath,"FigS2B_WTP8.eps",c(0,0.4))
Fig2D_plotter(df_WTP8,outpath,"FigS2B_WTP8.png",c(0,0.4))
Fig2D_plotter(df_B2P8,outpath,"FigS2B_B2P8.eps",c(0,0.4))
Fig2D_plotter(df_B2P8,outpath,"FigS2B_B2P8.png",c(0,0.4))

Fig2E_plotter(df_WTP2,outpath,"FigS2C_WTP2.eps",c(0,0.09))
Fig2E_plotter(df_WTP2,outpath,"FigS2C_WTP2.png",c(0,0.09))
Fig2E_plotter(df_B2P2,outpath,"FigS2C_B2P2.eps",c(0,0.09))
Fig2E_plotter(df_B2P2,outpath,"FigS2C_B2P2.png",c(0,0.09))

Fig2E_plotter(df_WTP8,outpath,"FigS2D_WTP8.eps",c(0,0.09))
Fig2E_plotter(df_WTP8,outpath,"FigS2D_WTP8.png",c(0,0.09))
Fig2E_plotter(df_B2P8,outpath,"FigS2D_B2P8.eps",c(0,0.09))
Fig2E_plotter(df_B2P8,outpath,"FigS2D_B2P8.png",c(0,0.09))

#Figure 1 and S1: 
base_folder <- paste(project_directory,"First_submission_figure_data_stats/V7/All_figure_Statistics/",sep="")
inpath <- paste(base_folder,"Fig. 1/",sep="")
outpath <- paste(project_directory,"Data/Experiment_8/8_5_FigurewithDots/Fig.1/",sep="")

filename <- paste(inpath,"Fig.1DEF.xlsx",sep="")
df <- read_excel(filename)
df_WT <- df[df['Genotype']=='WT',]
df_B2 <- df[df['Genotype']=='B2',]

Fig1_plotter(df_WT,outpath,'Fig.1D_WT.eps','Comp_V_Density',c(0,0.048))
Fig1_plotter(df_WT,outpath,'Fig.1D_WT.png','Comp_V_Density',c(0,0.048))
Fig1_plotter(df_B2,outpath,'Fig.1D_B2.eps','Comp_V_Density',c(0,0.048))
Fig1_plotter(df_B2,outpath,'Fig.1D_B2.png','Comp_V_Density',c(0,0.048))

Fig1_plotter(df_WT,outpath,'Fig.1E_WT.eps','Ratio_Comp_V',c(0,0.43))
Fig1_plotter(df_WT,outpath,'Fig.1E_WT.png','Ratio_Comp_V',c(0,0.43))
Fig1_plotter(df_B2,outpath,'Fig.1E_B2.eps','Ratio_Comp_V',c(0,0.43))
Fig1_plotter(df_B2,outpath,'Fig.1E_B2.png','Ratio_Comp_V',c(0,0.43))

Fig1_plotter(df_WT,outpath,'Fig.S1_WT.eps','Simp_V_Density',c(0,0.088))
Fig1_plotter(df_WT,outpath,'Fig.S1_WT.png','Simp_V_Density',c(0,0.088))
Fig1_plotter(df_B2,outpath,'Fig.S1_B2.eps','Simp_V_Density',c(0,0.088))
Fig1_plotter(df_B2,outpath,'Fig.S1_B2.png','Simp_V_Density',c(0,0.088))

#Fig. 3 and 3 plus
base_folder <- paste(project_directory,"Archive/Archive_Data/CTB_specific/Fig. 3_Searching_radius/",sep="")
outpath <- paste(project_directory,"Data/Experiment_8/8_5_FigurewithDots/Fig.3/",sep="")

filename <- paste(base_folder,"Comp_Neg_simp_neg_1.0/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Neg_Neg_1.0.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Neg_1.0.png','Num_Simp_Near_Ratio',c(0,1))

filename <- paste(base_folder,"Comp_Neg_simp_neg_2.0/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Neg_Neg_2.0.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Neg_2.0.png','Num_Simp_Near_Ratio',c(0,1))

filename <- paste(base_folder,"Comp_Neg_simp_neg_3.0/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Neg_Neg_3.0.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Neg_3.0.png','Num_Simp_Near_Ratio',c(0,1))

filename <- paste(base_folder,"Comp_Neg_simp_neg_4.0/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Neg_Neg_4.0.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Neg_4.0.png','Num_Simp_Near_Ratio',c(0,1))

#Fig different CTB
filename <- paste(base_folder,"Comp_neg_simp_pos_1.5/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Neg_Pos_1.5_WT.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Pos_1.5_WT.png','Num_Simp_Near_Ratio',c(0,1))
df <- read_excel(filename)
df <- df[df$Genotype=='B2',]
Fig3_plotter(df,outpath,'Neg_Pos_1.5_B2.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Neg_Pos_1.5_B2.png','Num_Simp_Near_Ratio',c(0,1))
filename <- paste(base_folder,"Comp_pos_simp_neg_1.5/Raw_Simp.xlsx",sep="")
df <- read_excel(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Pos_Neg_1.5_WT.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Neg_1.5_WT.png','Num_Simp_Near_Ratio',c(0,1))
df <- read_excel(filename)
df <- df[df$Genotype=='B2',]
Fig3_plotter(df,outpath,'Pos_Neg_1.5_B2.eps','Num_Simp_Near_Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Neg_1.5_B2.png','Num_Simp_Near_Ratio',c(0,1))

#Fig.3plus: 
filename <- paste(project_directory,"Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_1.0.csv",sep="")
df <- read.csv(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Pos_Pos_1.0.eps','Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Pos_1.0.png','Ratio',c(0,1))
filename <- paste(project_directory,"Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_2.0.csv",sep="")
df <- read.csv(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Pos_Pos_2.0.eps','Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Pos_2.0.png','Ratio',c(0,1))
filename <- paste(project_directory,"Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_3.0.csv",sep="")
df <- read.csv(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Pos_Pos_3.0.eps','Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Pos_3.0.png','Ratio',c(0,1))
filename <- paste(project_directory,"Data/Experiment_8/8_3_CTBPos_SearchingRadius/Pos_multi_4.0.csv",sep="")
df <- read.csv(filename)
df <- df[df$Genotype=='WT',]
Fig3_plotter(df,outpath,'Pos_Pos_4.0.eps','Ratio',c(0,1))
Fig3_plotter(df,outpath,'Pos_Pos_4.0.png','Ratio',c(0,1))