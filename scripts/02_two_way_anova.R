library(tidyverse)

data <- read_csv("data/processed/neuro_clean.csv")

numeric_vars <- data %>%
  select(where(is.numeric)) %>%
  colnames()

anova_results <- list()

for(var in numeric_vars){

  formula <- as.formula(paste(var, "~ Sex * Bilingualism"))

  model <- aov(formula, data = data)

  anova_table <- summary(model)

  anova_results[[var]] <- anova_table

}

saveRDS(anova_results, "results/tables/anova_results.rds")