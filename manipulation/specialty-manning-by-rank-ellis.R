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
path_in                        <- "data-public/raw/specialty-manning-by-rank.csv"
path_out_csv                   <- "data-public/derived/specialty-manning-by-rank.csv"
path_out_rds                   <- "data-public/derived/specialty-manning-by-rank.rds"

col_types <- readr::cols_only( # readr::spec_csv(path_in)
  specialty  = readr::col_character(),
  rank_6      = readr::col_integer(),
  rank_5      = readr::col_integer(),
  rank_4      = readr::col_integer(),
  rank_3      = readr::col_integer()
)

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
# readr::spec_csv(path_in)
ds <- readr::read_csv(path_in   , col_types=col_types)
rm(path_in, col_types)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds) #Spit out columns to help write call ato `dplyr::rename()`.

ds <- ds %>%
  dplyr::select_( #`select()` implicitly drops the other columns not mentioned.
    "specialty"               = "`specialty`"
    , "rank_6"                = "`rank_6`"
    , "rank_5"                = "`rank_5`"
    , "rank_4"                = "`rank_4`"
    , "rank_3"                = "`rank_3`"
  ) %>%
  tidyr::gather(
    key   = rank,
    value = count,
    -specialty
  ) %>%
  dplyr::mutate(
    rank   = as.integer(sub("^rank_(\\d)$", "\\1", rank))
  )


# ---- inspect -----------------------------------------------------------------
library(ggplot2)

# ggplot(ds, aes(x))


# ---- verify-values -----------------------------------------------------------
# Sniff out problems
# OuhscMunge::verify_value_headstart(ds)
checkmate::assert_character(ds$specialty , any.missing=F , pattern="^.{6,45}$" )
checkmate::assert_integer(  ds$rank      , any.missing=F , lower=3, upper=6    )
checkmate::assert_integer(  ds$count     , any.missing=F , lower=0, upper=578  )


# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write <- c("specialty", "rank", "count")
ds_slim <- ds %>%
  # dplyr::slice(1:100) %>%
  dplyr::select(!!columns_to_write)
ds_slim

rm(columns_to_write)

# ---- save-to-disk ------------------------------------------------------------
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds_slim, path_out_csv)
readr::write_rds(ds_slim, path_out_rds, compress="gz") # Save as a compressed R-binary file if it's large or has a lot of factors.
