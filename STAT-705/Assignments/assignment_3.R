library(lubridate)
url <- "https://www.dropbox.com/s/asw6gtq7pp1h0bx/manhattan_temp_data.csv?dl=1"
df.temp <- read.csv(url)
df.temp$year = as.numeric(year(df.temp$DATE))
df.temp$DATE <- ymd(df.temp$DATE)
df.temp$days <- df.temp$DATE - min(df.temp$DATE)
plot(df.temp$DATE,df.temp$TOBS,xlab="Date",ylab="Temperature")

head(df.temp)
tail(df.temp)

# Cleanup: remove rows with NA TMAX values
df.temp = subset(df.temp, !is.na(TMAX))

x <- df.temp$year
y <- df.temp$TMAX

x.bar <- mean(x)
y.bar <- mean(y)

# Estimate slope and intercept parameters
beta0.hat <- y.bar - sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)*x.bar
beta0.hat  # 83.98873
beta1.hat <- sum((x-x.bar)*(y-y.bar))/sum((x-x.bar)^2)
beta1.hat  # -0.00847421

# Double check parameters
model <- lm(TMAX ~ year, data=df.temp)
summary(model)

"
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 83.988734   5.346634  15.709   <2e-16 ***
year        -0.008474   0.002728  -3.106   0.0019 ** 
"
