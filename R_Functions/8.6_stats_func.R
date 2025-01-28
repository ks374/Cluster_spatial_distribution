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

get_df_Orig <- function(df){
  return(df[df$Type=="Orig",])
}
get_df_Rand <- function(df){
  return(df[df$Type=="Rand",])
}

#Calculation func
Comp_CTB_at_each_Age_ANOVA <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  df_P2.aov <- aov(reformulate(groupname,yname),data=df_P2)
  print(summary(df_P2.aov))
  df_P4.aov <- aov(reformulate(groupname,yname),data=df_P4)
  print(summary(df_P4.aov))
  df_P8.aov <- aov(reformulate(groupname,yname),data=df_P8)
  print(summary(df_P8.aov))
}
Comp_CTB_at_each_Age_pairedT <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  if (groupname=="CTB"){
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
  if (groupname=="Type"){
    df_P2_Pos <- as.numeric(unlist(df_P2[df_P2$Type=='Orig',][yname]))
    df_P2_Neg <- as.numeric(unlist(df_P2[df_P2$Type=='Rand',][yname]))
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,alternative='greater',paired=TRUE)
    print(df_P2.t)
    df_P2.t <- t.test(df_P2_Pos,df_P2_Neg,paired=TRUE)
    print(df_P2.t)
    df_P4_Pos <- as.numeric(unlist(df_P4[df_P4$Type=='Orig',][yname]))
    df_P4_Neg <- as.numeric(unlist(df_P4[df_P4$Type=='Rand',][yname]))
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,alternative='greater',paired=TRUE)
    print(df_P4.t)
    df_P4.t <- t.test(df_P4_Pos,df_P4_Neg,paired=TRUE)
    print(df_P4.t)
    df_P8_Pos <- as.numeric(unlist(df_P8[df_P8$Type=='Orig',][yname]))
    df_P8_Neg <- as.numeric(unlist(df_P8[df_P8$Type=='Rand',][yname]))
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,alternative='greater',paired=TRUE)
    print(df_P8.t)
    df_P8.t <- t.test(df_P8_Pos,df_P8_Neg,paired=TRUE)
    print(df_P8.t)
  }
}
Comp_CTB_at_each_Age_conf_int <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  if (groupname=="CTB"){
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
  if (groupname=="Type"){
    df_P2_Pos <- as.numeric(unlist(df_P2[df_P2$Type=='Orig',][yname]))
    df_P2_Neg <- as.numeric(unlist(df_P2[df_P2$Type=='Rand',][yname]))
    df_P2_Pos.t <- t.test(df_P2_Pos)
    print("P2_Pos")
    print(df_P2_Pos.t$conf.int)
    df_P2_Neg.t <- t.test(df_P2_Neg)
    print("P2_Neg")
    print(df_P2_Neg.t$conf.int)
    df_P4_Pos <- as.numeric(unlist(df_P4[df_P4$Type=='Orig',][yname]))
    df_P4_Neg <- as.numeric(unlist(df_P4[df_P4$Type=='Rand',][yname]))
    df_P4_Pos.t <- t.test(df_P4_Pos)
    print("P4_Pos")
    print(df_P4_Pos.t$conf.int)
    df_P4_Neg.t <- t.test(df_P4_Neg)
    print("P4_Neg")
    print(df_P4_Neg.t$conf.int)
    df_P8_Pos <- as.numeric(unlist(df_P8[df_P8$Type=='Orig',][yname]))
    df_P8_Neg <- as.numeric(unlist(df_P8[df_P8$Type=='Rand',][yname]))
    print("P8_Pos")
    tryCatch({
      df_P8_Pos.t <- t.test(df_P8_Pos)
      print(df_P8_Pos.t$conf.int)
    }, error = function(e) {
      if (grepl("data are essentially constant", e$message)) {
        print("Error: Data are essentially constant. Skipping t-test.")
      } else {
        print(paste("Error: ", e$message))
      }
    })
    print("P8_Neg")
    tryCatch({
      df_P8_Neg.t <- t.test(df_P8_Neg)
      print(df_P8_Neg.t$conf.int)
    }, error = function(e) {
      if (grepl("data are essentially constant", e$message)) {
        print("Error: Data are essentially constant. Skipping t-test.")
      } else {
        print(paste("Error: ", e$message))
      }
    })
  }
}
Comp_CTB_at_each_Age <- function(df,yname,groupname){
  df_WT <- get_df_WT(df)
  df_B2 <- get_df_B2(df)
  print_title("Wild-type, ANOVA for all ages")
  Comp_CTB_at_each_Age_ANOVA(df_WT,yname,groupname)
  print_end()
  print_title("Wild-type, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_Age_pairedT(df_WT,yname,groupname)
  print_end()
  print_title("Wild-type, confidence interval for all ages")
  Comp_CTB_at_each_Age_conf_int(df_WT,yname,groupname)
  print_end()
  print_title("B2KO, ANOVA for all ages")
  Comp_CTB_at_each_Age_ANOVA(df_B2,yname,groupname)
  print_end()
  print_title("B2KO, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_Age_pairedT(df_B2,yname,groupname)
  print_end()
  print_title("B2KO, confidence interval for all ages")
  Comp_CTB_at_each_Age_conf_int(df_B2,yname,groupname)
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

get_AZ_of <- function(df,n_AZ){
  return(df[df['Index1']==n_AZ,])
}
Comp_CTB_at_each_AZ_ANOVA <- function(df,yname,groupname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  Comp_CTB_at_each_AZ_ANOVA_2(df_P2,yname,groupname)
  Comp_CTB_at_each_AZ_ANOVA_2(df_P4,yname,groupname)
  Comp_CTB_at_each_AZ_ANOVA_2(df_P8,yname,groupname)
}
Comp_CTB_at_each_AZ_ANOVA_2 <- function(df,yname,groupname){
  df_AZ1 <- get_AZ_of(df,1)
  df_AZ2 <- get_AZ_of(df,2)
  df_AZ3 <- get_AZ_of(df,3)
  df_AZ4 <- get_AZ_of(df,4)
  df_AZ1.aov <- aov(reformulate(groupname,yname),data=df_AZ1)
  print(summary(df_AZ1.aov))
  df_AZ2.aov <- aov(reformulate(groupname,yname),data=df_AZ2)
  print(summary(df_AZ2.aov))
  df_AZ3.aov <- aov(reformulate(groupname,yname),data=df_AZ3)
  print(summary(df_AZ3.aov))
  del_index <- c()
  for(i in 1:3){
    if (is.na(df_AZ4$Volume[i])){
      del_index <- c(del_index,i,(i+3))
    }
  }
  if (length(del_index)>0){
    if (length(del_index) == 6){
      print("AZ=4 dataframe is empty")
      return()
    } else {
      df_AZ4 <- df_AZ4[-del_index,]
    }
  }
  df_AZ4.aov <- aov(reformulate(groupname,yname),data=df_AZ4)
  print(summary(df_AZ4.aov))
}
Comp_CTB_at_each_AZ_pairedT <- function(df,yname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  Comp_CTB_at_each_AZ_pairedT_2(df_P2,yname)
  Comp_CTB_at_each_AZ_pairedT_2(df_P4,yname)
  Comp_CTB_at_each_AZ_pairedT_2(df_P8,yname)
}
Comp_CTB_at_each_AZ_pairedT_2 <- function(df,yname){
  df_AZ1 <- get_AZ_of(df,1)
  df_AZ2 <- get_AZ_of(df,2)
  df_AZ3 <- get_AZ_of(df,3)
  df_AZ4 <- get_AZ_of(df,4)
  df_AZ1_Pos <- as.numeric(unlist(df_AZ1[df_AZ1$CTB=='Pos',][yname]))
  df_AZ1_Neg <- as.numeric(unlist(df_AZ1[df_AZ1$CTB=='Neg',][yname]))
  df_AZ1.t <- t.test(df_AZ1_Pos,df_AZ1_Neg,alternative='greater',paired=TRUE)
  print(df_AZ1.t)
  df_AZ1.t <- t.test(df_AZ1_Pos,df_AZ1_Neg,paired=TRUE)
  print(df_AZ1.t)
  df_AZ2_Pos <- as.numeric(unlist(df_AZ2[df_AZ2$CTB=='Pos',][yname]))
  df_AZ2_Neg <- as.numeric(unlist(df_AZ2[df_AZ2$CTB=='Neg',][yname]))
  df_AZ2.t <- t.test(df_AZ2_Pos,df_AZ2_Neg,alternative='greater',paired=TRUE)
  print(df_AZ2.t)
  df_AZ2.t <- t.test(df_AZ2_Pos,df_AZ2_Neg,paired=TRUE)
  print(df_AZ2.t)
  df_AZ3_Pos <- as.numeric(unlist(df_AZ3[df_AZ3$CTB=='Pos',][yname]))
  df_AZ3_Neg <- as.numeric(unlist(df_AZ3[df_AZ3$CTB=='Neg',][yname]))
  df_AZ3.t <- t.test(df_AZ3_Pos,df_AZ3_Neg,alternative='greater',paired=TRUE)
  print(df_AZ3.t)
  df_AZ3.t <- t.test(df_AZ3_Pos,df_AZ3_Neg,paired=TRUE)
  print(df_AZ3.t)
  del_index <- c()
  for(i in 1:3){
    if (is.na(df_AZ4$Volume[i])){
      del_index <- c(del_index,i,(i+3))
    }
  }
  if (length(del_index)>0){
    if (length(del_index) == 6){
      print("AZ=4 dataframe is empty")
      return()
    } else {
      df_AZ4 <- df_AZ4[-del_index,]
    }
  }
  df_AZ4_Pos <- as.numeric(unlist(df_AZ4[df_AZ4$CTB=='Pos',][yname]))
  df_AZ4_Neg <- as.numeric(unlist(df_AZ4[df_AZ4$CTB=='Neg',][yname]))
  df_AZ4.t <- t.test(df_AZ4_Pos,df_AZ4_Neg,alternative='greater',paired=TRUE)
  print(df_AZ4.t)
  df_AZ4.t <- t.test(df_AZ4_Pos,df_AZ4_Neg,paired=TRUE)
  print(df_AZ4.t)
}
Comp_CTB_at_each_AZ_conf_int <- function(df,yname){
  df_P2 <- get_df_P2(df)
  df_P4 <- get_df_P4(df)
  df_P8 <- get_df_P8(df)
  #
  Comp_CTB_at_each_AZ_conf_int_2(df_P2,yname)
  Comp_CTB_at_each_AZ_conf_int_2(df_P4,yname)
  Comp_CTB_at_each_AZ_conf_int_2(df_P8,yname)
}
Comp_CTB_at_each_AZ_conf_int_2 <- function(df,yname){
  df_AZ1 <- get_AZ_of(df,1)
  df_AZ2 <- get_AZ_of(df,2)
  df_AZ3 <- get_AZ_of(df,3)
  df_AZ4 <- get_AZ_of(df,4)
  df_AZ1_Pos <- as.numeric(unlist(df_AZ1[df_AZ1$CTB=='Pos',][yname]))
  df_AZ1_Neg <- as.numeric(unlist(df_AZ1[df_AZ1$CTB=='Neg',][yname]))
  df_AZ1_Pos.t <- t.test(df_AZ1_Pos)
  print("AZ1_Pos")
  print(df_AZ1_Pos.t$conf.int)
  df_AZ1_Neg.t <- t.test(df_AZ1_Neg)
  print("AZ1_Neg")
  print(df_AZ1_Neg.t$conf.int)
  df_AZ2_Pos <- as.numeric(unlist(df_AZ2[df_AZ2$CTB=='Pos',][yname]))
  df_AZ2_Neg <- as.numeric(unlist(df_AZ2[df_AZ2$CTB=='Neg',][yname]))
  df_AZ2_Pos.t <- t.test(df_AZ2_Pos)
  print("AZ2_Pos")
  print(df_AZ2_Pos.t$conf.int)
  df_AZ2_Neg.t <- t.test(df_AZ2_Neg)
  print("AZ2_Neg")
  print(df_AZ2_Neg.t$conf.int)
  df_AZ3_Pos <- as.numeric(unlist(df_AZ3[df_AZ3$CTB=='Pos',][yname]))
  df_AZ3_Neg <- as.numeric(unlist(df_AZ3[df_AZ3$CTB=='Neg',][yname]))
  df_AZ3_Pos.t <- t.test(df_AZ3_Pos)
  print("AZ3_Pos")
  print(df_AZ3_Pos.t$conf.int)
  df_AZ3_Neg.t <- t.test(df_AZ3_Neg)
  print("AZ3_Neg")
  print(df_AZ3_Neg.t$conf.int)
  del_index <- c()
  for(i in 1:3){
    if (is.na(df_AZ4$Volume[i])){
      del_index <- c(del_index,i,(i+3))
    }
  }
  if (length(del_index)>0){
    if (length(del_index) == 6){
      print("AZ=4 dataframe is empty")
      return()
    } else {
      df_AZ4 <- df_AZ4[-del_index,]
    }
  }
  df_AZ4_Pos <- as.numeric(unlist(df_AZ4[df_AZ4$CTB=='Pos',][yname]))
  df_AZ4_Neg <- as.numeric(unlist(df_AZ4[df_AZ4$CTB=='Neg',][yname]))
  df_AZ4_Pos.t <- t.test(df_AZ4_Pos)
  print("AZ4_Pos")
  print(df_AZ4_Pos.t$conf.int)
  df_AZ4_Neg.t <- t.test(df_AZ4_Neg)
  print("AZ4_Neg")
  print(df_AZ4_Neg.t$conf.int)
}
Comp_CTB_at_each_AZ <- function(df,yname,groupname){
  df_WT <- get_df_WT(df)
  df_B2 <- get_df_B2(df)
  print_title("Wild-type, ANOVA for all ages")
  Comp_CTB_at_each_AZ_ANOVA(df_WT,yname,groupname)
  print_end()
  print_title("Wild-type, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_AZ_pairedT(df_WT,yname)
  print_end()
  print_title("Wild-type, confidence interval for all ages")
  Comp_CTB_at_each_AZ_conf_int(df_WT,yname)
  print_end()
  print_title("B2KO, ANOVA for all ages")
  Comp_CTB_at_each_AZ_ANOVA(df_B2,yname,groupname)
  print_end()
  print_title("B2KO, paired_t_test for all ages, 2-sided then greater")
  Comp_CTB_at_each_AZ_pairedT(df_B2,yname)
  print_end()
  print_title("B2KO, confidence interval for all ages")
  Comp_CTB_at_each_AZ_conf_int(df_B2,yname)
  print_end()
}


get_rid_of_rand <- function(df){
  return(df[(df$Type=='Multi_orig' | df$Type=='Singl_orig'),])
}