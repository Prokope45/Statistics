Customers <- read.csv("Recitations/Recitation 12/Customers.csv")
View(Customers)
#Form as good of a model as possible that can predict Spending in 2018.

#Start with Sex, Race, College, HouseholdSize, 
#Income, Spending2017, Satisfaction, Channel, and three interaction terms:
#Income*Spending2017, Satisfaction*Spending2017, College*Spending2017

mod1 = lm(Spending2018 ~ Sex + Race + College + HouseholdSize +
            Income + Spending2017 + College + Satisfaction + Channel +
            I(Income*Spending2017) + Satisfaction*Spending2017 +
            College*Spending2017,
          data = Customers)

#Look at summary
summary(mod1)

#Adjusted R-Squared: 0.7058

#Things that look important:
#Spending 2017, Race.
#Things that don't: Channel, Household size, Income*Spending2017


#Fit another model removing Channel, Household Size, and Income*Spending2017
mod2 = lm(Spending2018 ~ Sex + Race + College + 
            Income + Spending2017 + Satisfaction +
            Satisfaction*Spending2017 + College*Spending2017  ,
          data = Customers)

summary(mod2)

#Adjusted R-Squared: 0.713.  Better than Model 1.
#Next candidates for removal:  Satisfaction, Spending2017*Satisfaction, Income

#Try a residual plot: We know that incomes tend to be right-skewed
#Do we see this here?

plot(Customers$Income, mod2$residuals, xlab = "Income", ylab = "Residuals", 
     main = "Plot of residuals against income", pch = 16)
abline(0,0)

#There may be some heteroskedasticity: Residuals get smaller as incomes get bigger
#What happens if we replace income with log(income)?

mod3 = lm(Spending2018 ~ Sex + Race + College + 
            I(log(Income)) +Spending2017 + Satisfaction +
            Satisfaction*Spending2017 + College*Spending2017,
          data = Customers)

summary(mod3)

#Adjusted R-Squared: 0.7135, provides a better fit
#Let's check the residual plot

plot(log(Customers$Income), mod3$residuals, xlab = "log(Income)", ylab = "Residuals", 
     main = "Plot of residuals against income", pch = 16)
abline(0,0)

#Plot looks slightly better!

#What happens if we remove satisfaction and Spending2017*Satisfaction from the model?
mod4 = lm(Spending2018 ~ Sex + Race + College + 
            I(log(Income)) + Spending2017 + College*Spending2017,
          data = Customers)

summary(mod4)

#Adjusted R-Squared: 0.7165.  Slightly better model!

#What happens if we remove log Income?
mod5 = lm(Spending2018 ~ Sex + Race + College + Spending2017 + College*Spending2017,
          data = Customers)

summary(mod5)

#Adjusted R-Squared: 0.7159.  Slightly worse model!

#Now check residuals for model misspecification

#Perform a residual plot of residuals against Spending2017
plot(Customers$Spending2017, mod4$residuals, xlab = "2017 Spending", ylab = "Residuals", 
     main = "Plot of residuals against 2017 Spending", pch = 16)
abline(0,0)

#Looks like a quadratic trend.  What happens if we add in Spending Squared?
mod6 = lm(Spending2018 ~ Sex + Race + Spending2017 + I(Spending2017^2) + 
            +  I(log(Income))  + College +  College*Spending2017,
          data = Customers)

summary(mod6)
#R-Squared: 0.7773.  A much better model.  

#Let's consider removing log(Income) again now that we have Spending^2 in the model
mod7 = lm(Spending2018 ~ Sex + Race + Spending2017 + I(Spending2017^2) + 
            + College +  College*Spending2017,
          data = Customers)

summary(mod7)
#R-Squared: 0.7784.  A slightly better fit.

#Finally, let's see what happens when we remove Sex from our model
mod8 = lm(Spending2018 ~ Race + Spending2017 + I(Spending2017^2) + 
            + College +  College*Spending2017,
          data = Customers)

summary(mod8)
#R-Squared: 0.7786.  A slightly better fit.


#Let's check residuals against 2017 spending and against fitted values.
plot(Customers$Spending2017, mod8$residuals, pch = 16, xlab = "log(Income)", ylab = "Residuals", 
     main = "Plot of residuals against income")
abline(0,0)

plot(mod8$fitted.values, mod8$residuals, pch = 16, xlab = "log(Income)", ylab = "Residuals", 
     main = "Plot of residuals against income")
abline(0,0)

#Not perfect, but much better.


#Model 2018 spending on Race, being college educated, 
#how much you spent in 2017, College by Spending2017 interaction, 
#and the square of 2017 spending.

#Note: Baseline category for Race is American Indian
table(Customers$Race)

CustomersPred <- read.csv("Recitations/Recitation 12/CustomersPred.csv")

#Predict 2018 spending on the 5 customers in the CustomersPred.csv dataset
mypredsbetter = predict(mod8, CustomersPred)
CustomersPred$pred2018SpendingImproved = mypredsbetter
View(CustomersPred)

#Regression

#First model
mylm1 = lm(Income ~ Hours + Hot + Holiday, 
           data = icecream)
summary(mylm1)

#With interaction terms
mylm2 = lm(Income ~ Hours + Hot + Holiday + Hours*Hot + Hours*Holiday + Hot*Holiday, 
           data = icecream)
summary(mylm2)

#With interaction terms
mylm3 = lm(Price ~ Sqft + Baths + Col, 
           data = Arlington)
summary(mylm3)

#With interaction terms
mylm4 = lm(Price ~ Sqft + Baths + Col + Sqft*Col + Sqft*Baths + Col*Baths, 
           data = Arlington)
summary(mylm4)

#Predicting price of a house with 2400 square feet, 3 bathrooms, built during the 
#Colonial period
mylm4$coefficients[1] + mylm4$coefficients[2]*2400 + mylm4$coefficients[3]*3 + 
  mylm4$coefficients[4]*1+ mylm4$coefficients[5]*2400*1 + 
  mylm4$coefficients[6]*2400*3 + mylm4$coefficients[7]*1*3
