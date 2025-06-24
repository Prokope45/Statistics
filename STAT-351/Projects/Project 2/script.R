workDemo <- read.csv("Projects/Project 2/WorkDemo.csv")
View(workDemo)
# which(is.na(workDemo))

# Want to determine if participating in program increases real earnings in 1978.
re78Lm <- lm(re78 ~ program, data = workDemo)
summary(re78Lm)


# 1. Model Fitting
# Start with every predictor
re78Lm0 <- lm(
  re78 ~ program + age +
  educ + black + hisp +
  married + nodegr + re74 +
  re75 + u74 + u75 +
  program*re75 + educ*re75 +
  black*re75 + hisp*re75 +
  nodegr*re75,
  data = workDemo
)
summary(re78Lm0)
# R2: 0.03412
# Important: program, black participants, age

re78Lm1 <- lm(
  re78 ~ program + age +
  educ + black + re74 +
  u74 + u75 +
  educ*re75 +
  hisp*re75 +
  nodegr*re75,
  data = workDemo
)
summary(re78Lm1)
# R2: 0.04073

re78Lm2 <- lm(
  re78 ~ program + age +
  educ + black + re74 +
  u74 + u75 +
  educ*re75 +
  hisp*re75,
  data = workDemo
)
summary(re78Lm2)
# R2: 0.04359

re78Lm3 <- lm(
  re78 ~ program + age +
  educ + black + re74 +
  educ*re75 +
  hisp*re75,
  data = workDemo
)
summary(re78Lm3)
# R2: 0.04422

re78Lm4 <- lm(
  re78 ~ program + age +
  educ + re75 + black +
  educ*re75,
  data = workDemo
)
summary(re78Lm4)
# R2: 0.04484


# 2. Residual Analysis
# 2.1
plot(
  re78Lm4$fitted.values,
  re78Lm4$residuals,
  xlab="Fitted Values", ylab="Residuals",
  main="Jared Paubel", pch=16
)
abline(0, 0)
# Has strange cutoff at the bottom of residual cluster.

# 2.2
plot(
  I(log(workDemo$re75)),
  re78Lm4$residuals,
  xlab="Log of Real Earnings in 1975", ylab="Residuals",
  main="Plot of residuals against real earnings in 1975", pch=16
)
abline(0, 0)
# Does not appear to have any regression assumption violations.

# 3. Predict Response
# 3.1
workDemoPred <- read.csv("Projects/Project 2/WorkDemoPred.csv")
predictions <- predict(re78Lm4, workDemoPred)
workDemoPred$Predicted_Increase = predictions
View(workDemoPred)


# 4. Regression Interpretation
# 4.1
summary(re78Lm4)
# Est. Coeff. of program = 1.609e+03
# Std. Error of Program = 6.347e+02
# Estimate of program indicates that participation increases real earnings
#   by 1609, holding all other variables constant.


# 5. Hypothesis testing using regression
# 5.1 (Answered in document)
# 5.2 Form 95% confidence interval for true value of regres. coeff.
alpha = 0.05
1-alpha/2
df = 428
1609 - qt(1-alpha/2, df) * 634.7  # Left endpoint: 361.4831
1609 + qt(1-alpha/2, df) * 634.7  # Right endpoint: 2856.517
