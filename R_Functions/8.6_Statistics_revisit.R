library(readxl)
library(ggplot2)
library(ggdist)
library(plyr)

#--------------------------------------------------------------------
#Functions: 
#Utility func
get_df_WT <- function(df){
  return(df[df$Genotype=="WT",])
}
get_df_B2 <- function(df){
  return(df[df$Genotype=="B2",])
}
get_df_Pos <- function(df){
  return(df[df$CTB=="Pos",])
}
get_df_Neg <- function(df){
  return(df[df$CTB=="Neg",])
}
get_df_P2 <- function(df){
  return(df[df$Age=="P2",])
}
get_df_P4 <- function(df){
  return(df[df$Age=="P4",])
}
get_df_P8 <- function(df){
  return(df[df$Age=="P8",])
}
#Calculation func
Comp_CTB_at_each_Age_ANOVA <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df_WT)
  df_P4 <- get_df_P4(df_WT)
  df_P8 <- get_df_P8(df_WT)
  #
  df_P2.aov <- aov(reformulate(groupname,yname),data=df_P2)
  print(summary(df_P2.aov))
  df_P4.aov <- aov(reformulate(groupname,yname),data=df_P4)
  print(summary(df_P4.aov))
  df_P8.aov <- aov(reformulate(groupname,yname),data=df_P8)
  print(summary(df_P8.aov))
}
Comp_CTB_at_each_Age_pairedT <- function(df,yname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
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
Comp_CTB_at_each_Age_conf_int <- function(df,yname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  df_P2_Pos <- as.numeric(unlist(df_P2[df_P2$CTB=='Pos',][yname]))
  df_P2_Neg <- as.numeric(unlist(df_P2[df_P2$CTB=='Neg',][yname]))
  df_P2_Pos.t <- t.test(df_P2_Pos)
  print("P2_Pos")
  print(df_P2_Pos.t$conf.int)
  df_P2_Neg.t <- t.test(df_P2_Neg)
  print("P2_Neg")
  print(df_P2_Neg.t$conf.int)
  df_P4_Pos <- as.numeric(unlist(df_P4[df_P4$CTB=='Pos',][yname]))
  df_P4_Neg <- as.numeric(unlist(df_P4[df_P4$CTB=='Neg',][yname]))
  df_P4_Pos.t <- t.test(df_P4_Pos)
  print("P4_Pos")
  print(df_P4_Pos.t$conf.int)
  df_P4_Neg.t <- t.test(df_P4_Neg)
  print("P4_Neg")
  print(df_P4_Neg.t$conf.int)
  df_P8_Pos <- as.numeric(unlist(df_P8[df_P8$CTB=='Pos',][yname]))
  df_P8_Neg <- as.numeric(unlist(df_P8[df_P8$CTB=='Neg',][yname]))
  df_P8_Pos.t <- t.test(df_P8_Pos)
  print("P8_Pos")
  print(df_P8_Pos.t$conf.int)
  df_P8_Neg.t <- t.test(df_P8_Neg)
  print("P8_Neg")
  print(df_P8_Neg.t$conf.int)
}
Comp_CTB_at_each_Age <- function(df,yname,groupname){
  df_WT <- get_df_WT(df)
  df_B2 <- get_df_B2(df)
  print_title("Wild-type, ANOVA for all ages")
  Comp_CTB_at_each_Age_ANOVA(df_WT,yname,groupname)
  print_end()
  print_title("Wild-type, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_Age_pairedT(df_WT,yname)
  print_end()
  print_title("Wild-type, confidence interval for all ages")
  Comp_CTB_at_each_Age_conf_int(df_WT,yname)
  print_end()
  print_title("B2KO, ANOVA for all ages")
  Comp_CTB_at_each_Age_ANOVA(df_B2,yname,groupname)
  print_end()
  print_title("B2KO, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_Age_pairedT(df_B2,yname)
  print_end()
  print_title("B2KO, confidence interval for all ages")
  Comp_CTB_at_each_Age_conf_int(df_B2,yname)
  print_end()
}
#Print_Utility Func
print_title <- function(stri){
  print(stri)
  print("---------")
}
print_end <- function(){
  print("---------")
  print("")
  print("")
  print("")
}

#--------------------------------------------------------------------
#Fig. 1
project_directory <- "D:/Research/Projects/Project_17_4_color_continue/"
Code_directory <- paste(project_directory,"Cluster_spatial_distribution/R_Functions/",sep="")
setwd(Code_directory)
source("./Func_Def_basics.R")

raw_folder <- paste(project_directory,"Data/Experiment_8/8_6_Statistics/Fig. 1/",sep="")
filename <- paste(raw_folder,"Fig.1DEF.xlsx",sep="")
df <- read_excel(filename)

#Fig. 1E
yname <- "Comp_V_Density"
groupname <- "CTB"
outfile <- paste(raw_folder,"Fig.1E.txt")
sink(file=outfile)
Comp_CTB_at_each_Age(df,"Comp_V_Density","CTB")
sink(NULL)