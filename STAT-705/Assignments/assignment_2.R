# Set up A, B, and C matrices
A <- matrix(
	c(1, 2, 3, 2, 6, 6, 3, 6, 9),
	nrow=3,
	ncol=3
)
A
B <- matrix(
	c(1, 0, 0, 0, 1, 0, 0, 0, 1),
	nrow=3,
	ncol=3
)  # Identity matrix
B
C <- t(A)  # Transpose returns same structure (unchanged)
C

# Answer questions:
# 1. A + C
A + C
# 2. A - C
A - C
# 3. A * B
A %*% B  # Should show same matrix as A
# 4. (A + B)^-1 (C + B)
solve(A + B) %*% (C + B)


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
	ylab = "Predicted y"
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
	ylab = "Predicted y"
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
y <- beta0 + beta1 * x

plot(
	x, y,
	type = "l",
	col = "purple",
	lwd = 2,
	xlab = "x",
	ylab = "Predicted y",
	main = "Model 4"
)
