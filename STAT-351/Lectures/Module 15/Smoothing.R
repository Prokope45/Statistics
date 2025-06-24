#Load in the forecast package
library(forecast)

#Load in the TaxRevenue package

#Make the time series object, call it TaxTS
TaxTS = ts(TaxRevenue$Revenue, start = c(14,2), end = c(18,10), frequency = 12)

#Take a moving average of 5 observations
myma = ma(TaxTS, order = 5)
plot(TaxTS, lwd = 2, ylab = "Revenue",
     main = "Revenue over time.\nBlack = Time Series\nPurple = Order 5 moving average")
lines(myma, lwd = 2, col = "purple")

#Take a moving average of 4 observations
myma2 = ma(TaxTS, order = 4, centre = FALSE)

#Use the last prediction to forecast for Nov 2018
myma2

#The forecast is 23,092,168
#Take a moving average of 5 observations
myma = ma(TaxTS, order = 5)
plot(TaxTS, main = "Moving average is purple")
lines(myma, lwd = 2, col = "purple")