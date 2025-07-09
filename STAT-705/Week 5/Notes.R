install.packages('latex2exp')
library(latex2exp)

y <- c(63, 68, 61, 44, 103, 90, 107, 105, 76, 46, 60, 66, 58, 39, 64, 29, 37,
27, 38, 14, 38, 52, 84, 112, 112, 97, 131, 168, 70, 91, 52, 33, 33, 27,
18, 14, 5, 22, 31, 23, 14, 18, 23, 27, 44, 18, 19)
year <- 1965:2011
df <- data.frame(y = y, year = year)

# Number of bootstrap samples (m)
m.boot <- 1000   

# Create matrix to save empirical distribution of -beta2.hat/beta1.hat (expected time of extinction)
ed.extinct.hat <- matrix(,m.boot,1)

# Set random seed so results are the same if we run it again
# Results would be different due to random resampling of data
set.seed(1940)

# Start for loop for non-parametric boostrap
for(m in 1:m.boot){

  # Sample data with replacement
  # boot.sample gives the rows of df that we use for estimation
  boot.sample <- sample(1:nrow(df),replace=TRUE) 

  # Make temporary data frame that contains the resamples
  df.temp <- df[boot.sample,]

  # Estimate parameters for df.temp
  m1 <- lm(y~year,data=df.temp)

  # Save estimate of -beta0.hat/beta1.hat (expected time of extinction)
  ed.extinct.hat[m,] <- -coef(m1)[1]/coef(m1)[2]
}
par(mar=c(5,4,7,2))
hist(ed.extinct.hat,col="grey",xlab="Year",main=TeX('Empirical distribuiton of $$-$$\\hat{\\frac{$\\beta_0}{$\\beta_1}}'),freq=FALSE,breaks=20)


