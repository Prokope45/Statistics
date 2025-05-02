Customers <- read.csv("Recitations/Recitation 7/Customers.csv")
Admissions <- read.csv("Recitations/Recitation 7/Admissions.csv")

#Two ways of getting sample proportion of Very Satisfied Customers
#Way 1: Use prop.table on a table of Satisfaction
prop.table(table(Customers$Satisfaction))

#Very satisfied is the 5th entry
verysatprop1 = prop.table(table(Customers$Satisfaction))[5]

#Way 2: Use boolean expressions
verysatprop2 = mean(Customers$Satisfaction == "Very Satisfied")

#95% Confidence interval for percentage of "Very Satisfied Customers
#The sample proportion already computed.  Still need n
verysatn = length(Customers$Satisfaction)

#Find 1- alpha/2
verysatalpha = 1 - .95
1- verysatalpha/2

#Find normal quantile.  df = mynspend - 1
verysatqz = qnorm(1-verysatalpha/2, mean = 0, sd = 1)

#Find confidence interval
#Left endpoint
verysatprop1 - verysatqz*sqrt(verysatprop1*(1-verysatprop1)/verysatn)

#Right endpoint
verysatprop1 + verysatqz*sqrt(verysatprop1*(1-verysatprop1)/verysatn)

#Two ways of getting sample proportion of individualsthat spent more than 1000 in 2018
#Way one, using ifelse and prop.table
mt1000 = ifelse(Customers$Spending2018 > 1000, "Yes", "No")
prop.table(table(mt1000))

#Yes is the 2nd entry
mt1000prop1 = prop.table(table(mt1000))[2]

#Way two, boolean expressions plus mean()
mt1000prop2 = mean(Customers$Spending2018 > 1000)

#90% Confidence interval for percentage of customers that spento mre than 1000
#The sample proportion already computed.  Still need n
mt1000n = length(Customers$Spending2018)

#Find 1- alpha/2
mt1000alpha = 1 - .90
1- mt1000alpha/2

#Find normal quantile.  df = mynspend - 1
mt1000qz = qnorm(1-mt1000alpha/2, mean = 0, sd = 1)

#Find confidence interval
#Left endpoint
mt1000prop1 - mt1000qz*sqrt(mt1000prop1*(1-mt1000prop1)/mt1000n)

#Right endpoint
mt1000prop1 + mt1000qz*sqrt(mt1000prop1*(1-mt1000prop1)/mt1000n)

#16
mymeanw = 12.5
mysdw = 9.2
mynw = 18

alpha = 0.05
1-alpha/2

myqtw = qt(1-alpha/2, df = mynw - 1)

#Margin of error
moew = myqtw*mysdw/sqrt(mynw)

#95% CI
#Left endpoint
mymeanw - moew

#Right endpoint
mymeanw + moew

#Most natural way to decrease margin of error is to increase sample size 

#30
mypj = 0.37
mynj = 5324

alpha = 0.1
1-alpha/2

myqzj = qnorm(1-alpha/2)

#Left Endpoint
mypj - myqzj*sqrt(mypj*(1-mypj)/mynj)


#Right Endpoint
mypj + myqzj*sqrt(mypj*(1-mypj)/mynj)
