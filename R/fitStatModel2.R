# fit statistical model 2 - with autocorrelation control
fitStatModel2 <- function(data) {
  brm(
    formula = Y ~ X + gp(lat, lon, k = 10, c = 5/4),
    data = data,
    prior = c(
      prior(normal(0, 1), class = Intercept),
      prior(normal(0, 1), class = b),
      prior(exponential(1), class = sdgp),
      prior(exponential(1), class = sigma)
    ),
    control = list(adapt_delta = 0.9),
    chains = 4,
    cores = 4
  )
}
