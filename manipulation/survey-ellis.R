# knitr::stitch_rmd(script="./manipulation/te-ellis.R", output="./stitched-output/manipulation/te-ellis.md") # dir.create("./stitched-output/manipulation/", recursive=T)
# For a brief description of this file see the presentation at
#   - slides: https://rawgit.com/wibeasley/RAnalysisSkeleton/master/documentation/time-and-effort-synthesis.html#/
#   - code: https://github.com/wibeasley/RAnalysisSkeleton/blob/master/documentation/time-and-effort-synthesis.Rpres
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr            , quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        ) # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"       ) # For asserting conditions meet expected patterns/conditions.
requireNamespace("checkmate"    ) # For asserting conditions meet expected patterns/conditions. # remotes::install_github("mllg/checkmate")
requireNamespace("OuhscMunge"   ) # remotes::install_github(repo="OuhscBbmc/OuhscMunge")

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
path_in                        <- "data-public/raw/survey-response.csv"
path_out_csv                   <- "data-public/derived/survey-response.csv"
path_out_rds                   <- "data-public/derived/survey-response.rds"

col_types <- readr::cols_only( # readr::spec_csv(path_in)
  `Response ID`                                                                                                                                                                               = readr::col_integer(),
  `Include/Exclude`                                                                                                                                                                           = readr::col_character(),
  # `Date submitted`                                                                                                                                                                            = readr::col_character(),
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

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
readr::spec_csv(path_in)
ds <- readr::read_csv(path_in   , col_types=col_types)
rm(path_in, col_types)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds) #Spit out columns to help write call ato `dplyr::rename()`.
ds <- ds %>%
  dplyr::select_( #`select()` implicitly drops the other columns not mentioned.
    "response_id"                   = "`Response ID`"
    , "include_exclude"             = "`Include/Exclude`"
    # , "datetime_submitted"          = "`Date submitted`"
    # , "datetime_started"            = "`Date started`"
    # , "datetime_last_action"        = "`Date last action`"
    , "primary_specialty"           = "`What is your primary?specialty-`"
    , "officer_rank"                = "`What is your rank-`"
    , "year_executed_order"         = "`What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.)`"
    , "year_executed_order_other"   = "`What year did you?execute orders for your current billet-? (Consider retour orders the same as a PCS set of orders.) [Other]`"
    , "billet_current"              = "`How would you describe your current billet-`"
    # , "billet_current_other"      = "`How would you describe your current billet- [Other]`"
    , "order_lag_in_months"         = "`For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS-`"
    , "order_lag_in_months_other"   = "`For your last set of orders, how many months prior to your move were your orders released-? That is, how many months did you have to prepare for your PCS- [Other]`"
    , "transparency_rank"           = "`On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-`"
    , "satistfaction_rank"          = "`On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall?detailing experience for your last set of orders-`"
    , "favoritism_rank"             = "`On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-`"
    , "assignment_current"          = "`Describe your current assignment:`"
    , "geographic_preference"       = "`Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 1]` "
    , "career_path"                 = "`Which career path do you want to pursue in the next 5-10? years-`"
    # , "career_path_other"         = "`Which career path do you want to pursue in the next 5-10? years- [Other]`"
    , "doctor_as_detailer"          = "`Neither the Army nor the Air Force have physicians in the detailer role.? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.? This is different from the current Navy Medical Corps billet assignment process where the detailer?is a physician*.? Would you?approve if the detailer position was filled by a non-physician-`"
    , "homestead_length_in_years"   = "`How long should an individual be allowed to remain at one command-`"
    , "homestead_problem"           = "`Do you think that there is a problem in the Medical Corps with members not moving-? That is, are there too many physicians who get to stay in one place too long-`"
    , "match_desirability"          = "`Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.? Of these two options, which would you prefer for your military billet assignment-`"
    , "match_month"                 = "`The later the match day, the more information one has before creating their rank list.? The earlier the match day, the sooner one can have certainty and prepare.? Assuming your were scheduled to?execute new orders in July of 2017, what month would you want the match to occur in-`"
    , "assignment_preference"       = "`Do you think members who are coming from operational or OCONUS assignments should be given preference in billet assignment-`"
    , "officer_rank_preference"     = "`Do you think members with more seniority (as defined by time in service or rank)?should be given preference in billet assignment-`"
  ) %>%
  dplyr::filter(include_exclude == "I") %>%
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
    order_lag_in_months_other       = dplyr::recode(
      order_lag_in_months_other,
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
    order_lag_in_months             = dplyr::recode(order_lag_in_months, "< 1 month"="< 2 months", .default=order_lag_in_months),
    order_lag_in_months             = dplyr::coalesce(order_lag_in_months, order_lag_in_months_other),
    order_lag_in_months             = factor(order_lag_in_months, levels=c("< 1 month", "2-4 months", "> 4 months"), ordered = TRUE)

  ) %>%
  dplyr::select(-include_exclude, -year_executed_order_other, -order_lag_in_months_other)


