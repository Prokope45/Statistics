#Load in the forecast package
library(forecast)

#Load in Inq Data as a Time Series
InqTS = ts(Inq$Inquiries)

#Plot the time series
plot(InqTS, xlab = "Week", ylab = "Number of Inquiries", main = "Number of Inquiries made over time")

#Fit a forecasting model using only increasing/decreasing trend over time
mytslm = tslm(InqTS ~ trend)
summary(mytslm)

#Forecast for the 3 weeks after the current data.
forecast(mytslm, h = 3)

#What if we only predicted using the first 25 weeks.
#And we want to see how good our predictions are for the next five weeks.

#Window function()
InqTSW = window(InqTS, start = 1, end = 25)
InqTSWO = window(InqTS, start = 26, end = 30)

#Fit a forecasting model to first 25 observations using only increasing/decreasing trend over time
mytslmw = tslm(InqTSW ~ trend)
summary(mytslmw)

#Forecast for the weeks 26--30
myfore = forecast(mytslmw, h = length(InqTSWO))
myfore

#Mean Square Error
#Forecasting errors
errors = InqTSWO - myfore$mean
mse = mean(errors^2)
mse

#Load in TaxRevenue
#Make it a time series object
TaxTS = ts(TaxRevenue$Revenue, start = c(14,2), end = c(18,10), frequency = 12)
plot(TaxTS, xlab = "Year", ylab = "Tax Revenue", main = "Tax Revenue over time")

#One model: Just linear trend
justlin = tslm(TaxTS ~ trend)
summary(justlin)

#Another model: Also consider seasonal trend
withseas = tslm(TaxTS ~ trend + season)
summary(withseas)

#Make windows
TaxTSW = window(TaxTS, start = c(14,2), end = c(17,12))
TaxTSWO = window(TaxTS, start = c(18,1), end = c(18,10))

#One model: Just linear trend
justlinw = tslm(TaxTSW ~ trend)
summary(justlinw)

#Another model: Also consider seasonal trend
withseasw = tslm(TaxTSW ~ trend + season)
summary(withseasw)


#Forecast using the linear model
justlinf = forecast(justlinw, h = length(TaxTSWO))
justlinmean = justlinf$mean

#Compute mean square error
justlinerrs = TaxTSWO - justlinmean
linmse = mean(justlinerrs^2)

#Forecast using the seasonal trend
withseasf = forecast(withseasw, h = length(TaxTSWO))
withseasmean = withseasf$mean

#Compute mean square error
withseaserrs = TaxTSWO - withseasmean
withmse = mean(withseaserrs^2)

#Comparison
#Linear
linmse
#Seasonal
withmse

#Conclude that just the linear trend leads to a better forecast
#Get our final model as:
finmod = tslm(TaxTS ~ trend)

#Predict for next 14 months for budgeting purposes
forecast(finmod, h = 14)
