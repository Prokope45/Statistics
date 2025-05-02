GPAAdmissions <- read.csv("Recitations/Recitation 11/GPAAdmissions.csv")
#Make a categorical variable
NewEduParent1 = as.factor(GPAAdmissions$Edu_Parent1)

#Make High School Graduate the baseline category
NewEduParent1 = relevel(NewEduParent1, "3")

#Make a categorical variable
NewEduParent2 = as.factor(GPAAdmissions$Edu_Parent2)

#Make High School Graduate the baseline category
NewEduParent2 = relevel(NewEduParent2, "3")

mylm1 = lm(College_GPA ~ NewEduParent1 + NewEduParent2 +  College, data = GPAAdmissions)
summary(mylm1)
#Adjusted R-squared:  0.06721

mylm2 = lm(College_GPA ~ NewEduParent1 + NewEduParent2 + SAT.ACT + College, data = GPAAdmissions)
summary(mylm2)
#Adjusted R-squared:  0.1688

mylm3 = lm(College_GPA ~ NewEduParent1 + NewEduParent2 + HSGPA + SAT.ACT + College, data = GPAAdmissions)
summary(mylm3)
#Adjusted R-squared:  0.3181

mylm4 = lm(College_GPA ~ NewEduParent1 + NewEduParent2 + HSGPA + SAT.ACT + I(SAT.ACT^2)+ College, data = GPAAdmissions)
summary(mylm4)
#Adjusted R-squared:  0.3187

mylm5 = lm(College_GPA ~ NewEduParent1 + HSGPA + SAT.ACT + College, data = GPAAdmissions)
summary(mylm5)
#Adjusted R-squared: 0.3154

plot(GPAAdmissions$SAT.ACT, mylm4$residuals, pch = 16, xlab = "Fitted Values", ylab = "Residuals")
abline(0,0)

plot(mylm4$fitted.values, mylm4$residuals, pch = 16, xlab = "Fitted Values", ylab = "Residuals")
abline(0,0)
