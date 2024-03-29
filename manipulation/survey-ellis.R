# knitr::stitch_rmd(script="./manipulation/te-ellis.R", output="./stitched-output/manipulation/te-ellis.md") # dir.create("./stitched-output/manipulation/", recursive=T)
# For a brief description of this file see the presentation at
#   - slides: https://rawgit.com/wibeasley/RAnalysisSkeleton/master/documentation/time-and-effort-synthesis.html#/
#   - code: https://github.com/wibeasley/RAnalysisSkeleton/blob/master/documentation/time-and-effort-synthesis.Rpres
rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(ggplot2)  # This is kinda cheating to be graphing inside an ellis
import::from("magrittr", "%>%")

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        ) # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"       ) # For asserting conditions meet expected patterns/conditions.
requireNamespace("checkmate"    ) # For asserting conditions meet expected patterns/conditions. # remotes::install_github("mllg/checkmate")
requireNamespace("OuhscMunge"   ) # remotes::install_github(repo="OuhscBbmc/OuhscMunge")

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
config        <- config::get()

col_types <- readr::cols_only( # readr::spec_csv(config$path_survey_response_raw)
  `Response ID`                                                                                                                                                                               = readr::col_integer(),
  `Include/Exclude`                                                                                                                                                                           = readr::col_character(),
  # `Date submitted`                                                                                                                                                                            = readr::col_character(),
  `Date submitted`                                                                                                                                                                            = readr::col_datetime("%m/%d/%y %H:%M"),
  # `Last page`                                                                                                                                                                                 = readr::col_double(),
  # `Start language`                                                                                                                                                                            = readr::col_character(),
  # `Date started`                                                                                                                                                                              = readr::col_character(),
  # `Date last action`                                                                                                                                                                          = readr::col_character(),
  `What is your primary?specialty-`                                                                                                                                                           = readr::col_character(),
  `What is your rank-`                                                                                                                                                                        = readr::col_character(),
  `What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.)`                                                                      = readr::col_character(),
  `What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.) [Other]`                                                              = readr::col_character(),
  `How would you describe your current billet-`                                                                                                                                               = readr::col_character(),
  # `How would you describe your current billet- [Other]`                                                                                                                                       = readr::col_character(),
  `For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS-`                                = readr::col_character(),
  `For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS- [Other]`                        = readr::col_character(),
  `On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-`            = readr::col_integer(),
  `On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall?detailing experience for your last set of orders-`                              = readr::col_integer(),
  `On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-`          = readr::col_integer(),
  `Describe your current assignment:`                                                                                                                                                         = readr::col_character(),
  `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 1]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 2]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 3]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 4]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 5]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 6]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 7]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 8]`                                            = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 9]`                                            = readr::col_character(),
  `Which career path do you want to pursue in the next 5-10? years-`                                                                                                                          = readr::col_character(),
  # `Which career path do you want to pursue in the next 5-10? years- [Other]`                                                                                                                  = readr::col_character(),
  `Neither the Army nor the Air Force have physicians in the detailer role.? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.? This is different from the current Navy Medical Corps billet assignment process where the detailer?is a physician*.? Would you?approve if the detailer position was filled by a non-physician-`                                                                                                                          = readr::col_character(),
  `How long should an individual be allowed to remain at one command-`                                                                                                                                                                                                                                                                                                                                                                                                                                          = readr::col_character(),
  `Do you think that there is a problem in the Medical Corps with members not moving-? That is, are there too many physicians who get to stay in one place too long-`                                                                                                                                                                                                                                                                                                                                           = readr::col_character(),
  `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.? Of these two options, which would you prefer for your military billet assignment-`       = readr::col_character(),

  `The later the match day, the more information one has before creating their rank list.? The earlier the match day, the sooner one can have certainty and prepare.? Assuming your were scheduled to?execute new orders in July of 2017, what month would you want the match to occur in-`                                                                                                                                                                                                                     = readr::col_character(),
  `Do you think members who are coming from operational or OCONUS assignments should be given preference in billet assignment-`                                                                                                                                                                                                                                                                                                                                                                                 = readr::col_character(),
  `Do you think members with more seniority (as defined by time in service or rank)?should be given preference in billet assignment-`                                                                                                                                                                                                                                                                                                                                                                           = readr::col_character()
)

col_types_lu_specialty  <- readr::cols_only(
  specialty                 = readr::col_character(),
  bonus_pay                 = readr::col_double(),
  net_manning_2013          = readr::col_integer(),
  manning_percent_2013      = readr::col_double(),
  net_manning_2014          = readr::col_integer(),
  manning_percent_2014      = readr::col_double(),
  net_manning_2015          = readr::col_integer(),
  manning_percent_2015      = readr::col_double(),
  net_manning_2016          = readr::col_integer(),
  manning_percent_2016      = readr::col_double(),
  critical_war              = readr::col_logical(),
  specialty_type            = readr::col_character(),
  officer_count_population  = readr::col_integer()
)

col_types_lu_manning  <- readr::cols_only(
  specialty       = readr::col_character(),
  # specialty_type  = readr::col_character(),
  rate            = readr::col_integer(),
  count           = readr::col_integer()
)

# OuhscMunge::readr_spec_aligned(config$path_rate)
col_types_rate <- readr::cols_only(
  `officer_rate`                  = readr::col_integer(),
  `officer_count_population_rate` = readr::col_integer()
)

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
# readr::spec_csv(config$path_survey_response_raw)
# readr::spec_csv(config$path_specialty_manning_derived)
ds              <- readr::read_csv(config$path_survey_response_raw        , col_types=col_types)
ds_lu_specialty <- readr::read_csv(config$path_specialty_bonus_manning    , col_types=col_types_lu_specialty)
ds_lu_manning   <- readr::read_csv(config$path_specialty_manning_derived  , col_types=col_types_lu_manning)
ds_lu_rate_population      <- readr::read_csv(config$path_officer_rate               , col_types=col_types_rate)

rm(col_types)
rm(col_types_lu_specialty, col_types_rate, col_types_lu_manning)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_lu_specialty) #Spit out columns to help write call ato `dplyr::rename()`.
ds_lu_specialty <- ds_lu_specialty %>%
  dplyr::select(
    specialty
    , bonus_pay
    , manning_proportion_2013       = manning_percent_2013
    , manning_proportion_2014       = manning_percent_2014
    , manning_proportion_2015       = manning_percent_2015
    , manning_proportion_2016       = manning_percent_2016
    , critical_war
    , specialty_type
    , officer_count_population
  ) %>%
  dplyr::mutate(
    specialty_type      = factor(specialty_type, levels=c("nonsurgical", "surgical", "family", "operational",  "resident", "unknown")),
    critical_war        = dplyr::recode(as.character(critical_war), "TRUE"="High Deployer", "FALSE"="Low Deployer", .missing=NA_character_, .default=NA_character_)
  ) %>%
  dplyr::group_by(specialty) %>%
  dplyr::mutate(
    manning_proportion  = median(c(manning_proportion_2013, manning_proportion_2014, manning_proportion_2015, manning_proportion_2016), na.rm=T),
    manning_proportion  = dplyr::coalesce(manning_proportion, 1.00)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::select(-manning_proportion_2013, -manning_proportion_2014, -manning_proportion_2015, -manning_proportion_2016)

ds_lu_manning <- ds_lu_manning %>%
  dplyr::rename(
    population_count   = count
  )

ds <- ds %>%
  dplyr::select( #`select()` implicitly drops the other columns not mentioned.
    response_id                   = `Response ID`
    , include_exclude             = `Include/Exclude`
    , datetime_submitted          = `Date submitted`
    # , datetime_started            = `Date started`
    # , datetime_last_action        = `Date last action`
    , primary_specialty           = `What is your primary?specialty-`
    , officer_rank                = `What is your rank-`
    , year_executed_order         = `What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.)`
    , year_executed_order_other   = `What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.) [Other]`
    , billet_current              = `How would you describe your current billet-`
    # , billet_current_other      = `How would you describe your current billet- [Other]`
    , order_lead_time             = `For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS-`
    , order_lead_time_other       = `For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS- [Other]`
    , transparency_rank           = `On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-`
    , satisfaction_rank           = `On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall?detailing experience for your last set of orders-`
    , favoritism_rank             = `On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-`
    , assignment_current_choice   = `Describe your current assignment:`
    , geographic_preference       = `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 1]`
    , career_path                 = `Which career path do you want to pursue in the next 5-10? years-`
    # , career_path_other         = `Which career path do you want to pursue in the next 5-10? years- [Other]`
    , doctor_as_detailer          = `Neither the Army nor the Air Force have physicians in the detailer role.? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.? This is different from the current Navy Medical Corps billet assignment process where the detailer?is a physician*.? Would you?approve if the detailer position was filled by a non-physician-`
    , homestead_length_in_years   = `How long should an individual be allowed to remain at one command-`
    , homestead_problem           = `Do you think that there is a problem in the Medical Corps with members not moving-? That is, are there too many physicians who get to stay in one place too long-`
    , match_desirability          = `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.? Of these two options, which would you prefer for your military billet assignment-`
    , match_month                 = `The later the match day, the more information one has before creating their rank list.? The earlier the match day, the sooner one can have certainty and prepare.? Assuming your were scheduled to?execute new orders in July of 2017, what month would you want the match to occur in-`
    , assignment_priority         = `Do you think members who are coming from operational or OCONUS assignments should be given preference in billet assignment-`
    , officer_rank_priority       = `Do you think members with more seniority (as defined by time in service or rank)?should be given preference in billet assignment-`
  ) %>%
  dplyr::filter(include_exclude == "I") %>%
  dplyr::mutate(
    primary_specialty           = dplyr::coalesce(primary_specialty        , "Unknown"),
    geographic_preference       = dplyr::coalesce(geographic_preference    , "Unknown"),
    homestead_length_in_years   = dplyr::coalesce(homestead_length_in_years, "Unknown"),
    homestead_problem           = dplyr::coalesce(homestead_problem        , "Unknown"),

    doctor_as_detailer          = factor(dplyr::coalesce(doctor_as_detailer, "Unknown"), levels=c("Yes", "No", "Do not care", "Other", "Unknown")),
    career_path                 = dplyr::coalesce(career_path              , "No Response"),
    # match_desirability          = dplyr::coalesce(match_desirability       , "Unknown")
    match_desirability          = dplyr::recode_factor(
      match_desirability,
      "Something similar to the National Residency Match Program" = "match",
      "Status Quo: Detailer and Specialty Leader decide"          = "status_quo",
      "Other"                                                     = "other/unknown",
      .missing                                                    = "other/unknown"
    )
  ) %>%
  dplyr::mutate(
    year_executed_order_other       = dplyr::recode(
      year_executed_order_other,
      `2005`                        = 2005L,
      `2006`                        = 2006L,
      `2007`                        = 2007L,
      `2008`                        = 2008L,
      `2009`                        = 2009L,
      `2010`                        = 2010L,
      `2011`                        = 2011L,
      .default                      = NA_integer_
    ),
    year_executed_order             = dplyr::na_if(year_executed_order, "Other"),
    year_executed_order             = as.integer(year_executed_order),
    year_executed_order             = dplyr::coalesce(year_executed_order, year_executed_order_other)
  ) %>%
  dplyr::mutate(
    officer_rank                    = dplyr::coalesce(officer_rank, "Unknown"),
    officer_rank                    = factor(officer_rank, levels=c("LT", "LCDR", "CDR", "CAPT or Flag", "Unknown"), ordered = F),
    officer_rate                    = dplyr::recode(
      officer_rank,
      "LT"                = 3L,
      "LCDR"              = 4L,
      "CDR"               = 5L,
      "CAPT or Flag"      = 6L,
      "Unknown"           = NA_integer_
    )
  ) %>%
  # dplyr::left_join(ds_lu_rate, by = "officer_rate") %>%
  dplyr::mutate(
    datetime_submitted        = as.Date(datetime_submitted),

    survey_lag                = as.numeric(difftime(datetime_submitted, as.Date(ISOdate(year_executed_order, 7, 15)), units = "days") / 365.25)
  ) %>%
  dplyr::mutate(
    order_lead_time_other       = dplyr::recode(
      order_lead_time_other,
      `<2 months`                                             = "< 2 months",
      `1-2 months`                                            = "< 2 months",
      `1 month`                                               = "< 2 months",
      `33 days`                                               = "< 2 months",
      `44 days`                                               = "< 2 months",
      `5 Months, received orders while deployed OEF`          = "> 4 months",
      `6`                                                     = "> 4 months",
      `6 months but no cost`                                  = "> 4 months",
      `6 weeks`                                               = "< 2 months",
      `Between 1-2 months`                                    = "< 2 months",
      `re-toured 2mo's before, while on deployment`           = "2-4 months"
    ),
    order_lead_time             = dplyr::recode(order_lead_time, "< 1 month"="< 2 months", .default=order_lead_time),
    order_lead_time             = dplyr::coalesce(order_lead_time, order_lead_time_other),
    order_lead_time             = factor(order_lead_time, levels=c("< 2 months", "2-4 months", "> 4 months"), ordered = TRUE)
  ) %>%
  dplyr::mutate(
    assignment_current_choice   = dplyr::recode(
      assignment_current_choice,
      "1st choice"        = 1L,
      "2nd choice"        = 2L,
      "3rd choice"        = 3L,
      "4th choice"        = 4L,
      "> 4th choice"      = 5L,
      "Other"             = NA_integer_
    )
  ) %>%
  dplyr::mutate(
    billet_current  = dplyr::coalesce(billet_current, "Other"),
    billet_current  = dplyr::recode_factor(
      billet_current,
      "CONUS MTF"                     = "CONUS MTF",
      "GME"                           = "CONUS MTF",                  # Combine GME w/ CONUS MTF
      "Non-Operational/Non-Clinical"  = "Administrative",
      "OCONUS MTF"                    = "OCONUS MTF",
      "CONUS Operational"             = "CONUS Operational",
      "OCONUS Operational"            = "OCONUS Operational",
      "Other"                         = "Other",
    )
  ) %>%
  dplyr::mutate(
    assignment_priority_pretty         = factor(dplyr::coalesce(assignment_priority      , "Unknown"), levels=c("Yes", "No", "Unknown")),
    officer_rank_priority_pretty       = factor(dplyr::coalesce(officer_rank_priority    , "Unknown"), levels=c("Yes", "No", "Unknown")),

    assignment_priority                = dplyr::recode(assignment_priority  , "Yes"=TRUE, "No"=FALSE, .missing=as.logical(NA_integer_)),
    officer_rank_priority              = dplyr::recode(officer_rank_priority, "Yes"=TRUE, "No"=FALSE, .missing=as.logical(NA_integer_))
  ) %>%
  dplyr::mutate(
    order_lead_time_preferred_cut3 = dplyr::recode_factor(
      match_month,
      "Jun-17"   = "< 2 months",    #This didn't actually appear in the dataset.  I'm doing it for balance w/ the `order_lead_time` variable

      "Mar-17"   = "2-4 months",

      "Jun-16"   = "> 4 months",
      "Jul-16"   = "> 4 months",
      "Aug-16"   = "> 4 months",
      "Sep-16"   = "> 4 months",
      "Oct-16"   = "> 4 months",
      "Nov-16"   = "> 4 months",
      "Dec-16"   = "> 4 months",
      "Jan-17"   = "> 4 months",
      "Feb-17"   = "> 4 months",
      "17-Feb"   = "> 4 months",
      "Other"    = "Other/Unknown",
      .missing   = "Other/Unknown"
    )
  ) %>%
  dplyr::mutate(
    order_lead_time_preferred_months = dplyr::recode(
      match_month,
      "Jun-16"   = 13L,
      "Jul-16"   = 12L,
      "Aug-16"   = 11L,
      "Sep-16"   = 10L,
      "Oct-16"   =  9L,
      "Nov-16"   =  8L,
      "Dec-16"   =  7L,
      "Jan-17"   =  6L,
      "Feb-17"   =  5L,
      "17-Feb"   =  4L,
      "Mar-17"   =  4L,
      "Jun-17"   =  1L,    #This didn't actually appear in the dataset.  I'm doing it for balance w/ the `order_lead_time` variable
      .default   = NA_integer_,
      .missing   = NA_integer_
    )
  ) %>%
  dplyr::select(-include_exclude, -year_executed_order_other, -order_lead_time_other)

