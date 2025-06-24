#Load in the forecast package
library(forecast)

#Load in the Inq Dataset

#Make the time series object, call it TaxTS
InqTS = ts(Inq$Inquiries)

#Exponential smoothing with alpha = 0.5
mod1 = HoltWinters(InqTS, alpha = .5, beta = FALSE, gamma = FALSE)

#Predict the next time period
mod1

#See the forecasts for time 2--time 30
mod1$fitted[,1]

#Plot the exponential series
plot(mod1)