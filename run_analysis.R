cat("Installing packages...\n")
source("environment/packages.R")

cat("Step 1: Preprocessing\n")
source("scripts/01_data_preprocessing.R")

cat("Step 2: ANOVA\n")
source("scripts/02_two_way_anova.R")

cat("Step 3: SEM resilience model\n")
source("scripts/03_sem_resilience_model.R")

cat("Step 4: Regression models\n")
source("scripts/04_regression_models.R")

cat("Pipeline completed successfully.\n")