table(ds$order_lead_time_preferred_months, useNA="always")
table(ds$order_lead_time_preferred_cut3, useNA="always")
table(ds$order_lead_time, useNA="always")
dput(unique(ds$match_month))
# as.Date(ISOdate(ds$year_executed_order, 7, 15))
# strptime(ds$year_executed_order, "%Y-07-15")

# as.Date(ds$datetime_submitted)
# strftime("9/20/16 11:17", "%m/%d/%y %H:%M")
# strftime("9/20/16 11:17", "%m/%d/%y %H:%M")
# strptime(ds$datetime_submitted, "%m/%d/%y %H:%M")

# table(ds$year_executed_order, ds$year_executed_order_other)
# table(dplyr::na_if(ds$officer_rank, "Unknown"), useNA = "always")
# table(dplyr::coalesce(ds$officer_rank, "Unknown"), useNA = "always")
# table(ds$officer_rank, useNA = "always")
# table(ds$order_lead_time_other)
# class(ds$order_lead_time)
# class(ds$order_lead_time_other)

# ---- join-with-specialty -----------------------------------------------------
ds <- ds %>%
  dplyr::left_join(
    ds_lu_specialty,
    by = c("primary_specialty" = "specialty")
  ) %>%
  dplyr::left_join(
    ds_lu_manning,
    by = c("primary_specialty" = "specialty", "officer_rate" = "rate")
  ) %>%
  dplyr::mutate(
    bonus_pay_cut3 = cut(
      x               = bonus_pay,
      breaks          = c(-Inf, 16000,    24000,       Inf),
      labels          = c(   "$0", "$20-24k", "$24k+"),
      include.lowest  = TRUE,
      right           = FALSE
    )
  ) %>%
  dplyr::mutate(
    bonus_pay_cut4 = cut(
      x               = bonus_pay,
      breaks          = c(-Inf, 16000,    24000,    32000,   Inf),
      labels          = c(   "$0", "$20-24k", "$24-32k", "32k+"),
      include.lowest  = TRUE,
      right           = FALSE
    )
  ) %>%
  dplyr::mutate(
    manning_proportion_cut3 = cut(
      x               = manning_proportion,
      breaks          = c(-Inf, .9,    1.1,      Inf),
      labels          = c(   "Under", "Balanced", "Over"),
      include.lowest  = TRUE,
      right           = FALSE
    )
  )


