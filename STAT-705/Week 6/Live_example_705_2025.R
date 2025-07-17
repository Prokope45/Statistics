# Load the data from dropbox link
# Note: If you use dropbox link for your own data make sure to change dl=0 to dl=1 at end of sharable link
url <- "https://www.dropbox.com/s/9h6hqc7ikyj9kmg/Deer%20Body%20Mass%20Data.csv?dl=1"
df.deer <- read.csv(url)
df.deer$Sex <- as.factor(df.deer$Sex)
df.deer$Age.class <- as.factor(df.deer$Age.class)


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


# Evaluate how well the model predicts deer body weights
# using 865 recorded deer body weights from Desoto NWR
# that were not used previously for model fitting
E.y.hat <- predict(m1,newdata=df.desoto.test)
y <- df.desoto.test$Body.mass.in.kg

mean((y-E.y.hat)^2) # Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error


# Assess calibration of 95% prediction intervals using 
# 865 recorded deer body weights from Desoto NWR that 
# were not used previously for model fitting
li <- predict(m1,newdata=df.desoto.test,interval="prediction",level=0.95)[,2]
ui <- predict(m1,newdata=df.desoto.test,interval="prediction",level=0.95)[,3]

cover <- ifelse(y>li,1,0)*ifelse(y<ui,1,0)
mean(cover)


# Evaluate how well the model predicts deer body weights
# using 66 recorded deer body weights from Boyer Chute NWR
# that were not used previously for model fitting
E.y.hat <- predict(m1,newdata=df.boyer)
y <- df.boyer$Body.mass.in.kg

mean((y-E.y.hat)^2) #Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error


# Assess calibration of 95% prediction intervals using 
# 66 recorded deer body weights from Boyer Chute NWR that 
# were not used previously for model fitting
li <- predict(m1,newdata=df.boyer,interval="prediction",level=0.95)[,2]
ui <- predict(m1,newdata=df.boyer,interval="prediction",level=0.95)[,3]

cover <- ifelse(y>li,1,0)*ifelse(y<ui,1,0)
mean(cover)

##############################################################################
#
# t-test example to determine if the expected value of female deer weights
# are different than the expected value of male weights.
#
##############################################################################

plot(c(rep(1,333),rep(2,532)),
     c(df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Male")],
       df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Female")]),
     xaxt='n',
     xlim=c(0,3),
     xlab="Sex",
     ylab="Deer body mass in kg")
axis(c(1,2),labels = c("Male","Female"),side=1)


hist(df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Male")],xlab="Deer body mass in kg",main="")
hist(df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Female")],xlab="Deer body mass in kg",main="")

mean(df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Male")])
mean(df.desoto.mod$Body.mass.in.kg[which(df.desoto.mod$Sex=="Female")])

m3 <- lm(Body.mass.in.kg~Sex,data=df.desoto.mod)
summary(m3)

m4 <- lm(Body.mass.in.kg~Sex-1,data=df.desoto.mod)
summary(m4)

confint(m4)

unique(df.desoto.mod$Age.class)

##############################################################################
#
# ANOVA example 
#
##############################################################################

m5 <- lm(Body.mass.in.kg~Age.class, data=df.desoto.mod)
summary(m5)
anova(m5)
hist(df.desoto.mod$Body.mass.in.kg)
# Variability can be explained by age.

E.y.hat <- predict(m5,newdata=df.boyer)
y <- df.boyer$Body.mass.in.kg

mean((y-E.y.hat)^2) #Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error

li <- predict(m5,newdata=df.boyer,interval="prediction",level=0.95)[,2]
ui <- predict(m5,newdata=df.boyer,interval="prediction",level=0.95)[,3]

cover <- ifelse(y>li,1,0)*ifelse(y<ui,1,0)
mean(cover)
# Evidence for under-representing weight; interval too narrow

# Interaction effects
m6 <- lm(Body.mass.in.kg~Age.class*Sex, data=df.desoto.mod)
summary(m6)
anova(m6)
# Age still accounts for most variability; sex not much; age with sex, not much.

E.y.hat <- predict(m6,newdata=df.boyer)
y <- df.boyer$Body.mass.in.kg
mean((y-E.y.hat)^2) #Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error


##############################################################################
#
# Machine learning example of optimizing predictive accuracy only
#
##############################################################################

library(gbm)
ml <- gbm(Body.mass.in.kg~Amount.of.cropland.in.hectares+Post.harvest.abundance.estimates+Sex+Age.class,
          data=df.desoto.mod,
          distribution = "laplace",
          n.trees = 100,
          interaction.depth = 5,
          n.minobsinnode = 10,
          shrinkage = 0.1,
          bag.fraction = 1,
          train.fraction = 1)

E.y.hat <- predict.gbm(ml,newdata=df.desoto.test)
y <- df.desoto.test$Body.mass.in.kg
mean((y-E.y.hat)^2) # Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error

E.y.hat <- predict.gbm(ml,newdata=df.boyer)
y <- df.boyer$Body.mass.in.kg
mean((y-E.y.hat)^2) # Mean squared error
mean(abs(y-E.y.hat)) # Mean absolute error
