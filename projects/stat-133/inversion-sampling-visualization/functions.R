# inverse exp cdf
expon <- function(x) pexp(x, rate = 3)
invexpon <- inverse(expon, lower = 0, upper = Inf)

# inverse normal cdf
stnorm <- function(x) pnorm(x, mean = 0, sd = 1)
invnorm <- inverse(stnorm)

# inverse beta cdf
beta23 <- function(x) pbeta(x, shape1 = 2, shape2 = 3)
invbeta23 <- inverse(beta23, lower = 0, upper = 1)

# inverse gamma cdf
gamma6 <- function(x) pgamma(x, shape = 3, scale = 0.05)
invgamma6 <- inverse(gamma6, lower = 0, upper = Inf)