# table(ds$bonus_pay_cut3)
# TabularManifest::histogram_continuous(d_observed=ds, variable_name="manning_proportion" , bin_width=.05, rounded_digits=2) +
#   geom_vline(xintercept = .9, size=3) +
#   geom_vline(xintercept = 1.1, size=3)

# ds %>%
#   dplyr::filter(is.na(critical_war)) %>%
#   dplyr::count(primary_specialty)

# ---- calculate-weights-specialty -------------------------------------------------------
ds_specialty_type_population <-
  ds_lu_specialty %>%
  dplyr::group_by(specialty_type) %>%
  dplyr::summarize(
    officer_count_population   = sum(officer_count_population, na.rm=T)
  ) %>%
  dplyr::ungroup()

ds_specialty_type_sample <-
  ds %>%
  dplyr::group_by(specialty_type) %>%
  dplyr::summarize(
    officer_count_sample_specialty   = dplyr::n()
  ) %>%
  dplyr::ungroup()

ds_specialty_type <-
  ds_specialty_type_population %>%
  dplyr::left_join(ds_specialty_type_sample, by="specialty_type") %>%
  dplyr::mutate(
    survey_weight_specialty_type  = officer_count_population / officer_count_sample_specialty,
    survey_weight_specialty_type  = dplyr::if_else(officer_count_population == 0L, NA_real_, survey_weight_specialty_type),
    survey_weight_label           = sprintf("%4i of %4i", officer_count_sample_specialty, officer_count_population)
  ) #%>%
  # dplyr::select(
  #   specialty_type,
  #   survey_weight_specialty_type
  # )

