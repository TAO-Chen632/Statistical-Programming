source("newton.R")

# define rosenbrocks function
rb0 <- function(theta, k){
  z <- theta[1] ; x <- theta[2]
  k * (z - x^2)^2 + (1 - x)^2
} # rb0

# derive rosenbrocks function because we need this for having the gradient and hessian as attributes
rb = deriv(expression(k * (z - x^2)^2 + (1 - x)^2), c("z", "x"), function.arg = c("z", "x", "k"), hessian = TRUE)

# rb1 for testing when hessian is given
rb1 <- function(theta, k){
# wrapper function
  value = rb(theta[1], theta[2], k)
  value
} # rb1

# rb2 for testing when hessian is not given
rb2 <- function(theta, k){
  # wrapper function
  value = rb(theta[1], theta[2], k)
  # remove the attribute "hessian", because this function is to test the
  # the newton() function when hessian is not given
  attr(value, "hessian") = NULL
  value
} # rb2


# define a starting point to use as illustrative example (given in readme).
th0 = c(-.5, 2)

# Testing:

# with hessian given:
newton(th0, rb1, k = 10)
# without hessian given:
newton(th0, rb2, k = 10)

# Other testing:
#newton(c(2, 5), rb1, k = 50)
#newton(c(2, 5), rb2, k = 50)
#newton(c(-10, 10), rb1, k = 100)
#newton(c(-10, 10), rb2, k = 100)
#newton(c(2.32, 6.45), rb1, k = 39.56)
#newton(c(2.32, 6.45), rb2, k = 39.56)

# Further testing outcommented so the files pass the tests in the readme!

# when the minimization point is not unique
#newton(c(2, 3), rb1, k = 0)
#newton(c(2, 3), rb2, k = 0)

# when the minimization does not exist
#newton(c(2, 2), rb1, k = -5)
#newton(c(2, 2), rb2, k = -5)

# Showing error messages with "wrong" input:
#newton(c(3, 5), rb1, k = 10, maxit = 16.5)
#newton(c(3, 4), rb1, k = 8, max.half = 20.6)
#newton(c(3, 5), rb1, k = 12, maxit = '18.5')
#newton(c(3, 4), rb1, k = 6, max.half = '24.3')
#newton(c('a', 'b'), rb1, k = 10)
#newton(c(3, 5), rb1, k = 10, tol = 't')
#newton(c(3, 5), rb1, k = 10, fscale = 'f')
# should be the same for rb2!

# If Hessian is not positive-definite:
# chol(matrix(cbind(attr(rb1(c(1, -0.5), k = 10), "hessian")), 2))
# newton(c(1, -0.5), rb1, k = 10)
# optim(c(1, -0.5), rb0, k = 10)
# x <- seq(-10, 10, 0.001)
# y <- 10 * (1 - x^2)^2 + (1 - x)^2
# plot(x, y, type = "l")

