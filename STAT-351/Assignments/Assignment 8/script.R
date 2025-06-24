happiness <- read.csv("Assignments\Assignment 8\Happiness.csv")
View(happiness)

# 1.
# a.
happiness_model_1 <- lm(Happiness ~ Age + Net.Worth, data = happiness)
summary(happiness_model_1)

# b.
happiness_model_2 <- lm(Happiness ~ Age + log(Net.Worth), data = happiness)
summary(happiness_model_2)

# 2.
# a.
plot(happiness$Age, happiness_model_2$residuals, xlab = "Age", ylab = "Residuals", 
     main = "Plot of residuals against Age", pch = 16)
abline(0,0)

# b.
plot(log(happiness$Net.Worth), happiness_model_2$residuals, xlab = "Age", ylab = "Residuals", 
     main = "Plot of residuals against Log(Net.Worth)", pch = 16)
abline(0,0)

# c.
plot(happiness_model_2$fitted.values, happiness_model_2$residuals, xlab = "Fitted Values", ylab = "Residuals", 
     main = "Plot of residuals against Fitted.Values", pch = 16)
abline(0,0)

# 3.
happiness_model_3 <- lm(Happiness ~ Age + I(Age^2) + Net.Worth, data = happiness)
summary(happiness_model_3)

# 4.
# a.
plot(happiness$Age, happiness_model_3$residuals, xlab = "Age", ylab = "Residuals", 
     main = "Plot of residuals against Age", pch = 16)
abline(0,0)

plot(happiness_model_3$fitted.values, happiness_model_3$residuals, xlab = "Fitted Values", ylab = "Residuals", 
     main = "Plot of residuals against Fitted.Values", pch = 16)
abline(0,0)

# 5.
intercept <- happiness_model_3$coefficients[1]
intercept
age <- happiness_model_3$coefficients[2]
age*50
age_squared <- happiness_model_3$coefficients[3]
age_squared*50
net_worth <- happiness_model_3$coefficients[4]
net_worth*180000

intercept + age*50 + age_squared*50 + net_worth*180000
