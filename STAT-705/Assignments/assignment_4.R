install.packages("gamair")
library(gamair)
data(hubble)

# Figure 1.1 from Wood 2006
plot(hubble$x,hubble$y,xlab="Distance (Mpc)",
     ylab=expression("Velocity (km"*s^{-1}*")"))


# 1.
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

# c.
coef(ml1)

interval <- confint(ml1, level=0.95)

# d.
# There is a 95% that the interval covers the estimate.


# 2. (Answered in Obsidian)

# 3.
install.packages('lubridate')
library(lubridate)
url <- "https://www.dropbox.com/s/asw6gtq7pp1h0bx/manhattan_temp_data.csv?dl=1"
df.temp <- read.csv(url)
df.temp$year = as.numeric(year(df.temp$DATE))
df.temp$DATE <- ymd(df.temp$DATE)
df.temp$days <- df.temp$DATE - min(df.temp$DATE)
plot(
  df.temp$DATE,
  df.temp$TOBS,
  xlab="Date",
  ylab="Temperature"
)

# 4.
# Cleanup: remove rows with NA TMAX values
df.temp = subset(df.temp, !is.na(TMAX))

x <- df.temp$year
y <- df.temp$TMAX

x.bar <- mean(x)
y.bar <- mean(y)

# Estimate slope and intercept parameters
beta1.hat <- sum((x - x.bar) * (y - y.bar)) / sum((x - x.bar)^2)
beta1.hat  # -0.00847421
beta0.hat <- y.bar - ols_beta1.hat * x.bar
beta0.hat  # 83.98873

# Double check parameters using lm()
model <- lm(TMAX ~ year, data=df.temp)
summary(model)
"
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 83.988734   5.346634  15.709   <2e-16 ***
year        -0.008474   0.002728  -3.106   0.0019 ** 
"
# Double check using Matrix Algebra
x_dim <- length(x)
x_dim  # 46093
length(y)  # 46093

x_matrix <- matrix(data = cbind(rep(1, length(x)), x), nrow = length(x), byrow = FALSE)
y_matrix <- y
y_matrix
beta <- solve(t(x_matrix) %*% x_matrix) %*% t(x_matrix) %*% y_matrix
beta
"
            [,1]
[1,] 83.98873434
[2,] -0.00847421
"