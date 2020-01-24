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
size_mean_diamond      <- 3

theme_report <- theme_bw() +
  theme(axis.ticks.length     = grid::unit(0, "cm")) +
  theme(axis.text             = element_text(colour="gray40")) +
  theme(axis.title            = element_text(colour="gray40")) +
  theme(panel.border          = element_rect(colour="gray80")) +
  theme(axis.ticks            = element_line(colour="gray80"))

prettify_lm <- function( x ) {
  # cat("\n\n<code>", as.character(print(x$call)), "</code>\n\n")
  cat("<br/>Data:<code>", as.character(x$call$data), "</code>")
  cat("<br/>Formula:<code>", as.character(x$call$formula), "</code>")

  # browser()

  broom::tidy(x) %>%
    knitr::kable(
      format = "html"
    ) %>%
    kableExtra::kable_styling(
      bootstrap_options  = c("striped", "hover", "condensed", "responsive"),
      full_width         = F,
      position           = "left"
    ) %>%
    cat()

  cat("\n\n")

  broom::glance(x) %>%
    knitr::kable() %>%
    kableExtra::kable_styling(
      bootstrap_options  = c("striped", "hover", "condensed", "responsive"),
      full_width         = F,
      position           = "left"
    ) %>%
    cat()
}

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

TabularManifest::histogram_discrete(d_observed=ds, variable_name="billet_current")

TabularManifest::histogram_continuous(d_observed=ds, variable_name="satisfaction_rank"        , bin_width=1, rounded_digits=1)
# TabularManifest::histogram_continuous(d_observed=ds, variable_name="assignment_current_choice" , bin_width=1, rounded_digits=1)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="assignment_current_choice")

TabularManifest::histogram_discrete(d_observed=ds, variable_name="bonus_pay_cut3")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="critical_war")
TabularManifest::histogram_discrete(d_observed=ds, variable_name="specialty_type")

TabularManifest::histogram_continuous(d_observed=ds, variable_name="manning_proportion" , bin_width=.05, rounded_digits=2)
TabularManifest::histogram_discrete(d_observed=ds, variable_name="manning_proportion_cut3")

TabularManifest::histogram_continuous(d_observed=ds, variable_name="survey_weight_specialty_type" , bin_width=.05, rounded_digits=2)

cat("Satisfaction summary")
summary(ds$satisfaction_rank)

cat("Satisfaction summary (emergency medicine only")
summary(ds$satisfaction_rank[ds$primary_specialty=="Emergency Medicine"])


######## Outcome Relationships ##########################################################

# ---- outcome-correlations ----------------------------------------------------
outcomes <- c("satisfaction_rank", "transparency_rank", "favoritism_rank", "assignment_current_choice")
cor_hyp_1 <- cor(ds[, outcomes], use = "pairwise.complete.obs")

cor_hyp_1 %>%
  # dplyr::mutate_all(~sprintf("%0.3f", .)) %>%
  # purrr::map_df(~sprintf("%0.3f", .)) %>%
  knitr::kable(
    digits = 3,
    col.names = gsub("_", " ", colnames(.))
  )

colnames(cor_hyp_1) <- gsub("_", "\n", colnames(cor_hyp_1))
rownames(cor_hyp_1) <- gsub("_", "\n", colnames(cor_hyp_1))
corrplot::corrplot(cor_hyp_1, method="ellipse", addCoef.col="gray30", tl.col="gray20", diag=F, order="AOE")

pairs(x=ds[, outcomes], lower.panel=panel.smooth, upper.panel=panel.smooth)

######## Univariate ##########################################################

# ---- by-rank ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=officer_rank, y=satisfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

prettify_lm(lm(satisfaction_rank ~ 1 + officer_rate_f, data=ds))

# ---- by-specialty-type ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(specialty_type) %>%
  dplyr::filter(specialty_type != "unknown") %>%
  ggplot(aes(x=specialty_type, y=satisfaction_rank, fill=specialty_type, color=specialty_type)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"
prettify_lm(lm(satisfaction_rank ~ 1 + specialty_type, data=ds[ds$specialty_type != "unknown", ]) )

# ---- by-bonus-pay ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(bonus_pay_cut4) %>%
  dplyr::filter(bonus_pay_cut4 != "unknown") %>%
  ggplot(aes(x=bonus_pay_cut4, y=satisfaction_rank, fill=bonus_pay_cut4, color=bonus_pay_cut4)) +
  geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = .2), size=2, shape=1, na.rm=T) +
  # scale_color_manual(values=PalettePregancyGroup) +
  # scale_fill_manual(values=PalettePregancyGroupLight) +
  # coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  theme_report +
  theme(legend.position="none") +
  labs(x=NULL) #y="Satisfaction"

