source("newton.R")
source("rosenbrock.R")

#f1 <- function(theta){
  # define function
#  z <- theta[1] ; x <- theta[2]
#  3*(z^2) + (1-x)^2
#}

#f2 <- function(theta, a, b){
  # define function
#  z <- theta[1] ; x <- theta[2]
#  z^3+ 3*x + 2*a^2 + 4*b
#}

#f3 <- function(theta,b){
#  x <- theta[1] ; a <- theta[2]
#  (x-a)^3 + a(x-b)^2
#}

# Testing:


#need to run testing functions through deriv to obtain gradient vector (or do it by hand)
#g0_1 = deriv(expression(3*(z^2) + (1-x)^2), c( "z", "x"), function.arg = c( "z", "x"), hessian = TRUE)

#g1_1 <- function(theta){
  # wrapper function
#  g0_1(theta[1], theta[2])
#} # g1_1

#g0_2 = deriv(expression(z^3+ 3*x + 2*a^2 + 4*b), c( "z", "x"),
#             function.arg = c("z", "x", "a", "b"), hessian = TRUE)

#g1_2 <- function(theta, a, b){
  # wrapper function
#  g0_2(theta[1], theta[2], a, b)
#} # g1_2


#g0_3 = deriv(expression((x-a)^3 + (b*x-a)^2), c("x", "a"),
#             function.arg = c("x", "a", "b"), hessian = TRUE)

#g1_3 <- function(theta,b){
  # wrapper function
#  g0_3(theta[1], theta[2], b)
#} # g1_3

# Testing:

#newton(c(-.5, 5), g1_1)
#If Newton's method has failed to optimise
#newton(c(-.5,1), g1_2, a=3, b=1)
#newton(c(-2,3), g1_3, b=20)