ds_specialty_type %>%
  tidyr::drop_na(specialty_type) %>%
  tidyr::drop_na(survey_weight_specialty_type) %>%
  ggplot(aes(x=specialty_type, y=survey_weight_specialty_type)) +
  geom_bar(stat="identity", color=NA, fill="#99999955") +
  geom_text(aes(y=.1, label=survey_weight_label), hjust=0, family="mono") +
  coord_flip(ylim = c(.5, max(ds_specialty_type$survey_weight_specialty_type, na.rm=T))) +
  theme_minimal() +
  theme(axis.ticks=element_blank()) +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  # theme(axis.ticks.length.y = element_blank()) +
  labs(x="Specialty Type", y="Sampling Weight\n(a value of '5' means 1/5th responded)")

ds <-
  ds %>%
  dplyr::left_join(ds_specialty_type, by = "specialty_type") %>%
  dplyr::mutate(
    # fpc: finite_population_correction
    fpc_specialty_type  = dplyr::n() / sum(ds_specialty_type_population$officer_count_population)
  )

# ---- calculate-weights-rate -------------------------------------------------------
ds_rate_sample <-
  ds %>%
  dplyr::group_by(officer_rate) %>%
  dplyr::summarize(
    officer_count_sample_rate   = dplyr::n()
  ) %>%
  dplyr::ungroup()

