get_norm_cumsum <- function(df,target){
  df_sort <- df[order(df[[target]]),]
  df_sort$cumsum <- cumsum(df_sort[[target]])
  df_sort$norm_cumsum <- df_sort$cumsum/max(df_sort$cumsum)
  return(df_sort)
}