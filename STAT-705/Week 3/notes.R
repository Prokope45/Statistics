# Squared differences (with optimization)
y <- c(0.16,2.82,2.24)
x <- c(1,2,3)

optim(par=c(0,0),method = c("Nelder-Mead"),fn=function(beta){sum((y-(beta[1]+beta[2]*x))^2)})

# Absolute Error (with optimization)
optim(par=c(0,0),method = c("Nelder-Mead"),fn=function(beta){sum((abs(y-(beta[1]+beta[2]*x))))})


y <- c(63, 68, 61, 44, 103, 90, 107, 105, 76, 46, 60, 66, 58, 39, 64, 29, 37,
27, 38, 14, 38, 52, 84, 112, 112, 97, 131, 168, 70, 91, 52, 33, 33, 27,
18, 14, 5, 22, 31, 23, 14, 18, 23, 27, 44, 18, 19)
year <- 1965:2011
df <- data.frame(y = y, year = year)
plot(x = df$year, y = df$y, xlab = "Year", ylab = "Annual count", main = "",
col = "brown", pch = 20, xlim = c(1965, 2040))

m1 <- lm(y~year, data=df)
coef(m1)

confint(m1, level=0.95)
"
                2.5 %       97.5 %
(Intercept) 929.80699 3783.1689540
year         -1.87547   -0.4402103
"
# We care about year parameter (intercept is () parameter; ignored)
# So we are either losing 0.44 or 1.8 quail each year.
