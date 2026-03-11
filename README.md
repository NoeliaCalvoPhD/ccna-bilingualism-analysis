# CCNA Bilingualism/biological sex Resilience Analysis

This repository contains a reproducible statistical analysis pipeline examining relationships between bilingualism, biological sex, and dementia-related outcomes using data from the COMPASS-ND cohort of the Canadian Consortium on Neurodegeneration in Aging (CCNA).

The analysis includes:

• data preprocessing and imputation
• two-way ANOVA analyses
• structural equation modeling (SEM) to estimate a latent resilience factor
• regression models examining dementia outcomes

---

# Repository Structure

```
ccna-bilingualism-analysis

README.md
run_analysis.R
.gitignore

scripts/
   01_data_preprocessing.R
   02_two_way_anova.R
   03_sem_resilience_model.R
   04_regression_models.R

environment/
   packages.R

data/
   raw/
   processed/

results/
   tables/
   figures/
```

---

# Data Availability

The dataset used in this study comes from the COMPASS-ND cohort of the Canadian Consortium on Neurodegeneration in Aging (CCNA).

Due to participant privacy and data use agreements, the data cannot be redistributed through this repository. Qualified researchers may request access through CCNA.

After obtaining the dataset, place the raw export files in:

```
data/raw/
```

---

# Running the Analysis

To reproduce the full analysis pipeline:

```
Rscript run_analysis.R
```

The pipeline automatically performs:

1. data preprocessing and imputation
2. statistical analyses
3. structural equation modeling
4. generation of tables and figures

---

# SEM Model

The resilience construct is estimated as a latent factor using structural equation modeling with the `lavaan` package.

Latent factor:

```
Cognition =~ Visuospatial_Memory_delayed +
             Digit_Symbol +
             TMT_A +
             TMT_B
```

Individual resilience scores are extracted using:

```
lavPredict()
```

---

# Software Requirements

The analysis requires R and the following packages:

* tidyverse
* mice
* lavaan
* semPlot
* caret
* car

All dependencies are automatically installed by the pipeline.

---

# Outputs

The pipeline generates:

```
results/tables/
results/figures/
```

including statistical summaries and SEM visualizations.

---

# Citation

If you use this code or reproduce this analysis, please cite the associated publication and the CCNA/COMPASS-ND dataset.

---

# Author

Noelia Calvo
