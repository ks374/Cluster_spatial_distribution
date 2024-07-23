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

data_summary_med <- function(data,varname,groupnames){
  require(plyr)
  summary_func <- function(x,col){
    sample_n <- nrow(x[col])
    if(sample_n>1){
      SE = sd(x[[col]],na.rm=TRUE)/sqrt(sample_n)
      alpha = 0.05
      DoF = sample_n - 1
      tscore = qt(p=alpha/2, df=DoF,lower.tail=FALSE)
      Merror = tscore * SE
      c(mean = median(x[[col]],na.rm=TRUE), se = SE , Margin_error = Merror)
    }else{
      c(mean = median(x[[col]],na.rm=TRUE), se = 0 , Margin_error = 0)
    }
  }
  data_sum <- ddply(data,groupnames,.fun=summary_func,varname)
  data_sum <- rename(data_sum,c("mean"=varname))
  return(data_sum)
}
