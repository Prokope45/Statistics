# 1.
# Check using matrix algebra
x <- matrix(data = c(1, 1, 1, 2, 5, 6), nrow = 3, byrow=FALSE)
y <- c(6.6, 2.2, -1.1)
beta <- solve(t(x) %*% x) %*% t(x) %*% y
beta

install.packages('lubridate')
library(lubridate)
url <- "https://www.dropbox.com/s/asw6gtq7pp1h0bx/manhattan_temp_data.csv?dl=1"
df.temp <- read.csv(url)
df.temp$year = as.numeric(year(df.temp$DATE))
df.temp$DATE <- ymd(df.temp$DATE)
df.temp$days <- df.temp$DATE - min(df.temp$DATE)

# df.temp <- na.omit(df.temp)

plot(
  df.temp$DATE,
  df.temp$TOBS,
  xlab="Date",
  ylab="Temperature"
)

# Look at data
head(df.temp)
tail(df.temp)


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
beta0.hat <- y.bar - beta1.hat * x.bar
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

x
y

# Double check using Matrix Algebra
x_dim <- length(x)
x_dim
length(y)

x_matrix <- matrix(data = cbind(rep(1, length(x)), x), nrow = length(x), byrow = FALSE)
x_matrix
y_matrix <- y
y_matrix
beta <- solve(t(x_matrix) %*% x_matrix) %*% t(x_matrix) %*% y_matrix
beta


# 5.
df.temp <- read.csv(url)
df.temp$DATE <- ymd(df.temp$DATE)
df.temp$days <- df.temp$DATE - min(df.temp$DATE)

# Cleanup: remove rows with NA TOBS values
df.temp = subset(df.temp, !is.na(TOBS))

x <- as.numeric(df.temp$days)
y <- df.temp$TOBS

x.bar <- mean(x)
y.bar <- mean(y)

beta1.hat <- sum((x - x.bar) * (y - y.bar)) / sum((x - x.bar)^2)
beta1.hat  # 0.0001902842
beta0.hat <- y.bar - beta1.hat * x.bar
beta0.hat  # 46.42983

# Double check parameters using lm()
model <- lm(TOBS ~ days, data=df.temp)
summary(model)
"
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 4.643e+01  3.967e-01  117.03   <2e-16 ***
days        1.903e-04  1.223e-05   15.56   <2e-16 ***
"


# a.
# Squared distance (with optimization)
sqrd_dist <- optim(
  par = c(0, 0),
  method = c("Nelder-Mead"),
  fn = function(beta) {
    sum((y - (beta[1] + beta[2] * x))^2)
  }
)
sqrd_dist
"
$par
[1] 4.643207e+01 1.902857e-04

$value
[1] 16241465
"
sqrd_dist_para_1 <- sqrd_dist[1]$par[1]
sqrd_dist_para_1
sqrd_dist_para_2 <- sqrd_dist[1]$par[2]
sqrd_dist_para_2


# b.
# Absolute Error (with optimization)
abs_err <- optim(
  par = c(0, 0),
  method = c("Nelder-Mead"),
  fn = function(beta) {
    sum(abs(y - (beta[1] + beta[2] * x)))
  }
)
abs_err
"
$par
[1] 4.218326e+01 3.373865e-04

$value
[1] 623903.9
"
abs_err_para_1 <- abs_err[1]$par[1]
abs_err_para_1
abs_err_para_2 <- abs_err[1]$par[2]
abs_err_para_2


# c.
plot(x, y,
   pch = 16, cex = 0.6, col = "gray",
   xlab = "Days Since First Record",
   ylab = "TOBS (Temperature at Observation)",
   main = "Sqrd Distance vs Absolute Error Best Fit Lines"
)

# Add squared distance line (red)
abline(a = sqrd_dist_para_1, b = sqrd_dist_para_2, col = "red", lwd = 2)

# Add absolute error line (blue)
abline(a = abs_err_para_1, b = abs_err_para_2, col = "blue", lwd = 2)


# d.
start_date <- min(ymd(df.temp$DATE))
target_date <- as.Date("2050-01-01")

# Calculate days since start
x_2050 <- as.numeric(target_date - start_date)
x_2050

# squared distance Prediction
tobs_pred_sqrd_dist <- sqrd_dist_para_1 + sqrd_dist_para_2 * x_2050
tobs_pred_sqrd_dist  # 56.7819

# absolute error Prediction
tobs_pred_abs_error <- abs_err_para_1 + abs_err_para_2 * x_2050
tobs_pred_abs_error  # 60.53404

