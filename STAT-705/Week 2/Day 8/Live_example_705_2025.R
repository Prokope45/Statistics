A <- matrix(c(1,2,3,2,5,6,3,6,9),3,3)
B <- diag(1,3)
solve(A+B)
C <- t(A)

solve(A+B)%*%(C+B)




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
m1 <- lm(
  Body.mass.in.kg ~ Amount.of.cropland.in.hectares + Post.harvest.abundance.estimates,
  data=df.desoto.mod
)
m1

m1 <- lm(
  Body.mass.in.kg ~ 1,
  data=df.desoto.mod
)
m1

# Use estimated slope parameter to determine how many lbs
# a deer would gain if we added 100 hectares of cropland
# (Amount.of.cropland.in.hectares * 100 hectares) * 2.2 lbs/hectare
(0.02522*100)*2.2
# If we let one deer out in the wild, 5.5484 would be gained

# Use estimated slope parameter to determine how many lbs
# a deer would gain if we harvested (removed) 100 deer from each refuge
(-0.02190 * (-100)) * 2.2
# 4.818 lbs would be gained 

# Use estimated slope parameters to determine how many deer
# would need to be removed (or added) from the wildlife refuge to
# offset the weight loss (or gain) from a field of x hectares being removed from
# production
x <- 100
(-0.02522 * x / 0.02180)
# 115.6881 hectares should be removed
# For model to be used, it would need to be tested