ds_lu_rate_population <-
  ds_lu_rate_population %>%
  dplyr::left_join(ds_rate_sample, by = "officer_rate") %>%
  dplyr::mutate(
    survey_weight_rate  = officer_count_population_rate / officer_count_sample_rate,
    survey_weight_rate  = dplyr::if_else(officer_count_population_rate == 0L, NA_real_, survey_weight_rate),
    survey_weight_label_rate           = sprintf("%4i of %4i", officer_count_sample_rate, officer_count_population_rate)
  )

ds_lu_rate_population %>%
  tidyr::drop_na(officer_rate) %>%
  tidyr::drop_na(survey_weight_rate) %>%
  ggplot(aes(x=officer_rate, y=survey_weight_rate)) +
  geom_bar(stat="identity", color=NA, fill="#99999955") +
  geom_text(aes(y=.1, label=survey_weight_label_rate), hjust=0, family="mono") +
  coord_flip(ylim = c(0, max(ds_lu_rate_population$survey_weight_rate, na.rm=T))) +
  theme_minimal() +
  theme(axis.ticks=element_blank()) +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  # theme(axis.ticks.length.y = element_blank()) +
  labs(x="Officer Rate", y="Sampling Weight\n(a value of '5' means 1/5th responded)")


ds <-
  ds %>%
  dplyr::left_join(ds_lu_rate_population, by = "officer_rate") %>%
  dplyr::mutate(
    # fpc: finite_population_correction
    fpc_rate  = dplyr::n() / sum(ds_lu_rate_population$officer_count_population_rate)
  )

