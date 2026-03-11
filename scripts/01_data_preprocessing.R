library(tidyverse)
library(mice)

cat("Loading raw COMPASS dataset...\n")

raw_data <- read_csv("data/raw/compass_export.csv")

cat("Checking missing data...\n")

md.pattern(raw_data)

cat("Running multiple imputation...\n")

imp <- mice(raw_data, method = "pmm", seed = 123)

data_clean <- complete(imp)

data_clean <- data_clean %>%
  mutate(
    Sex = as.factor(Sex),
    Bilingualism = as.factor(Bilingualism)
  )  ###please add relevant neuropsychological, and clinical variables######

write_csv(data_clean, "data/processed/neuro_clean.csv")

cat("Data preprocessing complete.\n")
