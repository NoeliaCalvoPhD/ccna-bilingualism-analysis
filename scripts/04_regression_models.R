library(tidyverse)

data <- read_csv("data/processed/neuro_clean.csv")

resilience <- read_csv("data/processed/resilience_scores.csv")

data <- bind_cols(data, resilience)

model <- glm(
  Dementia ~ Resilience * Sex * Bilingualism,
  family = binomial(link = "logit"),
  data = data
)

summary(model)

odds_ratios <- exp(coef(model))

write_csv(
  data.frame(OddsRatio = odds_ratios),
  "results/tables/regression_odds_ratios.csv"
)