# ---- verify-values -----------------------------------------------------------
# Sniff out problems
# OuhscMunge::verify_value_headstart(ds)
checkmate::assert_integer(  ds$response_id               , any.missing=F , lower=15, upper=1368   , unique=T)
checkmate::assert_character(ds$primary_specialty         , any.missing=F , pattern="^.{5,45}$"    )
checkmate::assert_factor(   ds$officer_rank              , any.missing=T                          )
checkmate::assert_integer(  ds$officer_rate              , any.missing=T , lower=3, upper=6       )
checkmate::assert_integer(  ds$year_executed_order       , any.missing=T , lower=2005, upper=2016 )
checkmate::assert_double(  ds$survey_lag                , any.missing=T , lower=0, upper=12                                        )
# checkmate::assert_character(ds$billet_current            , any.missing=T , pattern="^.{3,28}$"    )
checkmate::assert_factor(   ds$billet_current            , any.missing=T                          )
checkmate::assert_factor(   ds$order_lead_time           , any.missing=T                          )
# checkmate::assert_subset(   ds$order_lead_time           , choices = c("< 2 months", "2-4 months", "> 4 months"))
checkmate::assert_integer(  ds$transparency_rank         , any.missing=T , lower=1, upper=5       )
checkmate::assert_integer(  ds$satisfaction_rank        , any.missing=T , lower=1, upper=5       )
checkmate::assert_integer(  ds$favoritism_rank           , any.missing=T , lower=1, upper=5       )
checkmate::assert_integer(  ds$assignment_current_choice , any.missing=T , lower=1, upper=5       )
checkmate::assert_character(ds$geographic_preference     , any.missing=F , pattern="^.{6,38}$"    )
checkmate::assert_character(ds$career_path               , any.missing=T , pattern="^.{5,24}$"    )
checkmate::assert_factor(   ds$doctor_as_detailer        , any.missing=T                          )
checkmate::assert_character(ds$homestead_length_in_years , any.missing=T , pattern="^.{5,19}$"    )
checkmate::assert_character(ds$homestead_problem         , any.missing=T , pattern="^.{2,10}$"     )
checkmate::assert_factor(   ds$match_desirability        , any.missing=T                          )
checkmate::assert_character(ds$match_month               , any.missing=T , pattern="^.{5,6}$"     )

