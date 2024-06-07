# fit statistical model 1 - no control
fitStatModel1 <- function(data) {
  brm(
    formula = Y ~ X,
    data = data,
    prior = c(
      prior(normal(0, 1), class = Intercept),
      prior(normal(0, 1), class = b),
      prior(exponential(1), class = sigma)
    ),
    control = list(adapt_delta = 0.9),
    chains = 4,
    cores = 4
  )
}