prettify_lm(lm(satisfaction_rank ~ 1 + bonus_pay_cut4, data=ds))

ds %>%
  dplyr::count(bonus_pay_cut4, specialty_type)

# ---- by-assignment-current-choice ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(assignment_current_choice) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=assignment_current_choice, y=satisfaction_rank)) +
  geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  theme_report
prettify_lm(lm(satisfaction_rank ~ 1 + assignment_current_choice, data=ds))

# ---- by-manning_proportion ------------------------------------------------------------
cat("### manning_proportion\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=manning_proportion, y=satisfaction_rank)) + #, color=officer_rank)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_smooth(data=ds[ds$survey_lag >=2014L, ], method="loess", span=2, na.rm=T) +
  geom_point(shape=1, position = position_jitter(width=.3, height=.3), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank())

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=manning_proportion_cut3, y=satisfaction_rank, color=manning_proportion_cut3)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=size_mean_diamond, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")

# ---- by-critical_war ------------------------------------------------------------
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(ds, aes(x=critical_war, y=satisfaction_rank, color=critical_war)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=size_mean_diamond, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  coord_cartesian(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")

# ---- by-billet_current ------------------------------------------------------------
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
# billet_current = forcats::fct_reorder(billet_current, satisfaction_rank, .fun=mean)

ggplot(ds, aes(x=billet_current, y=satisfaction_rank, color=billet_current)) +
  geom_boxplot(na.rm=T) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=size_mean_diamond, fill="gray80", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=1, position = position_jitter(width=.3, height=.25), na.rm=T) +
  scale_x_discrete(limits = rev(levels(ds$billet_current))) +
  coord_flip(ylim=c(0.5,5.5)) +
  theme_light() +
  theme(axis.ticks = element_blank()) +
  theme(legend.position = "none")
prettify_lm(lm(satisfaction_rank ~ 1 + billet_current, data=ds))
# forcats::fct_reorder(ds$billet_current, ds$satisfaction_rank, .fun=mean)


######## Multivariate ##########################################################

# ---- by-rank-and-specialty-type ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
# palette_rank <- c(
#   "LT"            = "#a2aa67",
#   "LCDR"          = "#ff9a05",
#   "CDR"           = "#c30205",
#   "CAPT or Flag"  = "#6c3c54"
# )
palette_rate <- c(
  "O3"    = "#999385",
  "O4"    = "#00A8E8",
  "O5"    = "#00477A", #003459
  "O6"    = "#00171F"
)

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(specialty_type) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(specialty_type != "unknown") %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  dplyr::mutate(
    specialty_type  = dplyr::recode(specialty_type, `family` = "family\nmedicine"),
    officer_rate    = factor(officer_rate, levels=3:6, labels=c("O3", "O4", "O5", "O6"))
  ) %>%
  ggplot(aes(x=specialty_type, y=satisfaction_rank, fill=officer_rate, color=officer_rate)) +
  geom_boxplot(na.rm=T, alpha=.2, outlier.shape=NULL, outlier.colour=NA, position=position_dodge2(preserve = "single", padding = 0)) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge2(preserve = "single", width=.75), shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T, show.legend = F) + #See Chang (2013), Recipe 6.8.
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), alpha=.25, size=1.5, shape=1, na.rm=T, show.legend = F) +
  scale_color_manual(values=palette_rate, guide = guide_legend(reverse = FALSE)) +
  scale_fill_manual( values=palette_rate, guide = guide_legend(reverse = FALSE)) +
  coord_flip() +
  theme_report +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(legend.position="bottom") +
  labs(x=NULL, y="Overall Satisfaction\n(unhappiest to happiest)", color="Officer\nRank", fill="Officer\nRank")

prettify_lm(lm(satisfaction_rank ~ 1 + officer_rate_f * specialty_type, data=ds[ds$specialty_type != "unknown", ]))
prettify_lm(lm(satisfaction_rank ~ 1 + officer_rate_f + specialty_type, data=ds[ds$specialty_type != "unknown", ]))

# ---- by-rank-and-bonus_pay ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  tidyr::drop_na(bonus_pay) %>%
  tidyr::drop_na(officer_rank) %>%
  dplyr::filter(officer_rank != "Unknown") %>%
  ggplot(aes(x=bonus_pay, y=satisfaction_rank, fill=officer_rank, color=officer_rank)) +
  geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  theme_report# +
# theme(legend.position="none") +
# labs(x=NULL) #y="Satisfaction"

