data <- read.csv("Assignments/Assignment 9/UnderArmour-1.csv")
View(data)

# 1. Logistic Regression
lr <- glm(
  Purchase ~ Age + I(Age^2) + FaveSteph, data = data,
  family = binomial(link = "logit")
)
summary(lr)

intercept <- lr$coefficients[1]
age <- lr$coefficients[2]
age_squared <- lr$coefficients[3]
favoriteSteph <- lr$coefficients[4]

# Predict prob that 45 year old with favorite as Stephan Curry made a purchase.
z = intercept + age*45 + age_squared*(45^2) + favoriteSteph*1
exp(z) / (1 + exp(z))  # 0.9167562

# Predict prob that 65 year old with favorite as Joel Embiid made a purchase.
z = intercept + age*65 + age_squared*(65^2) + favoriteSteph*0
exp(z) / (1 + exp(z))  # 0.004293867 

# Get accuracy of model
predictions <- ifelse(lr$fitted.values > 0.5, 1, 0)
mean(predictions == data$Purchase) * 100  # 82.8

# 2. Linear Probability Model
lpm <- lm(Purchase ~ Age + I(Age^2) + FaveSteph, data = data)
summary(lpm)

intercept <- lpm$coefficients[1]
age <- lpm$coefficients[2]
age_squared <- lpm$coefficients[3]
favoriteSteph <- lpm$coefficients[4]

# Predict prob that 45 year old with favorite as Stephan Curry made a purchase.
intercept + age*45 + age_squared*(45^2) + favoriteSteph*1  #  0.8407124

# Predict prob that 65 year old with favorite as Joel Embiid made a purchase.
intercept + age*65 + age_squared*(65*2) + favoriteSteph*0  # 3.891527

# Get accuracy of model
predictions <- ifelse(lpm$fitted.values > 0.5, 1, 0)
mean(predictions == data$Purchase) * 100  # 82.5
