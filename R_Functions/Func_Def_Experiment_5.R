source("./Func_Def_basics.R")

Exp5_plot <- function(df,outpath){
  df_orig <- df[df$Type=='Orig',]
  df_rand <- df[df$Type=='Rand',]
  df_orig_2 <- data_summary(df_orig,'Clustered_ratio','Age')
  df_rand_2 <- data_summary(df_rand,'Clustered_ratio','Age')
  df_orig_2$Type <- 'Orig'
  df_rand_2$Type <- 'Rand'
  df_2 <- rbind(df_orig_2,df_rand_2)
  ggplot(data=df_2,aes(x=Age,y=Clustered_ratio,fill=Type)) + 
    geom_bar(stat='identity',position=position_dodge(0.9)) +
    geom_errorbar(aes(ymin=Clustered_ratio-se,ymax=Clustered_ratio+se),width=.5,position=position_dodge(0.9)) +
    geom_point(data=df,position=position_dodge(0.9)) + 
    geom_line(data=df,aes(group=Name),position=position_dodge(0.9)) +
    coord_cartesian(ylim=c(0.0,1.0)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()
  name_string <- deparse(substitute(df))
  ggsave(path = outpath,filename=paste(name_string,".eps",sep=""))
  ggsave(path = outpath,filename=paste(name_string,".png",sep=""))
}