# table(ds$year_executed_order, ds$year_executed_order_other)
# table(ds$order_lag_in_months)
# table(ds$order_lag_in_months_other)
# class(ds$order_lag_in_months)
# class(ds$order_lag_in_months_other)

# ---- verify-values -----------------------------------------------------------
# Sniff out problems
# OuhscMunge::verify_value_headstart(ds)
checkmate::assert_integer(  ds$response_id               , any.missing=F , lower=15, upper=1368   , unique=T)
checkmate::assert_character(ds$primary_specialty         , any.missing=T , pattern="^.{5,45}$"    )
checkmate::assert_character(ds$officer_rank              , any.missing=T , pattern="^.{2,12}$"    )
checkmate::assert_integer(  ds$year_executed_order       , any.missing=T , lower=2005, upper=2016 )
checkmate::assert_character(ds$billet_current            , any.missing=T , pattern="^.{3,28}$"    )
checkmate::assert_factor(   ds$order_lag_in_months       , any.missing=T                          )
checkmate::assert_integer(  ds$transparency_rank         , any.missing=T , lower=1, upper=5       )
checkmate::assert_integer(  ds$satistfaction_rank        , any.missing=T , lower=1, upper=5       )
checkmate::assert_integer(  ds$favoritism_rank           , any.missing=T , lower=1, upper=5       )
checkmate::assert_character(ds$assignment_current        , any.missing=T , pattern="^.{5,12}$"    )
checkmate::assert_character(ds$geographic_preference     , any.missing=T , pattern="^.{6,38}$"    )
checkmate::assert_character(ds$career_path               , any.missing=T , pattern="^.{5,24}$"    )
checkmate::assert_character(ds$doctor_as_detailer        , any.missing=T , pattern="^.{2,11}$"    )
checkmate::assert_character(ds$homestead_length_in_years , any.missing=T , pattern="^.{5,19}$"    )
checkmate::assert_character(ds$homestead_problem         , any.missing=T , pattern="^.{2,5}$"     )
checkmate::assert_character(ds$match_desirability        , any.missing=T , pattern="^.{5,57}$"    )
checkmate::assert_character(ds$match_month               , any.missing=T , pattern="^.{5,6}$"     )
checkmate::assert_character(ds$assignment_preference     , any.missing=T , pattern="^.{2,3}$"     )
checkmate::assert_character(ds$officer_rank_preference   , any.missing=T , pattern="^.{2,3}$"     )

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write <- c(
  "response_id", "primary_specialty", "officer_rank", "year_executed_order",
  "billet_current", "order_lag_in_months"
  # , "transparency_rank",
  # "satistfaction_rank", "favoritism_rank", "assignment_current",
  # "geographic_preference", "career_path", "doctor_as_detailer",
  # "homestead_length_in_years", "homestead_problem", "match_desirability",
  # "match_month", "assignment_preference", "officer_rank_preference"
)
ds_slim <- ds %>%
  # dplyr::slice(1:100) %>%
  dplyr::select_(.dots=columns_to_write)
ds_slim

rm(columns_to_write)

# ---- save-to-disk ------------------------------------------------------------
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds_slim, path_out_csv)
readr::write_rds(ds_slim, path_out_rds, compress="gz") # Save as a compressed R-binary file if it's large or has a lot of factors.
