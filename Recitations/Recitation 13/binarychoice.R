Spam <- read.csv("Recitations/Recitation 13/Spam.csv")

#Linear probability model
mylpm = lm(Spam ~ Hyperlinks + Recipients + Characters, data = Spam)
summary(mylpm)

#Prediction accuracy
preds = ifelse(mylpm$fitted.values > 0.5, 1, 0)
mean(preds == Spam$Spam)

#Estimate probability of spam for an e-mail with 5 hyperlinks, 10 recipients, and 100 characters
mylpm$coefficients[1] + mylpm$coefficients[2]*5 + mylpm$coefficients[3]*10 + mylpm$coefficients[4]*100

#Estimate probability of spam for an e-mail with 11 hyperlinks, 20 recipients, and 50 characters
mylpm$coefficients[1] + mylpm$coefficients[2]*11 + mylpm$coefficients[3]*20 + mylpm$coefficients[4]*50


#Logistic regression
mylr = glm(Spam ~ Hyperlinks + Recipients + Characters, data = Spam,
          family = binomial(link = "logit"))
summary(mylr)
# Characters coefficients negative

#Prediction accuracy
preds = ifelse(mylr$fitted.values > 0.5, 1, 0)
mean(preds == Spam$Spam)

#Estimate probability of spam for an e-mail with 5 hyperlinks, 10 recipients, and 100 characters
exp(mylr$coefficients[1] + mylr$coefficients[2]*5 + mylr$coefficients[3]*10 + mylr$coefficients[4]*100)/(
  1 + exp(mylr$coefficients[1] + mylr$coefficients[2]*5 + mylr$coefficients[3]*10 + mylr$coefficients[4]*100))

#Estimate probability of spam for an e-mail with 11 hyperlinks, 20 recipients, and 50 characters
exp(mylr$coefficients[1] + mylr$coefficients[2]*11 + mylr$coefficients[3]*20 + mylr$coefficients[4]*50)/(
  1 + exp(mylr$coefficients[1] + mylr$coefficients[2]*11 + mylr$coefficients[3]*20 + mylr$coefficients[4]*50))
