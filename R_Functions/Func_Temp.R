get_power_from_mixedlinear_result <- function(diff,se,df){
    n<-df+1
    sd <- se*sqrt(n)
    d <- diff/sd
    pwr.t.test(d = d, n = n, sig.level = 0.05, type = "paired", alternative = "greater")
}
