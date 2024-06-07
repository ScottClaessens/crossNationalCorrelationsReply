# fit statistical model 3 - instrumental variable model
fitStatModel3 <- function(data) {
  brm(
    formula = mvbrmsformula(
      X ~ 1 + gp(lat, lon, k = 10, c = 5/4),
      Y ~ 1 + X
    ) + set_rescor(rescor = TRUE),
    data = data,
    prior = c(
      prior(normal(0, 1), class = Intercept, resp = X),
      prior(normal(0, 1), class = Intercept, resp = Y),
      prior(normal(0, 1), class = b, resp = Y),
      prior(exponential(1), class = sdgp, resp = X),
      prior(exponential(1), class = sigma, resp = X),
      prior(exponential(1), class = sigma, resp = Y)
    ),
    control = list(adapt_delta = 0.9),
    chains = 4,
    cores = 4
  )
}
