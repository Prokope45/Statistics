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

# Cleanup: remove rows with NA TOBS values
df.temp = subset(df.temp, !is.na(TOBS))

# Quantify uncertainty for parameters
model <- lm(TOBS ~ days, data=df.temp)
summary(model)

confint(model, level=0.95)

beta0.hat <- as.numeric(coef(model)[1])
beta0.hat
beta1.hat <- as.numeric(coef(model)[2])
beta1.hat

temp.hat <- - beta0.hat / beta1.hat
temp.hat

install.packages('msm')
library(msm)
temp.se <- deltamethod(~ -x1/x2, mean=coef(model), cov=vcov(model))
temp.ci <- c(
  (temp.hat - 1.96 * temp.se),
  (temp.hat + 1.96 * temp.se)
)
temp.ci

x <- as.numeric(df.temp$days)
x.bar <- mean(x)
y <- df.temp$TOBS
y.bar <- mean(y)

# Squared distance (with optimization)
sqrd_dist <- optim(
  par = c(0, 0),
  method = c("Nelder-Mead"),
  fn = function(beta) {
    sum((y - (beta[1] + beta[2] * x))^2)
  }
)
sqrd_dist

sqrd_dist_para_1 <- sqrd_dist[1]$par[1]
sqrd_dist_para_1
sqrd_dist_para_2 <- sqrd_dist[1]$par[2]
sqrd_dist_para_2

start_date <- min(ymd(df.temp$DATE))
target_date <- as.Date("2050-01-01")

# Calculate days since start
x_2050 <- as.numeric(target_date - start_date)
x_2050

# squared distance Prediction
tobs_pred_sqrd_dist <- sqrd_dist_para_1 + sqrd_dist_para_2 * x_2050
tobs_pred_sqrd_dist  # 56.7819

Ey.hat <- predict(model)
Ey.hat

plot(
  x,
  y,
  pch = 16,
  cex = 0.6,
  col = "gray",
  xlab = "Days Since First Record",
  ylab = "TOBS (Temperature at Observation)",
  main = "Sqrd Distance vs Absolute Error Best Fit Lines"
)

points(x, Ey.hat, typ="l", col="red")
# points(x, Ey.hat[,1], typ="l", col="red")
# points(x, Ey.hat[,2], typ="l", col="red", lty=2)
# points(x, Ey.hat[,3], typ="l", col="red", lty=2)
