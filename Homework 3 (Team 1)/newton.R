# helper functions to reduce repeated code when calculating hessian
fin.dif.g = function(theta, f, ..., eps = 1e-8){
  # function for finite differencing of gradient if hessian is not available as attribute of f
  g = attr(f(theta, ...), "gradient")
  p = length(theta)
  E = diag(p)
  H = matrix(0, nrow = p, ncol = p)
  for(i in 1:p){
    H[, i] = (attr(f(theta + eps * E[, i], ...), "gradient") - g) / eps
  }
  return(H)
}

pos.def.check = function(H, eps = 1e-8){
  # function to check if positive definite hessian and perturb if not
  p = nrow(H)
  while(!is.matrix(try(chol(H), silent = TRUE))){
    # if matrix is not positive definite chol throws an error,
    # we catch this and perturb it until perturbed h is positive definite
    m = max(abs(H))
    H = H + eps * m * diag(p)
    eps = eps * 10
  }
  return(H)
}

hessian = function(theta, f, ..., hess.bool){
  # function calculates the hessian for given function and theta value
  # Once calculated by finite differencing gradient or obtained if available
  # we ensure it is positive definite
  p = length(theta)
  if(hess.bool){
    H = matrix(cbind(attr(f(theta, ...), "hessian")), p)
  }
  else{
    H = fin.dif.g(theta, f, ...)
    H = 0.5 * (t(H) + H)
  }
  H = pos.def.check(H)
  return(H)
}

hess.inv = function(H){
  # Function to calculate the inverse of the hessian matrix
  R = chol(H)
  p = nrow(H)
  A = forwardsolve(t(R), diag(p))
  Hi = backsolve(R, A)
  return(Hi)
}


newton = function(theta, f, ..., tol = 1e-8, fscale = 1, maxit = 100, max.half = 20){
  # Newton optimization method
  # Function minimises f iteratively by the newton method starting at initial value, theta

  ### Initial checks to ensure inputs are as expected

  # if theta is not a numeric vector throw an error!
  if(!is.numeric(theta)){
    stop(cat("A numeric theta input is required! \n"))
  }

  # if tol is not a numeric value or is negative throw an error!
  if(!is.numeric(tol)|tol < 0){
    stop(cat("A positive numeric tol input is required! \n"))
  }

  # if fscale is not a numeric value or is negative throw an error!
  if(!is.numeric(fscale)|fscale < 0){
    stop(cat("fscale is a rough estimate of the magnitude of f at the optimum. \n A positive numeric input is required! \n"))
  }

  # if maxit is not a positive integer value throw an error!
  if(!is.numeric(maxit)|maxit %% 1 != 0 | maxit < 1){
    stop(cat("A positive integer maxit input is required! \n"))
  }

  # if theta is not a positive integer value throw an error!
  if(!is.numeric(max.half)|max.half %% 1 != 0 | max.half < 1){
    stop(cat("A positive integer max.half input is required! \n"))
  }

  ### Define initial values and check existence and finiteness where necessary

  th1 = theta
  p = length(th1) # p is the number of parameters
  f1 = f(th1, ...) # store initial value of objective function

  # check initial function value is finite
  if(!is.finite(f1)){
    stop(cat("Objective function is not finite at inital value of theta (", th1, "). \n"))
  }

  # if there is no gradient as attribute throw an error as specification defines it should be present
  if(!("gradient" %in% names(attributes(f(th1, ...))))){
    stop(cat("Objective function does not have a gradient attribute as required in specification \n"))
  }

  g1 = attr(f(th1, ...), "gradient")  # store the gradient of function

  # check initial gradient value is finite
  if(!all(is.finite(g1))){
    stop(cat("Gradients are not finite at inital value of theta (", th1, "). \n"))
  }

  hess.bool = "hessian" %in% names(attributes(f(th1, ...))) #boolean stating if hessian has been supplied (used to determine which method to ascertain hessian in 'hessian' function)
  H1 = hessian(th1, f, ..., hess.bool = hess.bool)
  Hi1 = hess.inv(H1)

  ### iterative optimization for loop - the juice of the function
  for(i in 1:maxit){

    # define initial values for this iteration
    th0 = th1
    f0 = f1
    g0 = g1
    H0 = H1
    Hi0 = Hi1

    # iterative step to calculate an updated theta with halving steps if required
    for(j in 0:max.half){
      th1 = th0 - ((1/2)^j) * Hi0 %*% t(g0) # halves step with each iteration (at j=0 we just have initial optimization step)
      f1 = f(th1, ...)
      g1 = attr(f(th1, ...), "gradient")

      # break if objective function value is finite and has been reduced and if we have finite derivatives
      if(f1<f0 & is.finite(f1) & all(is.finite(g1))){
        break
      }

      # throws an error if we reach max number of halving iterations
      if(j == max.half){
        stop(cat("The iteration step ", i, " has failed to reduce the objective function after", max.half, "steps of halving iterations. \n"))
      }
    } # max half for loop

    # calculate hessian for updated parameters
    H1 = hessian(th1, f, ..., hess.bool = hess.bool)
    Hi1 = hess.inv(H1)

    # break for loop if convergence criterion is met
    if(max(abs(g1)) < (abs(f1) + fscale) * tol){
      break
    }

    # throws error if we reach max number of iterations
    if(i == maxit){
      stop(cat("Newton's method has failed to optimise your function in ", maxit," iterations \n"))
    }

  } # maxit for loop

  # remove redundant attributes of f1
  attr(f1, "gradient") = NULL
  attr(f1, "hessian") = NULL

  return(list(f = f1, theta = th1, iter = i, g = g1, Hi = Hi1))
} # newton function

