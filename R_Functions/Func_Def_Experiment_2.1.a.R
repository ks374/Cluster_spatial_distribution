source("./Func_Def_basics.R")

#Experiment 2.1.a, 3Vs. 30 plot: 
get_3_vs_30_plot <- function(df){
  #Figure of sample size 3 vs. 30, error bar: CI. 
  df_WT <- df[df$Genotype == 'WT',]
  df_WT_Orig <- df_WT[df_WT$Type == 'Orig',]
  df_WT_Rand <- df_WT[df_WT$Type == 'Rand',]
  df_WT_Orig_2 <- data_summary(df_WT_Orig,'Ratio','Age')
  df_WT_Rand_2 <- data_summary(df_WT_Rand,'Ratio','Age')
  df_WT_Orig_2$Type = 'Orig'
  df_WT_Rand_2$Type = 'Rand'
  df_WT_2 <- rbind(df_WT_Orig_2,df_WT_Rand_2)
  
  level_order <- c('P2','P4','P8')
  
  ggplot(data=df_WT_2,aes(x=factor(Age,level=level_order),y=Ratio)) +
    geom_bar(aes(fill=Type),stat='identity',na.rm=TRUE,position=position_dodge(0.9)) + 
    geom_errorbar(aes(ymin=Ratio-Margin_error, ymax=Ratio+Margin_error,group=Type), width=.6,position=position_dodge(0.9)) + 
    geom_point(data=df_WT,aes(fill=Type),position=position_dodge(width=0.9),size = 2) +
    coord_cartesian(ylim=c(-0.1,0.7)) +
    theme_classic()
  ggsave(path = outpath,filename="Pos_multi_3vs30_CI.png")
  ggsave(path = outpath,filename="Pos_multi_3vs30_CI.eps")
}

#Experiment 2.1.a, 1vs10 plot for each replciate
get_single_replicate_1vs10 <- function(df,x,yrange=c(0,0.61)){
  df_2 <- data_summary(df,'Ratio','Type')
  
  ggplot(data = df_2,aes(x=Type,y=Ratio)) + 
    geom_bar(stat='identity') +
    geom_errorbar(aes(ymin=Ratio-SE,ymax=Ratio+SE),width = 0.5) + 
    geom_point(data = df) + 
    coord_cartesian(ylim=yrange) + 
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  ggsave(path = outpath,filename=paste(Name_list[x],".png",sep=""))
  ggsave(path = outpath,filename=paste(Name_list[x],".eps",sep=""))
}
plot_1vs10_batch <- function(df,yrange=c(0.0,0.61)){
  for (x in 1:18){
    df_replicate <- df[df$Name == Name_list[x],]
    get_single_replicate_1vs10(df_replicate,x,yrange)
  }
}

#Dataset colume expansion: From Name to No_sample, genotype, Age, and sample. 
get_Expanded_DF <- function(df){
  df_2<-df
  df_2$No_sample <- substring(df_2$Name,1,4)
  df_2$Genotype <- substring(df_2$Name,1,2)
  df_2$Age <- substring(df_2$Name,3,4)
  df_2$Sample <- substring(df_2$Name,6,6)
  return(df_2)
}
#Experiment 2.1.a, get an average value from all randomzied data
get_Random_Average <- function(df,target_variable_name,Group_name){
  df_orig <- df[df$Type == 'Orig',]
  df_rand <- df[df$Type == 'Rand',]
  df_rand <- data_summary(df_rand,target_variable_name,Group_name)
  df_rand <- get_Expanded_DF(df_rand)
  df_rand$Type <- 'Rand'
  df_rand$Index <- 1
  df_rand <- subset(df_rand,select=-c(se,Margin_error))
  df_2 <- rbind(df_orig,df_rand)
  return (df_2)
}

#Experiment 2.1.a, Plot 3v3 linked dots. 
Plot_3v3_linked_dots <- function(filename,No_sample_name,outpath,yrange=c(0.0,0.4)){
  df <- read.csv(filename)
  df <- df[df$No_sample == No_sample_name,]
  df_2 <- get_Random_Average(df,'Ratio','Name')
  ggplot(data=df_2,aes(x=Type,y=Ratio)) + 
    geom_point(size=3) + 
    geom_line(aes(group = Sample)) + 
    coord_cartesian(ylim=yrange) +
    theme_classic()
  ggsave(paste(outpath,No_sample_name,'.eps',sep=""))
  ggsave(paste(outpath,No_sample_name,'.png',sep=""))
}

#Experiment 2.1.a, get normalized clustering effect
get_norm_clustering_df <- function(df){
  df_2 <- get_Random_Average(df,'Ratio','Name')
  df_2_orig = df_2[df_2$Type == 'Orig',]
  df_2_rand = df_2[df_2$Type == 'Rand',]
  df_2_orig = df_2_orig[order(df_2_orig$Name),]
  df_2_rand = df_2_rand[order(df_2_rand$Name),]
  df_NE <- df_2_orig
  df_NE$Ratio <- df_2_orig$Ratio / df_2_rand$Ratio
  df_NE <- subset(df_NE,select=-Type)
}

