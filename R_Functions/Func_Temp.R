get_power_from_mixedlinear_result <- function(diff,se,df){
    n<-df+1
    sd <- se*sqrt(n)
    d <- diff/sd
    pwr.t.test(d = d, n = n, sig.level = 0.05, type = "paired", alternative = "greater")
}

KS_Power_test <- function(statistics,N){
  d = statistics/(N-1)
  print(d)
  pwr.anova.test(
    k = 2,
    n = N,
    f = sqrt(d/(1-d)),
    sig.level = 0.05
  )
}