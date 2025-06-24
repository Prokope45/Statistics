
#Hypothesis test
mylm1 = lm(Rent~Sqft + Bed + Bath, data = Rent)
summary(mylm1)

#Confidence interval
#Regression output gives 76 degrees of freedom
#80 observations, 3 predictors, df = 80 - 3 - 1 = 76
alpha = 0.01
259.595 - qt(1-alpha/2,76)*90.631
259.595 + qt(1-alpha/2,76)*90.631


#Hypothesis test
mylm2 = lm(Spending2018 ~ Spending2017 + Income + HouseholdSize, data = Customers)
summary(mylm2)

