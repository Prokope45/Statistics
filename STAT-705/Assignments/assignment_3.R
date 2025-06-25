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
ols_beta1.hat <- sum((x - x.bar) * (y - y.bar)) / sum((x - x.bar)^2)
ols_beta1.hat  # -0.00847421
ols_beta0.hat <- y.bar - ols_beta1.hat * x.bar
ols_beta0.hat  # 83.98873

# Double check parameters using lm()
model <- lm(TMAX ~ year, data=df.temp)
summary(model)
"
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 83.988734   5.346634  15.709   <2e-16 ***
year        -0.008474   0.002728  -3.106   0.0019 ** 
"


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
   pch = 16, cex = 0.6, col = "gray40",
   xlab = "Days Since First Record",
   ylab = "TOBS (Temperature at Observation)",
   main = "OLS vs LAD Best Fit Lines"
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

# OLS Prediction
tobs_pred_ols <- ols_beta0.hat + ols_beta1.hat * x_2050
tobs_pred_ols

# LAD Prediction
tobs_pred_lad <- lad_beta0.hat + lad_beta1.hat * x_2050
tobs_pred_lad

