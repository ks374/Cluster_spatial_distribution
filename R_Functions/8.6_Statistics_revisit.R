library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)
library(openxlsx)


#--------------------------------------------------------------------
#Fig. 1
{
  project_directory <- "E:/File/Work/2024/eLife manuscript/Experiment_10_Figure3_normalized/"
  Code_directory <- "E:/File/Work/2024/eLife manuscript/Cluster_spatial_distribution/R_Functions/"
  setwd(Code_directory)
  source("./Func_Def_basics.R")
  source("./8.6_stats_func.R")
  
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. 1/",sep="")
  filename <- paste(raw_folder,"Fig.1DEF.xlsx",sep="")
  df <- read_excel(filename)
  
  #Fig. 1E
  yname <- "Comp_V_Density"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.1E.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  #Fig. 1F
  yname <- "Ratio_Comp_V"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.1F.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  #Fig. S1B
  yname <- "Simp_V_Density"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.S1B.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
}

#Fig. 2C
{
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. 2/",sep="")
  filename <- paste(raw_folder,"Fig. 2C.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "B_Near_Comp"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.2C.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  #Fig. 2DE,S2
  filename <- paste(raw_folder,"Fig. 2DE.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Volume_um3"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.2 and S2, non average.txt")
  sink(file=outfile)
  Comp_CTB_at_each_AZ(df,yname,groupname)
  sink(NULL)
  yname <- "Ave_volume"
  groupname <- "CTB"
  outfile <- paste(raw_folder,"Fig.2 and S2, average.txt")
  sink(file=outfile)
  Comp_CTB_at_each_AZ(df,yname,groupname)
  sink(NULL)
}

#Fig.3 and S5
{
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. 3/Manual_Reorg/",sep="")
  filename <- paste(raw_folder,"Pos.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_pos.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  filename <- paste(raw_folder,"Neg.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_neg.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  #Manually change the function: from to_multi to Orig. 
  filename <- paste(raw_folder,"Pos_single.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_pos_single.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  filename <- paste(raw_folder,"Pos_multi.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_pos_multi.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  filename <- paste(raw_folder,"Neg_multi.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_neg_multi.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  filename <- paste(raw_folder,"Neg_single.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.3_neg_single.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
}

#Figure S3: 
{
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/",sep="")
  filename <- paste(raw_folder,"Pos_multi_1.0.csv",sep="")
  df <- read.csv(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_pospos_1.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  filename <- paste(raw_folder,"Pos_multi_2.0.csv",sep="")
  df <- read.csv(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_pospos_2.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  filename <- paste(raw_folder,"Pos_multi_3.0.csv",sep="")
  df <- read.csv(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_pospos_3.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  filename <- paste(raw_folder,"Pos_multi_4.0.csv",sep="")
  df <- read.csv(filename)
  yname <- "Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_pospos_4.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_Neg_simp_neg_1.0/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_negneg_1.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_Neg_simp_neg_2.0/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_negneg_2.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_Neg_simp_neg_3.0/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_negneg_3.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_Neg_simp_neg_4.0/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_negneg_4.0.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_neg_simp_pos_1.5/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_negpos_1.5.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. S3/Comp_pos_simp_neg_1.5/",sep="")
  filename <- paste(raw_folder,"Raw_Simp.xlsx",sep="")
  df <- read_excel(filename)
  yname <- "Num_Simp_Near_Ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"Fig.S3_posneg_1.5.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
}

#Figure S4: 
{
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig.S4/",sep="")
  filename <- paste(raw_folder,"S4.csv",sep="")
  df <- read.csv(filename)
  df<-df[df$CTB=='Pos',]
  yname <- "Clustered_ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"S4_pos.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
  
  raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig.S4/",sep="")
  filename <- paste(raw_folder,"S4.csv",sep="")
  df <- read.csv(filename)
  df<-df[df$CTB=='Neg',]
  yname <- "Clustered_ratio"
  groupname <- "Type"
  outfile <- paste(raw_folder,"S4_neg.txt")
  sink(file=outfile)
  Comp_CTB_at_each_Age(df,yname,groupname)
  sink(NULL)
}

