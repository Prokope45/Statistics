beta0 <- -0.34
beta1 <- 1.04
x <- seq(0, 3, length.out = 300)
y <- beta0 + beta1 * x^2

plot(
  x, y,
  type = "l",
  col = "purple",
  lwd = 2,
  xlab = "x",
  ylab = "Predicted y",
  main = "Model 1"
)

beta1 <- 1.04
x <- seq(0, 3, length.out = 300)
y <- beta1 * exp(x)

plot(
  x, y,
  type = "l",
  col = "purple",
  lwd = 2,
  xlab = "x",
  ylab = "Predicted y",
  main = "Model 2"
)

beta0 <- -0.34
beta1 <- 1.04
x <- seq(0, 3, length.out = 300)
y <- beta0 * exp(beta1*x)

plot(
  x, y,
  type = "l",
  col = "purple",
  lwd = 2,
  xlab = "x",
  ylab = "Predicted y",
  main = "Model 2"
)

beta0 <- -0.34
beta1 <- 1.04
x <- seq(0, 3, length.out = 300)
y <- beta0 + exp(beta1*x)

plot(
  x, y,
  type = "l",
  col = "purple",
  lwd = 2,
  xlab = "x",
  ylab = "Predicted y",
  main = "Model 3"
)


beta0 <- -0.34
beta1 <- 1.04
x <- seq(0, 3, length.out = 300)
y <- beta0 + exp(log(beta1))*x
# Or
# y <- beta0 + beta1 * x

plot(
  x, y,
  type = "l",
  col = "purple",
  lwd = 2,
  xlab = "x",
  ylab = "Predicted y",
  main = "Model 4"
)
