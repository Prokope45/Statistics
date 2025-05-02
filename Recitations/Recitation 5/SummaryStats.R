#Load in data
mydata = c(8, 5, 6, 7, 13, 4, 5, 1, 11, 14, 18, 6)

#The summary statistics

#Mean
mean(mydata)

#Median
median(mydata)

#Variance
var(mydata)

#Standard deviation
sd(mydata)

#Inter-quartile range
IQR(mydata)

#Range
diff(range(mydata))

#40th percentile (or quantile)
quantile(mydata, 0.40)

#Covariance and correlation
x = c(1, 5, 6, 7, 3, 4)
y = c(1, 7, 9, 8, 4, 8)

#Covariance
cov(x,y)

#Correlation
cor(x,y)

#Compute the same for the 2018 spending data for Customers2 dataset
#There are outliers, so set na.rm = TRUE

#Mean
mean(Customers2$Spending2018, na.rm = TRUE)

#Median
median(Customers2$Spending2018, na.rm = TRUE)

#Variance
var(Customers2$Spending2018, na.rm = TRUE)

#Standard deviation
sd(Customers2$Spending2018, na.rm = TRUE)

#Inter-quartile range
IQR(Customers2$Spending2018, na.rm = TRUE)

#Range
diff(range(Customers2$Spending2018, na.rm = TRUE))

#40th percentile (or quantile)
quantile(Customers2$Spending2018, 0.40, na.rm = TRUE)

#Compute covariance and correlation.  
#There are missing observations, so set use = "complete.obs"

#Covariance
cov(Customers2$Spending2017, Customers2$Spending2018, use = "complete.obs")

#Correlation
cor(Customers2$Spending2017, Customers2$Spending2018, use = "complete.obs")

#Box plot of 2018 spending across customer satisfaction
boxplot(Customers2$Spending2018~Customers2$Satisfaction)
