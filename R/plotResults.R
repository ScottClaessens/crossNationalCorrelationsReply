# plot results
plotResults <- function(modelList) {
  # get labeller for DAGs
  dags <- c(
    "<img src=img/model4a.png width='100'/>",
    "<img src=img/model4b.png width='100'/>",
    "<img src=img/model5a.png width='100'/>",
    "<img src=img/model5b.png width='100'/>"
  )
  names(dags) <- c(
    "Model 4a",
    "Model 4b",
    "Model 5a",
    "Model 5b"
  )
  controls <- c("Without control for\nnon-independence\n(Y ~ X)",
                "With control for\nnon-independence\n(Y ~ X + Z)",
                "With IV control for\nnon-independence\nfor Model 5a only\n(Y ~ X; X ~ Z)")
  # function for extraction posterior slope
  extractSlope <- function(fit) {
    draws <- as_draws_df(fit)
    if ("b_X" %in% names(draws)) {
      draws$b_X
    } else {
      draws$b_Y_X
    }
  }
  # plot
  out <-
    tibble(
      fit = modelList,
      control = factor(c(rep(controls[1:2], times = 4), controls[3]),
                       levels = controls),
      model = c(rep(c("Model 4a", "Model 4b", "Model 5a", "Model 5b"), each = 2),
                "Model 5a")
    ) %>%
    # extract causal effects
    mutate(slope = map(fit, extractSlope)) %>%
    dplyr::select(-fit) %>%
    unnest(slope) %>%
    # plotting
    ggplot(aes(x = slope, fill = control)) +
    stat_slab(normalize = "panels", alpha = 0.8) +
    geom_vline(xintercept = 0, linetype = "dashed") +
    facet_wrap(. ~ model, labeller = as_labeller(dags),
               scales = "free_x") +
    scale_x_continuous(
      name = "Estimated causal effect of X on Y",
      limits = c(-0.15, 0.68)
    ) +
    guides(fill = guide_legend(byrow = TRUE)) +
    theme_classic() +
    theme(
      axis.line.y = element_blank(),
      axis.title.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(),
      strip.background = element_blank(),
      strip.text = element_markdown(size = 18, padding = unit(c(0, 0, -0.3, 0), "cm")),
      legend.title = element_blank(),
      legend.spacing.y = unit(4, 'mm'),
      legend.position = c(1.25, 0.6),
      plot.margin = margin(0, 4.75, 0.1, 0, "cm"),
      panel.spacing = unit(2, "lines")
    )
  # save
  ggsave(out, filename = "figures/results.pdf", width = 6.5, height = 5)
  return(out)
}