prettify_lm(lm(satisfaction_rank ~ 1 + officer_rate_f + bonus_pay, data=ds))
prettify_lm(lm(satisfaction_rank ~ 1 + officer_rate_f * bonus_pay, data=ds))

cat("<br/><code>")
anova(
  lm(satisfaction_rank ~ 1 + officer_rate_f + bonus_pay, data=ds),
  lm(satisfaction_rank ~ 1 + officer_rate_f * bonus_pay, data=ds)
)
cat("</code>")

# ---- by-billet_current-and-critical_war ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
palette_critical_war <- c("High\nDeployer"="#e81818", "Low\nDeployer"="#409fa1") # http://colrd.com/image-dna/50548/
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  dplyr::mutate(
    billet_current  = gsub("[ /]", "\n", billet_current),
    critical_war    = gsub("[ ]" , "\n", critical_war),
    critical_war    = factor(critical_war, levels=c("Low\nDeployer", "High\nDeployer"))
  ) %>%
  ggplot(aes(x=billet_current, y=satisfaction_rank, fill=critical_war, color=critical_war)) +
  geom_boxplot(na.rm=T, alpha=.2, outlier.shape=NULL, outlier.colour=NA, position=position_dodge2(preserve = "single", padding = 0)) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge2(preserve = "single", width=.75), shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T, show.legend = F) + #See Chang (2013), Recipe 6.8.
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), alpha=.25, size=1.5, shape=1, na.rm=T, show.legend = F) +
  scale_color_manual(values=palette_critical_war, guide = guide_legend(reverse = FALSE)) +
  scale_fill_manual(values=palette_critical_war , guide = guide_legend(reverse = FALSE)) +
  coord_flip() +
  theme_report +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(legend.position="bottom") +
  labs(x=NULL, y="Overall Satisfaction\n(unhappiest to happiest)", color=NULL, fill=NULL)

# prettify_lm(lm(satisfaction_rank ~ 1 + billet_current * critical_war, data=ds))
prettify_lm(lm(satisfaction_rank ~ 1 + billet_current + critical_war, data=ds))

# ---- by-bonus_pay-and-manning_proportion ------------------------------------------------------------
cat("### satisfaction_rank\n\n")
palette_manning_proportion <- c("$0"="#999385", "$20-24k"="#84b0bb", "$24k+"="#15274d") # http://colrd.com/image-dna/36525/

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ds %>%
  dplyr::mutate(
    manning_proportion_cut3  = dplyr::recode(manning_proportion_cut3, `Over`="over\nmanned", `Balanced`="balanced", `Under`="under\nmanned")
  ) %>%
  ggplot(aes(x=manning_proportion_cut3, y=satisfaction_rank, fill=bonus_pay_cut3, color=bonus_pay_cut3)) +
  geom_boxplot(na.rm=T, alpha=.2, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.y="mean", geom="point", position = position_dodge(width=.75), shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T, show.legend = F) + #See Chang (2013), Recipe 6.8.
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), alpha=.25, size=1.5, shape=1, na.rm=T, show.legend = F) +
  scale_color_manual(values=palette_manning_proportion, guide = guide_legend(reverse = FALSE)) +
  scale_fill_manual(values=palette_manning_proportion , guide = guide_legend(reverse = FALSE)) +
  coord_flip() +
  theme_report +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(legend.position="bottom") +
  labs(x=NULL, y="Overall Satisfaction\n(unhappiest to happiest)", color="Bonus\nAmount", fill="Bonus\nAmount")

  # prettify_lm(lm(satisfaction_rank ~ 1 + manning_proportion_cut3 * bonus_pay_cut3, data=ds))
  prettify_lm(lm(satisfaction_rank ~ 1 + manning_proportion_cut3 + bonus_pay_cut3, data=ds))

  cat("No interaction between manning_proportion_cut3 & bonus_pay_cut3")
  cat("<br/><code>")
  anova(
    lm(satisfaction_rank ~ 1 + manning_proportion_cut3 * bonus_pay_cut3, data=ds),
    lm(satisfaction_rank ~ 1 + manning_proportion_cut3 + bonus_pay_cut3, data=ds)
    # lm(satisfaction_rank ~ 1 + manning_proportion * bonus_pay, data=ds),
    # lm(satisfaction_rank ~ 1 + manning_proportion + bonus_pay, data=ds)
  )
  cat("</code>")

  #ggplot(aes(x=manning_proportion, y=satisfaction_rank, fill=bonus_pay_cut4, color=bonus_pay_cut4)) +
  # geom_smooth(method="loess", span=2, alpha=.2, na.rm=T) +
  # # geom_boxplot(na.rm=T, alpha=.05, outlier.shape=NULL, outlier.colour=NA) +
  # # stat_summary(fun.y="mean", geom="point", shape=23, size=size_mean_diamond, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
  # # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  # geom_point(position=position_jitter(w = 0.3, h = .2), size=2, shape=1, na.rm=T) +
  # theme_report

