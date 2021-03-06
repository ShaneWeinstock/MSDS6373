#Read in the bond data
xdf = read.csv("Data/10_year_bond_rate_2010-2015.csv",header = TRUE)

#Assuming this data comes from a stationary process, we can estimate the mean bond rate with the sample mean of all the bond rates in the sample
mean(xdf$Adj.Close)

#Estimating the Variance of a Stationary Series
x = as.numeric(paste(xdf$Adj.Close))
x = x[!is.na(x)]
n=length(x) #n = 1509
nlag=n-1 #n-1
m=mean(x)
v=var(x,na.rm = TRUE)
gamma0=var(x)*(n-1)/n
aut=acf(x,lag.max=nlag) #n-1
sum=0
for (k in 1:nlag) {sum=sum+(1-k/n)*aut$acf[k+1]*gamma0}
vxbar=2*sum/n+gamma0/n #note the mult of sum by 2
vxbar

#95% Confidence Intervals
MOE = 1.96*sqrt(vxbar) #Margen of error
LL = mean(xdf$Adj.Close) - MOE
UL = mean(xdf$Adj.Close) + MOE
#We are 95% confidence that the mean bond rate is contained in the interval
LL
UL

plot.ts(xdf$Adj.Close, col = "blue",lwd=2,lty=1, main="TIME SERIES PLOT OF bond data",cex.main=1)

#Augmented Dickey-Fuller Test
adf.test(xdf$Adj.Close)

acf(xdf$Adj.Close)
acf(xdf$Adj.Close[1:750])
acf(xdf$Adj.Close[751:1509])
