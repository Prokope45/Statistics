#Mean and standard deviation of 2018 spending by satisfaction level
aggregate(Customers$Spending2018, by = list(Customers$Satisfaction), mean)
aggregate(Customers$Spending2018, by = list(Customers$Satisfaction), sd)

#Subgroups by spending level
whichbigspend = which(Customers$Spending2018 > 1000)
whichsmallspend = which(Customers$Spending2018 <= 1000)

bigspend = Customers[whichbigspend,]
smallspend = Customers[whichsmallspend,]

#Look at proportion that attended college
prop.table(table(bigspend$College))
prop.table(table(smallspend$College))