# prettify_lm(lm(satisfaction_rank ~ 1 + billet_current * critical_war, data=ds))
prettify_lm(lm(satisfaction_rank ~ 1 + billet_current + critical_war, data=ds))

# ---- by-billet-and-rate ----------------------------------------------------------
cat("### satisfaction_rank\n\n")
ds_no_other_or_unknown <-
  ds %>%
  dplyr::filter(billet_current != "Other") %>%
  dplyr::filter(specialty_type != "unknown")

cat("**Conculsion**: `officer_rate` has a significant positive slope --sig predicting beyond `billet_current`.  But the billet levels have the same slope.")
# prettify_lm(lm(satisfaction_rank ~ 1 + billet_current               , data=ds_no_other_or_unknown))

prettify_lm(lm(satisfaction_rank ~ 1 + billet_current + officer_rate, data=ds_no_other_or_unknown))

# prettify_lm(lm(satisfaction_rank ~ 1 + billet_current * officer_rate, data=ds_no_other_or_unknown))

anova(
  lm(satisfaction_rank ~ 1 + billet_current               , data=ds_no_other_or_unknown, subset=!is.na(officer_rate)),
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate, data=ds_no_other_or_unknown)
)

anova(
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate, data=ds_no_other_or_unknown),
  lm(satisfaction_rank ~ 1 + billet_current * officer_rate, data=ds_no_other_or_unknown)
)

# ggplot(mpg, aes(displ, hwy)) +
#   geom_point() +
#   geom_smooth(method = lm, se = FALSE)

ds_no_other_or_unknown %>%
  tidyr::drop_na(satisfaction_rank) %>%
  tidyr::drop_na(officer_rate) %>%
  # ggplot(., aes(x=officer_rate, y=satisfaction_rank)) +
  ggplot(aes(x=officer_rate, y=satisfaction_rank, color=billet_current)) +
  # geom_smooth(method=lm, se=F) +
  geom_smooth(aes(group=billet_current), method=lm,  formula = y ~ x, se=F) +
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), alpha=1, size=1.5, shape=1, na.rm=T, show.legend = T) +
  theme_report +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(legend.position="bottom")


# ---- 3-predictor --------------------------------------------------------------

prettify_lm(lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type, data=ds_no_other_or_unknown))

anova(
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate                 , data = ds_no_other_or_unknown),
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type, data = ds_no_other_or_unknown)
)

lm_no_int_billet    <- lm(satisfaction_rank ~ 0 + billet_current + officer_rate + specialty_type, data=ds_no_other_or_unknown)
lm_no_int_specialty <- lm(satisfaction_rank ~ 0 + specialty_type + officer_rate + billet_current, data=ds_no_other_or_unknown)

plot(lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type, data = ds_no_other_or_unknown))

# ---- 3-predictor-with-weights --------------------------------------------------------------

prettify_lm(lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type, data=ds_no_other_or_unknown, weights = survey_weight_specialty_type))

# ---- billet-intercept ------------------------------------------------------
palette_billet <- c(
  "GME"                           = "#EDAE49",
  "CONUS MTF"                     = "#304bce", # dark blue
  "CONUS Operational"             = "#009dee", # light blue; The reference group
  "OCONUS MTF"                    = "#cc5555", # darkish red
  "Non-Operational/Non-Clinical"  = "#3acc85", # green
  "OCONUS Operational"            = "#ff5500"  # lighter red
  # "Other"                         = ""
)
palette_billet_light <- scales::alpha(palette_billet, alpha=.4)


pattern_billet <- "^billet_current"
pattern_specialty <- "^specialty_type"

# ds_trajectory <-
#   tibble::tibble(
#     intercept = 1:5,
#     slope = 1.2
#   )
ds_trajectory <-
  lm_no_int_billet %>%
  broom::tidy() %>%
  dplyr::filter(grepl(pattern_billet, term)) %>%
  # dplyr::select(term, estimate) %>%
  dplyr::mutate(
    term        = sub(pattern_billet, "", term),
    intercept   = estimate, #+ coef(a)[["(Intercept)"]],
    slope       = coef(lm_no_int_billet)[["officer_rate"]],
    # slope       = coef(a)[["I(officer_rate - 3)"]],

    billet_current    = factor(
      term,
      levels  = term #levels(ds_no_other_or_unknown$billet_current),
      # labels  = sprintf("%2.2f %s", intercept, term)
    ),
    billet_current    = reorder(billet_current, -intercept)
  ) %>%
  dplyr::select(
    billet_current,
    intercept,
    slope
  )

