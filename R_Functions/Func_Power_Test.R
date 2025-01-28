print_power_for_3pairs <- function(diff){
  mean_diff <- mean(diff)
  sd_diff <- sd(diff)
  d_paired <- mean_diff / sd_diff
  n <- 3
  power <- pwr.t.test(
    n = n,
    d = d_paired,
    sig.level = 0.05,
    type = "paired",
    alternative = "greater"
  )
  print(power)
}

get_CTB_diff <- function(df,varname){
  df_Pos <- get_df_Pos(df)
  df_Pos <- df_Pos[order(df_Pos$Sample),]
  df_Neg <- get_df_Neg(df)
  df_Neg <- df_Neg[order(df_Neg$Sample),]
  diff <- df_Pos[[varname]] - df_Neg[[varname]]
  return(diff)
}

Fig1_Comp_CTB <- function(df,varname,outfile){
  sink(fil=outfile)
  df_WT <- get_df_WT(df)
  print("---------------------------------")
  print("WT_P2")
  df_WT_P2 <- get_df_P2(df_WT)
  print_power_for_3pairs(get_CTB_diff(df_WT_P2,varname))
  print("---------------------------------")
  print("WT_P4")
  df_WT_P4 <- get_df_P4(df_WT)
  print_power_for_3pairs(get_CTB_diff(df_WT_P4,varname))
  print("---------------------------------")
  print("WT_P8")
  df_WT_P8 <- get_df_P8(df_WT)
  print_power_for_3pairs(get_CTB_diff(df_WT_P8,varname))
  df_B2 <- get_df_B2(df)
  print("---------------------------------")
  print("B2_P2")
  df_B2_P2 <- get_df_P2(df_B2)
  print_power_for_3pairs(get_CTB_diff(df_B2_P2,varname))
  print("---------------------------------")
  print("B2_P4")
  df_B2_P4 <- get_df_P4(df_B2)
  print_power_for_3pairs(get_CTB_diff(df_B2_P4,varname))
  print("---------------------------------")
  print("B2_P8")
  df_B2_P8 <- get_df_P8(df_B2)
  print_power_for_3pairs(get_CTB_diff(df_B2_P8,varname))
  sink(NULL)
}