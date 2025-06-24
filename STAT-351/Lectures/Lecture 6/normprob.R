#Normal Distribution

#Suppose that scores on a standardized test follow a normal distribution 
#with mean 100 and standard deviation 20
#20 percent of test takers are planning on attending college

#What is the probability that a randomly selected score taker earns a score less than 110?
pnorm(110, mean = 100, sd = 20)

#What is the probability that a randomly selected score taker earns a score greater than 105?
1-pnorm(105, mean = 100, sd = 20)

#What is the probability that a randomly selected score taker earns a score between 94 and 108?
pnorm(108, mean = 100, sd = 20)-pnorm(94, mean = 100, sd = 20)
  
#What is the 10th percentile of scores?
qnorm(0.1, mean = 100, sd = 20)

#80% of students earn a score below what number?
qnorm(0.8, mean = 100, sd = 20)

#30% of students earn a score above what number?
qnorm(1-0.3, mean = 100, sd = 20)

#Suppose we sample 100 test-takers
#What is the probability that the average test score is greater than 105
1-pnorm(105, 100, 20/sqrt(100))

#What is the probability that 18% or less of sampled test takers are planning on attending college?
pnorm(.18, .20, sqrt(.2*.8/100))
