

# Load the data from dropbox link
# Note: If you use dropbox link for your own data make sure to change dl=0 to dl=1 at end of sharable link
url <- "https://www.dropbox.com/s/9h6hqc7ikyj9kmg/Deer%20Body%20Mass%20Data.csv?dl=1"
df.deer <- read.csv(url)

# Check out first six rows of data set
head(df.deer)

# Check out last six rows of data set
tail(df.deer)

# Plot showing the marginal effect of cropland on body mass
plot(df.deer$Amount.of.cropland.in.hectares,
     df.deer$Body.mass.in.kg,
     xlab="Cropland area in ha",
     ylab="Deer body mass in kg")

# Plot showing the marginal effect of deer abundance on body mass
plot(df.deer$Post.harvest.abundance.estimates,
     df.deer$Body.mass.in.kg,     
     xlab="Deer abundance",
     ylab="Deer body mass in kg",xlim=c(0,1500))


# Split data into two data sets. The Boyer Chute NWR data will be used for 
# extreme model testing at some point. 
df.boyer <- df.deer[which(df.deer$Location.of.harvest=="boyer"),]
df.desoto <- df.deer[which(df.deer$Location.of.harvest=="desoto"),]

# Determine how many observations are in each data set
dim(df.boyer)
dim(df.desoto)

# Split data from DeSoto NWR into two data sets. One data set will be used
# for model fitting (estimating model parameters) and the other will be used
# for model testing
set.seed(3028)
keep <- sample(1:1730,size=865,replace=FALSE)
df.desoto.mod <- df.desoto[keep,]
df.desoto.test <- df.desoto[-keep,]  

# Estimate parameters for the linear model that we wrote out on the whiteboard in class on June 14
m1 <- lm(Body.mass.in.kg~Amount.of.cropland.in.hectares+Post.harvest.abundance.estimates,data=df.desoto.mod)
m1

# Use estimated slope parameter to determine how many lbs a deer
# would gain if we added a 100 ha crop field
(0.02522*100)*2.2

# Use estimated slope parameter to determine how many lbs a deer
# would gain if we harvested (removed) 100 deer from each refuge
(-0.02180*(-100))*2.2


# Use estimated slope parameters to determine how many
# deer would need to be removed (or added) from the wildlife refuge
# to offset the weight loss (or gain)
# from a field of x ha being removed from production
x <- 100 # Area of ag field in ha
(-0.02522*x/0.02180)


# Estimate parameters for the linear model using maximum likelihood
library(nlme)
m2 <- gls(Body.mass.in.kg~Amount.of.cropland.in.hectares+Post.harvest.abundance.estimates,data=df.desoto.mod,
          method="ML")

summary(m2)



