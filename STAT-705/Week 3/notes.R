# Squared differences (with optimization)
y <- c(0.16,2.82,2.24)
x <- c(1,2,3)

optim(par=c(0,0),method = c("Nelder-Mead"),fn=function(beta){sum((y-(beta[1]+beta[2]*x))^2)})

# Absolute Error (with optimization)
optim(par=c(0,0),method = c("Nelder-Mead"),fn=function(beta){sum((abs(y-(beta[1]+beta[2]*x))))})