#Experiment 2.1.a, plot normalized clustering effect
get_figure_norm_clustering_effect <- function (df,outpath,yrange=c(0,16.0)){
  df_multi <- df[df$Type == 'multi',]
  df_single <- df[df$Type == 'single',]
  df_multi_2 <- data_summary(df_multi,'Ratio','Age')
  df_multi_2$Type = 'multi'
  df_single_2 <- data_summary(df_single,'Ratio','Age')
  df_single_2$Type = 'single'
  df_2 <- rbind(df_single_2,df_multi_2)
  level_order <- c('P2','P4','P8')
  ggplot(data=df_2,aes(x=factor(Age,level=level_order),y=Ratio)) +
    geom_bar(aes(fill=Type),stat='identity',na.rm=TRUE,position=position_dodge(0.9)) + 
    geom_errorbar(aes(ymin=Ratio-se, ymax=Ratio+se,group=Type), width=.6,position=position_dodge(0.9)) + 
    geom_point(data=df,aes(fill=Type),position=position_dodge(width=0.9),size = 2) +
    geom_line(data=df,aes(group=Name),position=position_dodge(width=0.9)) +
    #scale_y_break(c(10,15)) +
    coord_cartesian(ylim=yrange) + scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  name_string <- deparse(substitute(df))
  name_string <- substring(name_string,4)
  ggsave(path = outpath,filename=paste(name_string,".eps",sep=""))
  ggsave(path = outpath,filename=paste(name_string,".png",sep=""))
}
barandpoints_3v3_plot <- function(filename,out_path,Sel_genotype,yrange){
  df <- read.csv(filename)
  df$Ratio <- as.numeric(df$Ratio)
  df <- df[df$Genotype==Sel_genotype,]
  df_Orig <- df[df$Type == 'Orig',]
  df_Orig <- subset(df_Orig,select=-c(Index))
  df_Rand <- df[df$Type == 'Rand',]
  df_Rand_2 <- data_summary(df_Rand,"Ratio","Name")
  df_Rand_2 <- subset(df_Rand_2, select = c(Name,Ratio))
  df_Rand_2$No_sample <- substring(df_Rand_2$Name,1,4)
  df_Rand_2$Genotype <- substring(df_Rand_2$Name,1,2)
  df_Rand_2$Age <- substring(df_Rand_2$Name,3,4)
  df_Rand_2$Sample <- substring(df_Rand_2$Name,6,6)
  df_Rand_2$Type <- "Rand"
  df <- rbind(df_Orig,df_Rand_2)
  df_Rand_2$No_sample <- substring(df_Rand_2$Name,1,4)
  df_Orig_2 <- data_summary(df_Orig,"Ratio","No_sample")
  df_Rand_2 <- data_summary(df_Rand_2,"Ratio","No_sample")
  df_Orig_2$Type <- "Orig"
  df_Rand_2$Type <- "Rand"
  df2 <- rbind(df_Orig_2,df_Rand_2)
  df2$Age <- substring(df2$No_sample,3,4)
  ggplot(data=df2,aes(x=Age,y=Ratio,fill=Type)) +
    geom_bar(stat='identity',na.rm=TRUE,position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=Ratio-Margin_error, ymax=Ratio+Margin_error), width=.3,position=position_dodge(0.9)) +
    geom_point(data=df,na.rm=TRUE,position=position_dodge(0.9)) +
    geom_line(data=df,aes(group=Name),na.rm=TRUE,position=position_dodge(0.9)) +
    coord_cartesian(ylim=yrange) + scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  name_string <- strsplit(filename,"/")
  name_string <- name_string[[1]]
  name_string <- name_string[length(name_string)]
  name_string <- paste(substring(name_string,1,5),"_",Sel_genotype,sep="")
  ggsave(path = out_path,filename=paste(name_string,".eps",sep=""))
  ggsave(path = out_path,filename=paste(name_string,".png",sep=""))
}
Experiment21a_ANOVA_single <- function(df,age){
  df_P <- df[df$Age == age,]
  df_P.aov <- aov(Ratio~Type,data=df_P)
  print(summary(df_P.aov))
}
Experiment21a_PairedT_single <- function(df,age){
  df_P <- df[df$Age == age,]
  df_P_multi <- df_P[df_P$Type=='multi',]$Ratio
  df_P_single <- df_P[df_P$Type=='single',]$Ratio
  df_P.t <- t.test(df_P_multi,df_P_single,alternative='greater',paired=TRUE)
  print(df_P.t)
  df_P.t <- t.test(df_P_multi,df_P_single,paired=TRUE)
  print(df_P.t)
}
Experiment21a_batch <- function(df){
  for (x in 1:3){
    #Result print order: Age[ANOVA,test_1side,test_2side]
    Experiment21a_ANOVA_single(df,Age_level[x])
    Experiment21a_PairedT_single(df,Age_level[x])
  }
}