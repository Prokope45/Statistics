CarAgePrice = read.csv("Assignments\Assignment 7\CarAgePrice.csv")

View(CarAgePrice)


carLm = lm(Price ~ Age + Miles, data=CarAgePrice)
summary(carLm)

# Price predicted for 5 year old car with 40,000
intercept_est = 22137.70
age_est = -648.50
miles_est = -72.63
intercept_est + (age_est * 5) + (miles_est * (40000 / 1000))  # Miles divided by 1000 based on format in data.

# Form 95% confidence interval for B1, predictor of Agei

alpha = 0.05
1 - alpha/2

n = dim(CarAgePrice)[1]

# Two predictor variables, Age and Miles
df = n - 2 - 1

t_stat = qt(1 - alpha/2, df)

age_std_err = 251.07

# Left endpoint
age_est - (t_stat * age_std_err)
# Right endpoint
age_est + (t_stat * age_std_err)
