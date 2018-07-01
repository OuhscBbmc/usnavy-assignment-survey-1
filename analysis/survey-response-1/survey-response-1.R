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

TabularManifest::histogram_continuous(d_observed=ds, variable_name="survey_lag", bin_width = .5,  rounded_digits = 1)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="billet_current")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="order_lead_time")


TabularManifest::histogram_continuous(d_observed=ds, variable_name="transparency_rank"         , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="satistfaction_rank"        , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="favoritism_rank"           , bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(d_observed=ds, variable_name="assignment_current_choice" , bin_width=1, rounded_digits=1)

TabularManifest::histogram_continuous(d_observed=ds, variable_name="bonus_pay" , bin_width=5000, rounded_digits=1)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="bonus_pay_cut3")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="bonus_pay_cut4")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="critical_war")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="specialty_type")

TabularManifest::histogram_continuous(d_observed=ds, variable_name="manning_proportion" , bin_width=.05, rounded_digits=2)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="manning_proportion_cut3")


# This helps start the code for graphing each variable.
#   - Make sure you change it to `histogram_continuous()` for the appropriate variables.
#   - Make sure the graph doesn't reveal PHI.
#   - Don't graph the IDs (or other uinque values) of large datasets.  The graph will be worth and could take a long time on large datasets.
# for(column in colnames(ds)) {
#   cat('TabularManifest::histogram_discrete(ds, variable_name="', column,'")\n', sep="")
# }

######## Outcome Relationships ##########################################################


# ---- outcome-correlations ----------------------------------------------------
outcomes <- c("satistfaction_rank", "transparency_rank", "favoritism_rank", "assignment_current_choice")
knitr::kable(corHyp1 <- cor(ds[, outcomes], use = "pairwise.complete.obs"))
corrplot::corrplot(corHyp1, method="ellipse", addCoef.col="gray30", tl.col="gray20", diag=F, order="AOE")
pairs(x=ds[, outcomes], lower.panel=panel.smooth, upper.panel=panel.smooth)

######## Univariate ##########################################################

# ---- by-rank ------------------------------------------------------------

cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=officer_rank, y=satistfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + officer_rate_f, data=ds))



cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + officer_rate_f, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + officer_rate_f, data=ds))

cat("### assignment_current_choice\n\n")
last_plot() %+% aes(y=assignment_current_choice) +
  scale_y_reverse()
summary(lm(assignment_current_choice ~ 1 + officer_rate_f, data=ds))



# ---- by-specialty-type ------------------------------------------------------------

cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(specialty_type) %>%
  dplyr::filter(specialty_type != "unknown") %>%
  ggplot(aes(x=specialty_type, y=satistfaction_rank, fill=specialty_type, color=specialty_type)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + specialty_type, data=ds[ds$specialty_type != "unknown", ]))



cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + specialty_type, data=ds[ds$specialty_type != "unknown", ]))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + specialty_type, data=ds[ds$specialty_type != "unknown", ]))

cat("### assignment_current_choice\n\n")
last_plot() %+% aes(y=assignment_current_choice) +
  scale_y_reverse()
summary(lm(assignment_current_choice ~ 1 + specialty_type, data=ds[ds$specialty_type != "unknown", ]))


# ---- by-bonus-pay ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(bonus_pay_cut4) %>%
  dplyr::filter(bonus_pay_cut4 != "unknown") %>%
  ggplot(aes(x=bonus_pay_cut4, y=satistfaction_rank, fill=bonus_pay_cut4, color=bonus_pay_cut4)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + bonus_pay_cut4, data=ds))



cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + bonus_pay_cut4, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + bonus_pay_cut4, data=ds))

cat("### assignment_current_choice\n\n")
last_plot() %+% aes(y=assignment_current_choice) +
  scale_y_reverse()
summary(lm(assignment_current_choice ~ 1 + bonus_pay_cut4, data=ds))

# ---- by-assignment-current-choice ------------------------------------------------------------

cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(assignment_current_choice) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=assignment_current_choice, y=satistfaction_rank)) +
  geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  theme_report# +

summary(lm(satistfaction_rank ~ 1 + assignment_current_choice, data=ds))


cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + assignment_current_choice, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + assignment_current_choice, data=ds))


# ---- by-year ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=year_executed_order, y=satistfaction_rank)) + #, color=officer_rank)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_smooth(data=ds[ds$year_executed_order >=2014L, ], method="loess", span=2, na.rm=T) +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

# ---- by-survey_lag ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=survey_lag, y=satistfaction_rank)) + #, color=officer_rank)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_smooth(data=ds[ds$survey_lag >=2014L, ], method="loess", span=2, na.rm=T) +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

# ---- by-manning_proportion ------------------------------------------------------------
cat("### manning_proportion\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=manning_proportion, y=satistfaction_rank)) + #, color=officer_rank)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_smooth(data=ds[ds$survey_lag >=2014L, ], method="loess", span=2, na.rm=T) +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=manning_proportion_cut3, y=satistfaction_rank, color=manning_proportion_cut3)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")

# ---- by-critical_war ------------------------------------------------------------
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=critical_war, y=satistfaction_rank, color=critical_war)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")

# ---- by-billet_current ------------------------------------------------------------
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
# billet_current = forcats::fct_reorder(billet_current, satistfaction_rank, .fun=mean)

