library(targets)
library(tarchetypes)
library(tidyverse)
tar_option_set(
  packages = c("brms","ggdist","ggtext","MASS","papaja","tidyverse"),
  memory = "transient",
  garbage_collection = TRUE
  )
tar_source()

# pipeline
list(
  # simulate data from generative causal models
  tar_map(
    values = tibble(
      causalModel = c("causalModel4a","causalModel4b",
                      "causalModel5a","causalModel5b")
      ),
    tar_target(data, simulateData(causalModel))
  ),
  # fit statistical model 1
  tar_target(fit_statModel1_causalModel4a, fitStatModel1(data_causalModel4a)),
  tar_target(fit_statModel1_causalModel4b, fitStatModel1(data_causalModel4b)),
  tar_target(fit_statModel1_causalModel5a, fitStatModel1(data_causalModel5a)),
  tar_target(fit_statModel1_causalModel5b, fitStatModel1(data_causalModel5b)),
  # fit statistical model 2
  tar_target(fit_statModel2_causalModel4a, fitStatModel2(data_causalModel4a)),
  tar_target(fit_statModel2_causalModel4b, fitStatModel2(data_causalModel4b)),
  tar_target(fit_statModel2_causalModel5a, fitStatModel2(data_causalModel5a)),
  tar_target(fit_statModel2_causalModel5b, fitStatModel2(data_causalModel5b)),
  # fit statistical model 3
  tar_target(fit_statModel3_causalModel5a, fitStatModel3(data_causalModel5a)),
  # plot results
  tar_target(plot, plotResults(list(fit_statModel1_causalModel4a,
                                    fit_statModel2_causalModel4a,
                                    fit_statModel1_causalModel4b,
                                    fit_statModel2_causalModel4b,
                                    fit_statModel1_causalModel5a,
                                    fit_statModel2_causalModel5a,
                                    fit_statModel1_causalModel5b,
                                    fit_statModel2_causalModel5b,
                                    fit_statModel3_causalModel5a))),
  # manuscript
  tar_render(manuscript, "manuscript.Rmd"),
  # session info
  tar_target(sessionInfo, writeLines(capture.output(sessionInfo()), "sessionInfo.txt"))
)
