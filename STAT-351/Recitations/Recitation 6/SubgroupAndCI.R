Customers <- read.csv("Recitations/Recitation 6/Customers.csv")
#Mean and standard deviation of 2018 spending by satisfaction level
aggregate(Customers$Spending2018, by = list(Customers$Satisfaction), mean)
aggregate(Customers$Spending2018, by = list(Customers$Satisfaction), sd)

#Subgroups by spending level
whichbigspend = which(Customers$Spending2018 > 1000)
whichsmallspend = which(Customers$Spending2018 <= 1000)

bigspend = Customers[whichbigspend,]
smallspend = Customers[whichsmallspend,]

#Look at proportion that attended college
prop.table(table(bigspend$College))
prop.table(table(smallspend$College))

pnorm(15, mean=10, sd=5)

# Find normal distribution from 8 to 9
pnorm(9, mean=10, sd=5) - pnorm(8, mean=10, sd=5)

# Get 20th percentile
qnorm(0.2, mean=5, sd=10)

mean_spend <- 100
sd_spend <- 50
sample_size <- 400
# Probability that sampled shoppers spend more than $104
prob104 <- 1 - pnorm(104, mean_spend, sd_spend) # Gets less than 104, so we minus 1

# Find prob of average spend between 99 and 102
prob99102 <- pnorm(102, mean_spend, sd_spend) - pnorm(99, mean_spend, sd_spend)

# Find prop of more than 16% of shoppers spending more than $200
# Number of shoppers spending more than $200
propMore200 <- 1 - pnorm(200, mean_spend, sd_spend) / sqrt(sample_size)

# Number of shoppers who correspond to 16%
numShop16 <- 0.16 * sample_size
# compute standard error
stdErrProp <- sqrt(propMore200 * (1 - propMore200)) / sample_size
# Calculate Z-score
zScore <- ((numShop16 - sample_size) * propMore200 ) / stdErrProp
# Calculate the probability less than 16% spending more than $200
probLess16 <- pnorm(zScore, mean_spend, sd_spend)

