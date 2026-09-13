# ESS Round 8: Exploratory Moderated Mediation Analysis
#
# X = Climate concern (wrclmch)
# M = Personal responsibility to reduce climate change (ccrdprs)
# Y = Likelihood of buying an energy-efficient appliance (eneffap)
# W = Household income decile (hinctnta)
#
# Model: Moderated mediation (PROCESS Model 7 equivalent)
# Data: ESS Round 8 climate-change module subset
# Analysis: Cross-sectional, observational, unweighted
#
# Project purpose:
# To examine whether the association between climate concern and
# energy-efficient purchase likelihood operates partly through
# personal responsibility, and whether this indirect pathway
# varies by income.

library(haven)
library(lavaan)
library(ggplot2)

merged_EOSC_ESS8e02_2 <- read_sav("data/merged-EOSC-ESS8e02_2.sav")
analysis_data <- merged_EOSC_ESS8e02_2[c(
  "wrclmch",
  "ccrdprs",
  "eneffap",
  "hinctnta",
  "anweight"
)]
model_data <- na.omit(
  analysis_data[c("wrclmch", "ccrdprs", "eneffap", "hinctnta", "anweight")]
)
w_c <- model_data$hinctnta - mean(model_data$hinctnta)
w_z <- w_c / sd(w_c)
XWz <- model_data$wrclmch * w_z
model_data$w_z <- w_z
model_data$XWz <- XWz
model_mm <- "ccrdprs ~ a1*wrclmch + a2*w_z + a3*XWz
eneffap ~ b1*ccrdprs + cprime*wrclmch
indirect_low := (a1 + a3*(-1))*b1
indirect_mean := a1*b1
indirect_high := (a1 + a3*(1))*b1
index_mod_med := a3*b1"
fit_mm <- sem(
  model = model_mm,
  data = model_data,
  se = "bootstrap",
  bootstrap = 1000
)
summary(fit_mm, standardized = TRUE, ci = TRUE)
fitMeasures(
  fit_mm,
  c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr")
)
resid_mm <- residuals(fit_mm, type = "cor")
resid_mm$cov
model_robust <- "ccrdprs ~ a1*wrclmch + a2*w_z + a3*XWz
eneffap ~ b1*ccrdprs + cprime*wrclmch + d1*w_z
indirect_low := (a1 + a3*(-1))*b1
indirect_mean := a1*b1
indirect_high := (a1 + a3*(1))*b1
index_mod_med := a3*b1"
fit_robust <- sem(
  model = model_robust,
  data = model_data,
  se = "bootstrap",
  bootstrap = 1000
)
summary(fit_robust, standardized = TRUE, ci = TRUE)
library(ggplot2)

plot_model <- lm(ccrdprs ~ wrclmch * w_z, data = model_data)

plot_data <- expand.grid(
  wrclmch = seq(1, 5, length.out = 100),
  w_z = c(-1, 0, 1)
)

plot_data$predicted_M <- predict(plot_model, newdata = plot_data)

ggplot(plot_data, aes(x = wrclmch, y = predicted_M, group = w_z)) +
  geom_line(aes(linetype = factor(w_z)), linewidth = 1) +
  labs(
    x = "Climate concern",
    y = "Predicted personal responsibility",
    linetype = "Income"
  )
indirect_plot <- data.frame(
  income = c(-1, 0, 1),
  indirect_effect = c(0.139, 0.122, 0.105)
)

ggplot(indirect_plot, aes(x = income, y = indirect_effect)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    x = "Income",
    y = "Indirect effect",
    title = "Conditional indirect effect of climate concern on green purchase likelihood"
  )

summary(model_data[c("wrclmch", "ccrdprs", "eneffap", "hinctnta")])
cor(model_data[c("wrclmch", "ccrdprs", "eneffap", "hinctnta")])
