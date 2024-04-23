library(readxl)
library(plyr)

inpath <- 'D:/Reaearch/Projects/Project_17_4_color_continue/Data/Experiment_5/Raw_Data/'
name_list = c('WTP2_A','WTP2_B','WTP2_C','WTP4_A','WTP4_B','WTP4_C','WTP8_A','WTP8_B','WTP8_C','B2P2_A','B2P2_B','B2P2_C','B2P4_A','B2P4_B','B2P4_C','B2P8_A','B2P8_B','B2P8_C')
outfile <- paste(inpath,'Reconstructed.csv',sep="")

infile <- paste(inpath,'Pos_pos.xlsx',sep="")
df <- read_excel(infile,sheet = "Reconstructed")

result_1 = matrix(0,18,2)

for (x in 1:18){
  df2 <- df[df$Name==name_list[x],]
  df2 <- na.omit(df2)
  df3 <- df2[df2$Num_near==0,]
  result_1[x,1] <- nrow(df3)/nrow(df2)
  df3 <- df2[df2$Num_near_rand==0,]
  result_1[x,2] <- as.numeric(nrow(df3))/as.numeric(nrow(df2))
}

infile <- paste(inpath,'Pos_neg.xlsx',sep="")
df <- read_excel(infile,sheet = "Reconstructed")

result_2 = matrix(0,18,2)

for (x in 1:18){
  df2 <- df[df$Name==name_list[x],]
  df2 <- na.omit(df2)
  df3 <- df2[df2$Num_near==0,]
  result_2[x,1] <- nrow(df3)/nrow(df2)
  df3 <- df2[df2$Num_near_rand==0,]
  result_2[x,2] <- as.numeric(nrow(df3))/as.numeric(nrow(df2))
}

infile <- paste(inpath,'Neg_neg.xlsx',sep="")
df <- read_excel(infile,sheet = "Reconstructed")

result_3 = matrix(0,18,2)

for (x in 1:18){
  df2 <- df[df$Name==name_list[x],]
  df2 <- na.omit(df2)
  df3 <- df2[df2$Num_near==0,]
  result_3[x,1] <- nrow(df3)/nrow(df2)
  df3 <- df2[df2$Num_near_rand==0,]
  result_3[x,2] <- as.numeric(nrow(df3))/as.numeric(nrow(df2))
}

infile <- paste(inpath,'Neg_pos.xlsx',sep="")
df <- read_excel(infile,sheet = "Reconstructed")

result_4 = matrix(0,18,2)

for (x in 1:18){
  df2 <- df[df$Name==name_list[x],]
  df2 <- na.omit(df2)
  df3 <- df2[df2$Num_near==0,]
  result_4[x,1] <- nrow(df3)/nrow(df2)
  df3 <- df2[df2$Num_near_rand==0,]
  result_4[x,2] <- as.numeric(nrow(df3))/as.numeric(nrow(df2))
}

result <- rbind(result_1,result_2,result_3,result_4)
write.csv(result,outfile)