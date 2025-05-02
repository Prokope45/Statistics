#Load in admissions dataset

#Perform a hypothesis test testing whether the true average GPA is greater than 3.3
t.test(Admissions$HSGPA, mu = 3.3, alternative = "greater")

#Confidence interval for HSGPA
t.test(Admissions$HSGPA, alternative = "two.sided", conf.level = .95)

#Test whether fewer than 50% of applicants are female
#Get number of female applicants.
#Two ways of doing this

myx = sum(Admissions$Female == "Yes")
myx2 = table(Admissions$Female)[2]

#Get number of observations
myn = length(Admissions$Female)

#Run prop.test()
prop.test(x = myx, n = myn, p = 0.5, alternative = "less", correct = FALSE)
-sqrt(0.003252)




