# The value of my 401k retirement account as of 1/1/25
y_2025 <- 450000


# How much money will I add to my 401k each year
q <- 46000


# Rate of return for S&P 500 index fund
r <- 0.05


# How much $ will I have in 2026
y_2026 <- y_2025*(1+r)+q
y_2026


# Download S&P 500 returns    
url <- "https://www.dropbox.com/scl/fi/rny5260dfxkk5pkby6bdr/sp500.csv?rlkey=v81v7s91254hn8j5ab33az5t5&dl=1"
df.sp500 <- read.csv(url)

head(df.sp500)
tail(df.sp500)

mean(df.sp500$return)


hist(df.sp500$return,main="",col="grey",xlab=" Return rate of S&P 500")

# Using a for loop to calculate how much $ will I have 
year <- seq(2025,2025+32,by=1)
y <- matrix(,length(year),1)
rownames(y) <- year
y[1,1] <- 450000

for(t in 1:32){
  y[t+1,1] <- y[t,1]*(1+r)+q
}

plot(
    year,
    y/10^6,
    typ="b",
    pch=20,
    col="deepskyblue",
    xlab="Year",
    ylab="Pretax retirement amount ($ millions)"
)
