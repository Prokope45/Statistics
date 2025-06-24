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
ols_beta0.hat <- y.bar - sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)*x.bar
ols_beta0.hat  # 83.98873
ols_beta1.hat <- sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)
ols_beta1.hat  # -0.00847421

# Double check parameters
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
x
x.bar
y.bar <- mean(y)

# a.
lad_beta0.hat <- y.bar - sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)*x.bar
lad_beta0.hat  # 46.42983
lad_beta1.hat <- sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)
lad_beta1.hat  # 0.0001902842

# Double check parameters
model <- lm(TOBS ~ days, data=df.temp)
summary(model)
"
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 4.643e+01  3.967e-01  117.03   <2e-16 ***
days        1.903e-04  1.223e-05   15.56   <2e-16 ***
"

# b.
abs_error <- sum(abs(y - (lad_beta0.hat + lad_beta1.hat * x)))
abs_error  # 624831.7


# c.
plot(x, y,
   pch = 16, cex = 0.6, col = "gray40",
   xlab = "Days Since First Record",
   ylab = "TOBS (Temperature at Observation)",
   main = "OLS vs LAD Best Fit Lines"
)

# Add OLS line (red)
abline(a = ols_beta0.hat, b = ols_beta1.hat, col = "red", lwd = 2)

# Add LAD line (blue)
abline(a = lad_beta0.hat, b = lad_beta1.hat, col = "blue", lwd = 2)

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



