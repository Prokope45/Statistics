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



# Use maximum likelihood estimate (mle) of slope parameter to determine how many lbs a deer
# would gain if we added a 100 ha crop field
(0.02522*100)*2.2

install.packages('msm')
library(msm)
dq.hat <- (0.02522*100)*2.2
se.hat <- deltamethod(~x2*100*2.2,mean=coef(m2),cov=vcov(m2))

dq.hat
dq.hat-1.96*se.hat
dq.hat+1.96*se.hat

# Use maximum likelihood estimate (mle) of slope parameter to determine how many lbs a deer
# would gain if we harvested (removed) 100 deer from each refuge
(-0.02180*(-100))*2.2

dq.hat <- (-0.02180*(-100))*2.2
se.hat <- deltamethod(~x3*(-100)*2.2,mean=coef(m2),cov=vcov(m2))

dq.hat
dq.hat-1.96*se.hat
dq.hat+1.96*se.hat


# Use maximum likelihood estimate parameters to determine how many
# deer would need to be removed (or added) from the wildlife refuge
# to offset the weight loss (or gain)
# from a field of x ha being removed from production
x <- 100 # Area of ag field in ha
(-0.02522*x/0.02180)

dq.hat <- (0.02522*x/(-0.02180))
se.hat <- deltamethod(~x3*100/x2,mean=coef(m2),cov=vcov(m2))

dq.hat
dq.hat-1.96*se.hat
dq.hat+1.96*se.hat


# Use bootstrap algorithm to obtain empirical distribution (aka bootstrap distribution)
# of how many deer would need to be removed (or added) from the wildlife refuge
# to offset the weight loss (or gain) from a field of x ha being removed from production
install.packages('mosaic')
library(mosaic)

set.seed(1940) 
bootstrap <- do(1000)*coef(gls(Body.mass.in.kg~Amount.of.cropland.in.hectares+Post.harvest.abundance.estimates,
                               data=resample(df.desoto.mod)))
head(bootstrap)

x <- 100 # Area of ag field in ha
deer.remove.dist <- (bootstrap[,2]*x)/(bootstrap[,3])
hist(deer.remove.dist,xlim=c(-700,200),breaks=1000,freq=FALSE,main="",xlab="Number of deer to remove")

# Get 95% confidence intervals from bootstrap
quantile(deer.remove.dist,prob=c(0.025,0.975))


# Evaluate how well the model predicts deer body weights using
# 865 recorded deer body weights from Desoto NWR
# that were not used previously for model fitting
E.y.hat <- predict(m1, newdata=df.desoto.test)
y <- df.desoto.test$Body.mass.in.kg

mean((y - E.y.hat)^2)  # Mean Squared Error
# Off by 253 kilos, but does not seem realistic
# Could we realistically predict body weight within 253 kilos? Yes, but it's too broad.
mean(abs(y - E.y.hat))  # Absolute distance (error)
# Off by 13 kilos; is more realistic error for prediction, though 5 kilos (10lb) would be best.

install.packages('gbm')
library(gbm)
ml <- gbm(
     Body.mass.in.kg ~ Amount.of.cropland.in.hectares + Post.harvest.abundance.estimates,  # FIXME: check model.
     data = df.desoto.mod,
     distribution = "laplace",
     n.trees = 100,
     interaction.depth = 5,
     n.minobsinnode = 10,
     shrinkage = 0.1,
     bag.fraction = 1,
     train.fraction = 1
)

# At Desoto
E.y.hat <- predict.gbm(ml, newdata=df.desoto.test)
y <- df.desoto.test$Body.mass.in.kg
mean((y - E.y.hat)^2)  # Mean squared error
# should be 28.94101
mean(abs(y - E.y.hat))  # Mean absolute error
# should be 4.201721

# At Boyer
E.y.hat <- predict.gbm(ml, newdata = df.boyer)
y <- df.boyer$Body.mass.in.kg
mean((y - E.y.hat)^2)  # Mean squared error
# should be 92.03875
mean(abs(y - E.y.hat))  # Mean absolute error
# should be 7.760008
