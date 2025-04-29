data <- read.csv("Assignment 9/UnderArmour-1.csv")
View(data)

# 1. Logistic Regression
lr <- glm(Purchase ~ Age + I(Age^2) + FaveSteph + Age*Age^2, data = data, family = binomial(link = "logit"))
summary(lr)

# Predict prob that 45 year old with favorite as Stephan Curry made a purchase.
intercept <- lr$coefficients[1]
age <- lr$coefficients[2]
age_squared <- lr$coefficients[3]
favoriteSteph <- lr$coefficients[4]

numerator <- exp(intercept + age*45 + age_squared*45 + favoriteSteph*1)
denominator <- (1 + exp(intercept + age*45 + age_squared*45 + favoriteSteph*1))
numerator / denominator

# Get accuracy of model
predictions <- ifelse(lr$fitted.values > 0.5, 1, 0)
mean(predictions == data$Purchase) * 100

# Predict prob that 65 year old with favorite as Joel Embiid made a purchase.

numerator <- exp(intercept + age*65 + age_squared*65 + favoriteSteph*0)
denominator <- (1 + exp(intercept + age*65 + age_squared*65 + favoriteSteph*0))
numerator / denominator

# Get accuracy of model
predictions <- ifelse(lr$fitted.values > 0.5, 1, 0)
mean(predictions == data$Purchase) * 100


# 2. Linear Probability Model