ggplot(ds, aes(x=billet_current, y=satistfaction_rank, color=billet_current)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  scale_x_discrete(limits = rev(levels(ds$billet_current))) +
  coord_flip(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")

# forcats::fct_reorder(ds$billet_current, ds$satistfaction_rank, .fun=mean)
summary(lm(satistfaction_rank ~ 1 + billet_current, data=ds))



######## Multivariate ##########################################################

# ---- by-rank-and-specialty-type ------------------------------------------------------------

cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(specialty_type) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(specialty_type != "unknown") %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=specialty_type, y=satistfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  # theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + officer_rate_f * specialty_type, data=ds[ds$specialty_type != "unknown", ]))
summary(lm(satistfaction_rank ~ 1 + officer_rate_f + specialty_type, data=ds[ds$specialty_type != "unknown", ]))

cat("TODO: examine if the interaction term significantly improves fit.")



cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + specialty_type, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + specialty_type, data=ds))

cat("### assignment_current_choice\n\n")
last_plot() %+% aes(y=assignment_current_choice) +
  scale_y_reverse()
summary(lm(assignment_current_choice ~ 1 + specialty_type, data=ds))


# ---- by-rank-and-assignment-current-choice ------------------------------------------------------------

cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(assignment_current_choice) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=assignment_current_choice, y=satistfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  # geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  # stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report# +
# theme(legend.position="none") +
# labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + officer_rate_f + assignment_current_choice, data=ds))
summary(lm(satistfaction_rank ~ 1 + officer_rate_f * assignment_current_choice, data=ds))

anova(
  lm(satistfaction_rank ~ 1 + officer_rate_f + assignment_current_choice, data=ds),
  lm(satistfaction_rank ~ 1 + officer_rate_f * assignment_current_choice, data=ds)
)


cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + officer_rate_f * assignment_current_choice, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + officer_rate_f * assignment_current_choice, data=ds))





# ---- by-rank-and-bonus_pay ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(bonus_pay) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=bonus_pay, y=satistfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  theme_report# +
# theme(legend.position="none") +
# labs(x=NULL) #y="Satisfaction"

summary(lm(satistfaction_rank ~ 1 + officer_rate_f + bonus_pay, data=ds))
summary(lm(satistfaction_rank ~ 1 + officer_rate_f * bonus_pay, data=ds))

anova(
  lm(satistfaction_rank ~ 1 + officer_rate_f + bonus_pay, data=ds),
  lm(satistfaction_rank ~ 1 + officer_rate_f * bonus_pay, data=ds)
)


cat("### transparency_rank\n\n")
last_plot() %+% aes(y=transparency_rank)
summary(lm(transparency_rank ~ 1 + officer_rate_f * bonus_pay, data=ds))

cat("### favoritism_rank\n\n")
last_plot() %+% aes(y=favoritism_rank)
summary(lm(favoritism_rank ~ 1 + officer_rate_f * bonus_pay, data=ds))


# ---- by-billet_current-and-critical_war ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  ggplot(aes(x=billet_current, y=satistfaction_rank, fill=critical_war, color=critical_war)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  # theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

# summary(lm(satistfaction_rank ~ 1 + billet_current * critical_war, data=ds))
summary(lm(satistfaction_rank ~ 1 + billet_current + critical_war, data=ds))

# ---- by-bonus_pay-and-manning_proportion ------------------------------------------------------------
cat("### satistfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  ggplot(aes(x=manning_proportion_cut3, y=satistfaction_rank, fill=bonus_pay_cut3, color=bonus_pay_cut3)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  # theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

  # summary(lm(satistfaction_rank ~ 1 + manning_proportion_cut3 * bonus_pay_cut3, data=ds))
  summary(lm(satistfaction_rank ~ 1 + manning_proportion_cut3 + bonus_pay_cut3, data=ds))

  cat("No interaction between manning_proportion_cut3 & bonus_pay_cut3")
  anova(
    lm(satistfaction_rank ~ 1 + manning_proportion_cut3 * bonus_pay_cut3, data=ds),
    lm(satistfaction_rank ~ 1 + manning_proportion_cut3 + bonus_pay_cut3, data=ds)
    # lm(satistfaction_rank ~ 1 + manning_proportion * bonus_pay, data=ds),
    # lm(satistfaction_rank ~ 1 + manning_proportion + bonus_pay, data=ds)
  )

  #ggplot(aes(x=manning_proportion, y=satistfaction_rank, fill=bonus_pay_cut4, color=bonus_pay_cut4)) +
  # geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  # # geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  # # stat_summary(fun.y="mean", geom="point", shape=23, size=10, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  # geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  # theme_report

# summary(lm(satistfaction_rank ~ 1 + billet_current * critical_war, data=ds))
summary(lm(satistfaction_rank ~ 1 + billet_current + critical_war, data=ds))

# # ---- model-results-table  -----------------------------------------------
#
# summary(m2)$coef %>%
#   knitr::kable(
#     digits      = 2,
#     format      = "markdown"
#   )

# Uncomment the next line for a dynamic, JavaScript [DataTables](https://datatables.net/) table.
# DT::datatable(round(summary(m2)$coef, digits = 2), options = list(pageLength = 2))
