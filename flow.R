# knitr::stitch_rmd(script="flow.R", output="stitched-output/flow.md")
rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
import::from("magrittr", "%>%")

requireNamespace("purrr")
requireNamespace("rlang")
# requireNamespace("checkmate")
requireNamespace("OuhscMunge") # remotes::install_github("OuhscBbmc/OuhscMunge")

# ---- declare-globals ---------------------------------------------------------
# Allow multiple files below to have the same chunk name.
#    If the `root.dir` option is properly managed in the Rmd files, no files will be overwritten.
options(knitr.duplicate.label = "allow")

config        <- config::get()

# open log
if( interactive() ) {
  sink_log <- FALSE
} else {
  message("Creating flow log file at ", config$path_log_flow)

  if( !dir.exists(dirname(config$path_log_flow)) ) {
    # Create a month-specific directory, so they're easier to find & compress later.
    dir.create(dirname(config$path_log_flow), recursive=T)
  }

  file_log  <- file(
    description   = config$path_log_flow,
    open          = "wt"
  )
  sink(
    file    = file_log,
    type    = "message"
  )
  sink_log <- TRUE
}
ds_rail  <- tibble::tribble(
  ~fx               , ~path,

  # ETL (extract-transform-load) the data from the outside world.
  "run_r"     , "manipulation/specialty-manning-by-rank-ellis.R",
  "run_r"     , "manipulation/survey-ellis.R",

  # Reports for human consumers.
  "run_rmd"   , "analysis/survey-response-1/survey-response-1.Rmd",
  "run_rmd"   , "analysis/survey-response-2/survey-response-2.Rmd" # This guy needs to be run manually maybe
)

run_r <- function( minion ) {
  message("\nStarting `", basename(minion), "` at ", Sys.time(), ".")
  base::source(minion, local=new.env())
  message("Completed `", basename(minion), "`.")
  return( TRUE )
}
run_sql <- function( minion ) {
  message("\nStarting `", basename(minion), "` at ", Sys.time(), ".")
  OuhscMunge::execute_sql_file(minion, config$dsn_staging)
  message("Completed `", basename(minion), "`.")
  return( TRUE )
}
run_rmd <- function( minion ) {
  message("\nStarting `", basename(minion), "` at ", Sys.time(), ".")
  path_out <- rmarkdown::render(minion, envir=new.env())
  Sys.sleep(3) # Sleep for three secs, to let pandoc finish
  message(path_out)
  return( TRUE )
}

(file_found <- purrr::map_lgl(ds_rail$path, file.exists))
if( !all(file_found) ) {
  warning("--Missing files-- \n", paste0(ds_rail$path[!file_found], collapse="\n"))
  stop("All source files to be run should exist.")
}

# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- run ---------------------------------------------------------------------
message("Starting flow of `", basename(base::getwd()), "` at ", Sys.time(), ".")

warn_level_initial <- as.integer(options("warn"))
# options(warn=0)  # warnings are stored until the top–level function returns
# options(warn=2)  # treat warnings as errors

elapsed_duration <- system.time({
  purrr::map2_lgl(
    ds_rail$fx,
    ds_rail$path,
    function(fn, args) rlang::exec(fn, !!!args)
  )
})

message("Completed flow of `", basename(base::getwd()), "` at ", Sys.time(), "")
elapsed_duration
options(warn=warn_level_initial)  # Restore the whatever warning level you started with.

# ---- close-log ---------------------------------------------------------------
# close(file_log)
if( sink_log ) {
  sink(file = NULL, type = "message") # ends the last diversion (of the specified type).
  message("Closing flow log file at ", gsub("/", "\\\\", config$path_log_flow))
}

# bash: Rscript flow.R
