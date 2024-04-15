#Summary function, used in almost all figures
data_summary <- function(data,varname,groupnames){
  require(plyr)
  summary_func <- function(x,col){
    sample_n <- nrow(x[col])
    if(sample_n>1){
      SE = sd(x[[col]],na.rm=TRUE)/sqrt(sample_n)
      alpha = 0.05
      DoF = sample_n - 1
      tscore = qt(p=alpha/2, df=DoF,lower.tail=FALSE)
      Merror = tscore * SE
      c(mean = mean(x[[col]],na.rm=TRUE), se = SE , Margin_error = Merror)
    }else{
      c(mean = mean(x[[col]],na.rm=TRUE), se = 0 , Margin_error = 0)
    }
  }
  data_sum <- ddply(data,groupnames,.fun=summary_func,varname)
  data_sum <- rename(data_sum,c("mean"=varname))
  return(data_sum)
}

#Experiment 2.1.a, Plot 3v3 linked dots. 
Plot_3v3_linked_dots <- function(filename,No_sample_name,outpath,yrange=c(0.0,0.4)){
  df <- read.csv(filename)
  df <- df[df$No_sample == No_sample_name,]
  df_orig <- df[df$Type == 'Orig',]
  df_rand <- df[df$Type == 'Rand',]
  df_rand <- data_summary(df_rand,'Ratio','Name')
  df_rand$No_sample <- substring(df_rand$Name,1,4)
  df_rand$Genotype <- substring(df_rand$Name,1,2)
  df_rand$Age <- substring(df_rand$Name,3,4)
  df_rand$Sample <- substring(df_rand$Name,6,6)
  df_rand$Type <- 'Rand'
  df_rand$Index <- 1
  df_rand <- subset(df_rand,select=-c(se,Margin_error))
  df_2 <- rbind(df_orig,df_rand)
  ggplot(data=df_2,aes(x=Type,y=Ratio)) + 
    geom_point(size=3) + 
    geom_line(aes(group = Sample)) + 
    coord_cartesian(ylim=yrange) +
    theme_classic()
  ggsave(paste(outpath,No_sample_name,'3v3LinkedDots.eps',sep=""))
  ggsave(paste(outpath,No_sample_name,'3v3LinkedDots.png',sep=""))
}