ds_no_other_or_unknown %>%
  dplyr::mutate(
    billet_current  = factor(billet_current, levels=levels(ds_trajectory$billet_current)),
  ) %>%
  ggplot(aes(x=officer_rate, y=satisfaction_rank, color=billet_current, fill=billet_current, group=billet_current)) +
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), size=1.5, shape=21, na.rm=T, show.legend = T) +
  # geom_smooth(method = lm, se=F, formula = y~ x + 1) +
  geom_abline(data=ds_trajectory, aes(intercept=intercept, slope=slope, color=billet_current), size=1, alpha=.5) +
  scale_color_manual(values = palette_billet) +
  scale_fill_manual(values = palette_billet_light) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  theme_report +
  labs(
    x     = "Officer Rate",
    y     = "Satisfaction",
    color = "Current Billet",
    fill  = "Current Billet"
  )

# ---- specialty-intercept ------------------------------------------------------
#c13600
#df7605
#eeca52
#9baa65
#0b9f89
#030736
palette_specialty <- c(
  "nonsurgical"     = "#9baa65", # olive
  "surgical"        = "#030736", # blue
  "resident"        = "#c13600", # red
  "family"          = "#0b9f89", # green
  "operational"     = "#df7605"  # orange
  # "Other"                         = ""
)
palette_specialty_light <- scales::alpha(palette_specialty, alpha=.4)
pattern_specialty <- "^specialty_type"

lm_no_int_specialty   <- lm(satisfaction_rank ~ 0 + specialty_type + officer_rate + billet_current, data=ds_no_other_or_unknown)

ds_trajectory_specialty <-
  lm_no_int_specialty %>%
  broom::tidy() %>%
  dplyr::filter(grepl(pattern_specialty, term)) %>%
  # dplyr::select(term, estimate) %>%
  dplyr::mutate(
    term        = sub(pattern_specialty, "", term),
    intercept   = estimate, #+ coef(a)[["(Intercept)"]],
    slope       = coef(lm_no_int_specialty)[["officer_rate"]],
    # slope       = coef(a)[["I(officer_rate - 3)"]],

    specialty_type    = factor(
      term,
      levels  = term #levels(ds_no_other_or_unknown$billet_current),
      # labels  = sprintf("%2.2f %s", intercept, term)
    ),
    specialty_type    = reorder(specialty_type, -intercept)
  ) %>%
  dplyr::select(
    specialty_type,
    intercept,
    slope
  )

ds_no_other_or_unknown %>%
  dplyr::mutate(
    specialty_type  = factor(specialty_type, levels=levels(ds_trajectory_specialty$specialty_type)),
  ) %>%
  ggplot(aes(x=officer_rate, y=satisfaction_rank, color=specialty_type, fill=specialty_type, group=specialty_type)) +
  geom_point(position=position_jitterdodge(jitter.width=0.4, jitter.height =.2, dodge.width=.75), size=1.5, shape=21, na.rm=T, show.legend = T) +
  # geom_smooth(method = lm, se=F, formula = y~ x + 1) +
  geom_abline(data=ds_trajectory_specialty, aes(intercept=intercept, slope=slope, color=specialty_type), size=1, alpha=.5) +
  scale_color_manual(values = palette_specialty) +
  scale_fill_manual(values = palette_specialty_light) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  theme_report +
  labs(
    x     = "Officer Rate",
    y     = "Satisfaction",
    color = "Specialty Type",
    fill  = "Specialty Type"
  )

# ---- nonsignificant-additions ------------------------------------------------

cat("The `officer_rate * specialty_type`  interaction doesn't sig improve the fit of the model")
anova(
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type, data=ds_no_other_or_unknown),
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate * specialty_type, data=ds_no_other_or_unknown)
)

cat("`manning_proportion_cut3` doesn't sig improve the fit of the model")
anova(
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type                           , data=ds_no_other_or_unknown),
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type + manning_proportion_cut3 , data=ds_no_other_or_unknown)
)

cat("`bonus_pay_cut4` doesn't sig improve the fit of the model")
anova(
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type                  , data=ds_no_other_or_unknown),
  lm(satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type + bonus_pay_cut4 , data=ds_no_other_or_unknown)
)
