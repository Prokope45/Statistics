####################
#Demo of CLT########
####################

#NOTE: This .R file contains advanced R code.  
#It is not required to know how these functions work at this time.
#(But this can help demonstrate the power of R)
set.seed(112233)

#Suppose we sample 100 observations from
#from a population with mean 0, standard deviation sqrt(3), 
#but is not normal.
#And suppose we do this process 100,000 times
dat = replicate(100000, runif(100,-3,3))

#Histogram of one sample
hist(dat[,1])

#Compute Z for each sample
mymeans = apply(dat, 2, mean)
myzs = (mymeans - 0)/(sqrt(3)/sqrt(100))

#Plot a histogram of the Z's
hist(myzs, breaks = 40, freq = FALSE)

#Overlay a Normal(0,1) distribution
lines(seq(-5,5,.001), dnorm(seq(-5,5,.001)))

#Almost a perfect fit.

#Do this again for an even more skewed distribution.

#Suppose we sample 600 observations from
#from a population with mean 4, standard deviation 2, 
#but is not normal.
#And suppose we do this process 100,000 times
dat2 = replicate(100000, rpois(600,4))

#Histogram of one sample
hist(dat2[,1], breaks = 10)

#Compute Z for each sample
mymeans2 = apply(dat2, 2, mean)
myzs2 = (mymeans2 - 4)/(2/sqrt(600))

#Plot a histogram of the Z's
hist(myzs2, breaks = 40, freq = FALSE)

#Should be positively skewed

#Overlay a Normal(0,1) distribution
lines(seq(-5,5,.001), dnorm(seq(-5,5,.001)))

#Still almost a perfect fit.

#Problems
1-pnorm(1012, 1000, 100/sqrt(400))
1-pnorm(1012, 1000, 5)

pnorm(0.08, 0.1, sqrt(0.1*0.9/400) )
pnorm(0.08, 0.1, 0.015)
