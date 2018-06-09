rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("./SomethingSomething.R")

# ---- load-packages -----------------------------------------------------------
library(magrittr) #Pipes
library(ggplot2) #For graphing
requireNamespace("dplyr")
# requireNamespace("tidyr") #For converting wide to long
# requireNamespace("RColorBrewer")
# requireNamespace("scales") #For formating values in graphs
# requireNamespace("mgcv) #For the Generalized Additive Model that smooths the longitudinal graphs.
requireNamespace("TabularManifest") # devtools::install_github("Melinae/TabularManifest")

# ---- declare-globals ---------------------------------------------------------
options(show.signif.stars=F) #Turn off the annotations on p-values

path_input <- "data-public/derived/survey-response.rds"
include_year_first     <- 2012L

theme_report <- theme_bw() +
  theme(axis.ticks.length     = grid::unit(0, "cm")) +
  theme(axis.text             = element_text(colour="gray40")) +
  theme(axis.title            = element_text(colour="gray40")) +
  theme(panel.border          = element_rect(colour="gray80")) +
  theme(axis.ticks            = element_line(colour="gray80"))

# ---- load-data ---------------------------------------------------------------
ds_everyone <- readr::read_rds(path_input) # 'ds' stands for 'datasets'

# ---- tweak-data --------------------------------------------------------------
ds_everyone <- ds_everyone %>%
  dplyr::mutate(
    officer_rate_f    = factor(officer_rate)
  )

ds <- ds_everyone %>%
  tidyr::drop_na(year_executed_order) %>%
  dplyr::filter(year_executed_order >= include_year_first)
# ds <- ds %>%
#   tidyr::drop_na(infant_weight_for_gestational_age_category) %>%
#   dplyr::mutate(
#     clinic = droplevels(clinic)
#   ) %>%
#   dplyr::filter(
#     !ds$premature_infant
#   ) %>%
#   dplyr::select(
#     -premature_infant
#   )

# ---- marginals ---------------------------------------------------------------
TabularManifest::histogram_discrete(d_observed=ds, variable_name="primary_specialty")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="officer_rank")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="officer_rate")
TabularManifest::histogram_continuous(d_observed=ds, variable_name="year_executed_order", bin_width=1, rounded_digits=1)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="billet_current")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="order_lead_time")


TabularManifest::histogram_continuous(d_observed=ds, variable_name="transparency_rank"         , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="satistfaction_rank"        , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="favoritism_rank"           , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="assignment_current_choice" , bin_width=1, rounded_digits=1)
# This helps start the code for graphing each variable.
#   - Make sure you change it to `histogram_continuous()` for the appropriate variables.
#   - Make sure the graph doesn't reveal PHI.
#   - Don't graph the IDs (or other uinque values) of large datasets.  The graph will be worth and could take a long time on large datasets.
# for(column in colnames(ds)) {
#   cat('TabularManifest::histogram_discrete(ds, variable_name="', column,'")\n', sep="")
# }

# ---- scatterplots ------------------------------------------------------------

ggplot(ds, aes(x=officer_rank, y=satistfaction_rank)) + #, color=officer_rank)) +
  geom_boxplot() +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=officer_rank, y=satistfaction_rank, fill=officer_rank, color=officer_rank)) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL, y="Satisfaction")



ggplot(ds, aes(x=year_executed_order, y=transparency_rank)) + #, color=officer_rank)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_smooth(data=ds[ds$year_executed_order >=2014L, ], method="loess", span=2, na.rm=T) +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

last_plot() %+% aes(y=satistfaction_rank)
last_plot() %+% aes(y=favoritism_rank)
last_plot() %+% aes(y=assignment_current_choice)




# ---- models ------------------------------------------------------------------

cat("============= Model includes one predictor. =============")
# m1 <- lm(satistfaction_rank ~ 1 + officer_rank, data=ds)
m1 <- lm(satistfaction_rank ~ 1 + officer_rate_f, data=ds)
summary(m1)


# m2 <- lm(satistfaction_rank ~ 1 + primary_specialty, data=ds)
# summary(m2)
#
# cat("The one predictor is significantly tighter.")
# anova(m0, m1)
#
# cat("============= Model includes two predictors. =============")
# m2 <- lm(quarter_mile_in_seconds ~ 1 + miles_per_gallon + forward_gear_count_f, data=ds)
# summary(m2)
#
# cat("The two predictor is significantly tighter.")
# anova(m1, m2)
#
# # ---- model-results-table  -----------------------------------------------
#
# summary(m2)$coef %>%
#   knitr::kable(
#     digits      = 2,
#     format      = "markdown"
#   )

# Uncomment the next line for a dynamic, JavaScript [DataTables](https://datatables.net/) table.
# DT::datatable(round(summary(m2)$coef, digits = 2), options = list(pageLength = 2))
