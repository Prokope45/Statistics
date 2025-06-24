#Load in Mortgage.csv
Mortgage <- read.csv("Lectures/Module 13 - Binary Choice Models/Mortgage.csv")

lpm = lm(Approved ~ percDown + itlRatio, data = Mortgage)
summary(lpm)

#Predict approval using the linear probability model
preds = ifelse(lpm$fitted.values > 0.5, 1, 0)

#Get the prediction accuracy
mean(preds == Mortgage$Approved)

#83.3% of mortgages are approved.


#Predict approval using logistic regression
lr = glm(Approved ~ percDown + itlRatio, data = Mortgage, family = binomial(link = "logit"))
summary(lr)

#Predict approval using the linear probability model
preds2 = ifelse(lr$fitted.values > 0.5, 1, 0)

#Get the prediction accuracy
mean(preds2 == Mortgage$Approved)

#86.7% of mortgages are approved
#Use logistic regression instead of LPM since it has a higher prediction accuracy.

#Predict for linear probability model: percDown = 20, itlRatio = 30
lpm$coefficients[1] + lpm$coefficients[2]*20 + lpm$coefficients[3]*30

#Predict for linear probability model: percDown = 60, itlRatio = 30
lpm$coefficients[1] + lpm$coefficients[2]*60 + lpm$coefficients[3]*30

#Use the exp(z) function to write e^z
#Predict for logistic regression model: percDown = 20, itlRatio = 30
exp(lr$coefficients[1] + lr$coefficients[2]*20 + lr$coefficients[3]*30)/(1+exp(lr$coefficients[1] + lr$coefficients[2]*20 + lr$coefficients[3]*30))

#Predict for logistic regression model: percDown = 60, itlRatio = 30
exp(lr$coefficients[1] + lr$coefficients[2]*60 + lr$coefficients[3]*30)/(1+exp(lr$coefficients[1] + lr$coefficients[2]*60 + lr$coefficients[3]*30))

#Can also just plug in the values from the R output
#Predict for logistic regression: percDown = 20, itlRatio = 30
exp(-9.3671 + 0.1349*(20) + 	0.1782*(30) )/( 1+exp(-9.3671 + 0.1349*(20) + 0.1782*(30)))

#Predict for logistic regression: percDown = 60, itlRatio = 30
exp(-9.3671 + 0.1349*(60) + 	0.1782*(30) )/( 1+exp(-9.3671 + 0.1349*(60) + 0.1782*(30)))

#Customers Dataset:
GamePlayers <- read.csv("Lectures/Module 13 - Binary Choice Models/Customers.csv")
#Predict Satisfaction based on Type, Spending Last Year, and Spending This year
#Satisfaction is not binary.  Need to make it binary.
satisfied = ifelse(GamePlayers$Satisfaction == "Satisfied" | 
                     GamePlayers$Satisfaction == "Very Satisfied", 1, 0)

#Fit Linear Probability Model
lr2 = glm(satisfied ~ Type + SpendingLastYear + SpendingThisYear, 
          family = binomial(link = "logit"), data = GamePlayers)
summary(lpm2)

#Predict approval using the linear probability model
preds = ifelse(lr2$fitted.values > 0.5, 1, 0)

#Get the prediction accuracy
mean(preds == satisfied)

#75% prediction accuracy

