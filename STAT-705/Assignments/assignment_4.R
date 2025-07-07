install.packages("gamair")
library(gamair)
data(hubble)

# Figure 1.1 from Wood 2006
plot(hubble$x,hubble$y,xlab="Distance (Mpc)",
     ylab=expression("Velocity (km"*s^{-1}*")"))


# a.
# y_i = \betax_i + \epsilon_i

x <- hubble$x
y <- hubble$y
n <- length(y)

X <- matrix(data = cbind(rep(1, length(x)), x), nrow = length(x), byrow = FALSE)
X

beta <- solve(t(X) %*% X) %*% t(X) %*% y
beta

sigma2 <- (1 / n) * t(y - X %*% beta) %*% (y - X %*% beta)
sigma2

# Double check with stats software
ml1 <- lm(y ~ x, data = hubble)
ml1
coef(ml1)

summary(ml1)$sigma^2  # FIXME: not the same as sigma2

# b.
mega_parsecs <- 3.09 * (10^19)  # in km
mega_parsecs

distance <- beta[1,] / mega_parsecs
distance
age <- 1 / distance  # in years
age
