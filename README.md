# Climate Change Concern and Energy Efficient Purchase Intensions

## Overview

This project examines the relationship between climate change concern and intentions to purchase energy-efficient appliances using data from the European Social Survey (ESS) Round 8 climate change and energy module.

The analysis investigates whether the association between climate change concern and energy-efficient purchase intentions operates partly through personal responsibility for reducing climate change. It also examines whether this indirect relationship varies across different levels of household income using a moderated mediation model equivalent to PROCESS Model 7.

## Research Objective

The project examines:

- Whether climate change concern is associated with personal responsibility for reducing climate change.
- Whether personal responsibility is associated with the likelihood of purchasing an energy-efficient appliance.
- Whether climate change concern is directly associated with energy-efficient purchase intentions.
- Whether household income moderates the relationship between climate change concern and personal responsibility.
- Whether the indirect relationship between climate change concern and purchase intentions varies across income levels.

## Conceptual Model

- **X:** Climate change concern (`wrclmch`)
- **M:** Personal responsibility to reduce climate change (`ccrdprs`)
- **Y:** Likelihood of buying an energy-efficient appliance (`eneffap`)
- **W:** Household income decile (`hinctnta`)

The analysis uses a moderated mediation model equivalent to **PROCESS Model 7**, where household income moderates the first-stage relationship between climate change concern and personal responsibility.

## Data

The study uses data from the **European Social Survey (ESS) Round 8**, specifically the climate change and energy module.

The dataset contained 2,582 observations, with 2,089 complete cases used in the moderated mediation analysis.

The analysis is based on cross-sectional, observational data.

## Analysis

The analysis was conducted in R using the following steps:

1. Import and prepare the ESS Round 8 dataset.
2. Select the variables used in the moderated mediation model.
3. Remove incomplete observations.
4. Standardize household income.
5. Create the interaction between climate change concern and income.
6. Estimate a moderated mediation model using the `lavaan` package.
7. Calculate conditional indirect effects at:
   - Low income (-1 SD)
   - Average income
   - High income (+1 SD)
8. Calculate the index of moderated mediation.
9. Estimate a robustness model including a direct path from income to purchase likelihood.
10. Generate visualizations of the moderated relationship and conditional indirect effects.

Bootstrap standard errors and confidence intervals were estimated using 1,000 bootstrap samples.

## Results

The analysis found that climate change concern was positively associated with personal responsibility for reducing climate change.

Personal responsibility was positively associated with the likelihood of purchasing an energy-efficient appliance.

The indirect relationship between climate change concern and energy-efficient purchase intentions through personal responsibility varied across income levels. The results indicated that this indirect pathway became weaker as household income increased.

A robustness check including a direct path from income to purchase likelihood did not substantially change the moderated mediation results.

Because the data are cross-sectional, the findings should be interpreted as associations rather than causal effects.

## Project Structure

```text
Climate-Change-Moderated-Mediation/
│
├── analysis/
│   └── ESS_Model7_Project.R
│
├── data/
│   └── merged-EOSC-ESS8e02_2.sav
│
├── plots/
│   ├── income effect on the indirect pathway.png
│   └── Interaction Plot.png
│
├── report/
│   └── Methods.docx
│
└── README.md
```
## Software
The project was developed using R.

The analysis uses the following packages:

- haven
- lavaan
- ggplot2

## Reproducibility

The R script imports the dataset using a relative file path from the project's data/ folder.

The dataset, analysis script, plots, and project report are organized within the repository to support review and reproducibility.

## Author

Nafia Siddiqui
