# simulate data
simulateData <- function(causalModel, n = 2000L, beta = 0) {
  # simulate proximity matrix
  lat <- runif(n)
  lon <- runif(n)
  distMat <- as.matrix(dist(cbind(lat,lon)))
  proxMat <- 1 - (distMat / max(distMat))
  # simulate variables
  if (causalModel == "causalModel4a") {
    # causal model 4a
    # Z -> X -> Y
    Z <- rnorm(n)
    X <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]))
    Y <- rnorm(n, beta*X)
  } else if (causalModel == "causalModel4b") {
    # causal model 4b
    # Z -> X -> Y
    # Z -> U -> Y
    Z <- rnorm(n)
    U <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]))
    X <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]))
    Y <- rnorm(n, beta*X + U)
  } else if (causalModel == "causalModel5a") {
    # causal model 5a
    # Z -> X -> Y
    # X <- U -> Y
    Z <- rnorm(n)
    U <- rnorm(n)
    X <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]) + U)
    Y <- rnorm(n, beta*X + U)
  } else if (causalModel == "causalModel5b") {
    # causal model 5b
    # Z -> X -> Y
    # X <- U1 -> Y
    # Z -> U2 -> Y
    Z  <- rnorm(n)
    U1 <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]))
    U2 <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]))
    X  <- rnorm(n, as.numeric((Z %*% chol(proxMat))[1,]) + U1)
    Y  <- rnorm(n, beta*X + U1 + U2)
  }
  # put together dataset
  data.frame(X, Y, lat, lon)
}