checkmate::assert_logical(  ds$assignment_priority          , any.missing=T )
checkmate::assert_factor(   ds$assignment_priority_pretty   , any.missing=F)# , pattern="^(Yes|No|Unknown)$"   )
checkmate::assert_logical(  ds$officer_rank_priority        , any.missing=T )
checkmate::assert_factor(   ds$officer_rank_priority_pretty , any.missing=F )#, pattern="^(Yes|No|Unknown)$"   )

checkmate::assert_numeric(  ds$bonus_pay                 , any.missing=F , lower=0, upper=36000   )
checkmate::assert_factor(   ds$bonus_pay_cut3            , any.missing=F                          )
checkmate::assert_factor(   ds$bonus_pay_cut4            , any.missing=F                          )
# checkmate::assert_logical(  ds$critical_war              , any.missing=F                          )
checkmate::assert_character(ds$critical_war              , any.missing=F                          )
checkmate::assert_factor(   ds$specialty_type            , any.missing=F)# , pattern="^.{6,11}$"    )
checkmate::assert_numeric(  ds$manning_proportion        , any.missing=F , lower=0, upper=3      )
checkmate::assert_factor(   ds$manning_proportion_cut3   , any.missing=F                          )

checkmate::assert_integer(  ds$population_count           , any.missing=T , lower=0, upper=600)
checkmate::assert_numeric(  ds$survey_weight_specialty_type  , any.missing=T , lower=1, upper=20)
checkmate::assert_numeric(  ds$fpc_specialty_type         , any.missing=F , lower=0, upper=1)

# checkmate::assert_integer(  ds$officer_count_population_rate      , any.missing=T , lower=421, upper=1483                                    )
# checkmate::assert_integer(  ds$officer_count_sample_rate          , any.missing=T , lower=127, upper=361                                     )
checkmate::assert_numeric(  ds$survey_weight_rate                   , any.missing=T , lower=3, upper=6                                         )
# checkmate::assert_character(ds$survey_weight_label_rate           , any.missing=T , pattern="^.{12,12}$"                                     )
checkmate::assert_numeric(  ds$fpc_rate    , any.missing=F , lower=0, upper=1                                         )


# ds2 <- ds %>%
#   dplyr::filter(is.na(population_count))

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
ds_slim <- ds %>%
  # dplyr::slice(1:100) %>%
  dplyr::select(
    response_id, primary_specialty,
    officer_rank, officer_rate,
    year_executed_order, survey_lag,
    billet_current, order_lead_time,
    transparency_rank, satisfaction_rank, favoritism_rank, assignment_current_choice,
    bonus_pay, bonus_pay_cut3, bonus_pay_cut4,
    critical_war, specialty_type, manning_proportion, manning_proportion_cut3,
    geographic_preference, homestead_length_in_years, homestead_problem,
    career_path,
    doctor_as_detailer,
    match_desirability,
    # match_month,
    assignment_priority, assignment_priority_pretty, officer_rank_priority, officer_rank_priority_pretty,
    order_lead_time_preferred_cut3, order_lead_time_preferred_months,
    population_count,
    survey_weight_specialty_type,
    fpc_specialty_type,
    survey_weight_rate,
    fpc_rate,
  )
ds_slim

# ---- save-to-disk ------------------------------------------------------------
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds_slim, config$path_survey_response_derived_csv)
readr::write_rds(ds_slim, config$path_survey_response_derived_rds, compress="gz") # Save as a compressed R-binary file if it's large or has a lot of factors.
