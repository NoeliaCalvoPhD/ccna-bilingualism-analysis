############################################################
# 03_sem_resilience_model.R
# Structural Equation Model estimating latent resilience
# (Cognition) and extracting individual predictor contributions
############################################################

library(tidyverse)
library(lavaan)
library(semPlot)
library(caret)

cat("Loading processed dataset...\n")

data <- read_csv("data/processed/neuro_clean.csv")

############################################################
# STEP 1 — Standardize variables
############################################################

cat("Standardizing variables...\n")

trans <- preProcess(data, method = "scale")
data_scaled <- predict(trans, data)

############################################################
# STEP 2 — Define SEM model
############################################################

cat("Defining SEM model...\n")

model_sem <- '

# Latent resilience factor
Cognition =~ Visuospatial_Memory_delayed +
             Digit_Symbol +
             TMT_A +
             TMT_B

# Structural predictors
Cognition ~ E2 + TFCI + L2_proficiency + Female_Sex

# Covariates
Cognition ~~ Age + Education + Immigration

# Additional covariance
L2_proficiency ~~ Immigration

'

############################################################
# STEP 3 — Fit SEM model
############################################################

cat("Fitting SEM model...\n")

fit <- sem(
  model_sem,
  data = data_scaled,
  se = "boot",
  bootstrap = 100
)

############################################################
# STEP 4 — Model summary
############################################################

cat("SEM model summary:\n")

summary(
  fit,
  standardized = TRUE,
  fit.measures = TRUE
)

############################################################
# STEP 5 — Extract latent resilience scores
############################################################

cat("Extracting latent cognition scores...\n")

factor_scores <- lavPredict(fit)

data$Cognition <- factor_scores[, "Cognition"]

write_csv(
  data.frame(Cognition = data$Cognition),
  "data/processed/resilience_scores.csv"
)

############################################################
# STEP 6 — Extract standardized path coefficients
############################################################

cat("Extracting standardized path coefficients...\n")

regression_weights <- standardizedSolution(fit)

predictors <- c(
  "E2",
  "TFCI",
  "L2_proficiency",
  "Female_Sex"
)

############################################################
# STEP 7 — Compute individual predictor contributions
############################################################

cat("Computing individual contributions...\n")

individual_contributions <- data.frame(
  Participant_ID = 1:nrow(data)
)

for (predictor in predictors) {

  coef <- regression_weights[
    regression_weights$lhs == "Cognition" &
    regression_weights$rhs == predictor,
    "est.std"
  ]

  if(length(coef) > 0 && !is.na(coef)) {

    individual_contributions[[predictor]] <-
      data[[predictor]] * coef

  } else {

    individual_contributions[[predictor]] <- NA

  }
}

############################################################
# STEP 8 — Save contributions
############################################################

write_csv(
  individual_contributions,
  "results/tables/individual_resilience_contributions.csv"
)

############################################################
# STEP 9 — Plot SEM model
############################################################

cat("Saving SEM diagram...\n")

pdf("results/figures/sem_resilience_model.pdf")

semPlot::semPaths(
  fit,
  "std",
  layout = "tree",
  edge.label.cex = 0.9,
  sizeMan = 7,
  sizeLat = 9
)

dev.off()

############################################################

cat("SEM resilience model complete.\n")