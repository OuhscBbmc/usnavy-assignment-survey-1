



This report was automatically generated with the R package **knitr**
(version 1.27).


```r
# knitr::stitch_rmd(script="flow.R", output="stitched-output/flow.md")
rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
```


```r
import::from("magrittr", "%>%")

requireNamespace("purrr")
requireNamespace("rlang")
# requireNamespace("checkmate")
requireNamespace("OuhscMunge") # remotes::install_github("OuhscBbmc/OuhscMunge")
```

```r
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
  "run_rmd"   , "analysis/survey-response-2/survey-response-2.Rmd"
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
```

```
## [1] TRUE TRUE TRUE TRUE
```

```r
if( !all(file_found) ) {
  warning("--Missing files-- \n", paste0(ds_rail$path[!file_found], collapse="\n"))
  stop("All source files to be run should exist.")
}
```



```r
message("Starting flow of `", basename(base::getwd()), "` at ", Sys.time(), ".")
```

```
## Starting flow of `usnavy-assignment-survey-1` at 2020-01-24 23:19:10.
```

```r
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
```

```
## 
## Starting `specialty-manning-by-rank-ellis.R` at 2020-01-24 23:19:11.
```

```
## Completed `specialty-manning-by-rank-ellis.R`.
```

```
## 
## Starting `survey-ellis.R` at 2020-01-24 23:19:11.
```

```
## c("Jan-17", "Feb-17", NA, "Dec-16", "Aug-16", "Oct-16", "Jul-16", 
## "Other", "Mar-17", "Sep-16", "Nov-16", "Jun-16", "17-Feb")
```

```
## Completed `survey-ellis.R`.
```

```
## 
## Starting `survey-response-1.Rmd` at 2020-01-24 23:19:11.
```

```
## 
## 
## processing file: survey-response-1.Rmd
```

```
##   |                                                          |                                                  |   0%  |                                                          |.                                                 |   1%
##    inline R code fragments
## 
##   |                                                          |.                                                 |   3%
## label: unnamed-chunk-2 (with options) 
## List of 2
##  $ echo   : symbol F
##  $ message: symbol F
## 
##   |                                                          |..                                                |   4%
##   ordinary text without R code
## 
##   |                                                          |...                                               |   5%
## label: set-options (with options) 
## List of 1
##  $ echo: symbol F
## 
##   |                                                          |...                                               |   7%
##   ordinary text without R code
## 
##   |                                                          |....                                              |   8%
## label: load-sources (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                          |.....                                             |  10%
##   ordinary text without R code
## 
##   |                                                          |.....                                             |  11%
## label: load-packages (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                          |......                                            |  12%
##   ordinary text without R code
## 
##   |                                                          |.......                                           |  14%
## label: declare-globals (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                          |........                                          |  15%
##   ordinary text without R code
## 
##   |                                                          |........                                          |  16%
## label: rmd-specific (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                          |.........                                         |  18%
##   ordinary text without R code
## 
##   |                                                          |..........                                        |  19%
## label: load-data (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                          |..........                                        |  21%
##   ordinary text without R code
## 
##   |                                                          |...........                                       |  22%
## label: tweak-data (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                          |............                                      |  23%
##    inline R code fragments
## 
##   |                                                          |............                                      |  25%
## label: marginals (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |.............                                     |  26%
##   ordinary text without R code
## 
##   |                                                          |..............                                    |  27%
## label: freq-homestead_length_in_years-by-officer_rank (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |..............                                    |  29%
##   ordinary text without R code
## 
##   |                                                          |...............                                   |  30%
## label: freq-homestead_length_in_years-by-specialty_type (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |................                                  |  32%
##   ordinary text without R code
## 
##   |                                                          |................                                  |  33%
## label: freq-homestead_problem-by-officer_rank (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |.................                                 |  34%
##   ordinary text without R code
## 
##   |                                                          |..................                                |  36%
## label: freq-homestead_problem-by-specialty_type (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |..................                                |  37%
##   ordinary text without R code
## 
##   |                                                          |...................                               |  38%
## label: freq-assignment_priority-by-specialty_type (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |....................                              |  40%
##   ordinary text without R code
## 
##   |                                                          |.....................                             |  41%
## label: freq-officer_rank_priority-by-officer_rank (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |.....................                             |  42%
##   ordinary text without R code
## 
##   |                                                          |......................                            |  44%
## label: freq-homestead_length_in_years-by-officer_rank (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |.......................                           |  45%
##   ordinary text without R code
## 
##   |                                                          |.......................                           |  47%
## label: outcome-correlations (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                          |........................                          |  48%
##   ordinary text without R code
## 
##   |                                                          |.........................                         |  49%
## label: by-rank (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |.........................                         |  51%
##   ordinary text without R code
## 
##   |                                                          |..........................                        |  52%
## label: by-specialty-type (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |...........................                       |  53%
##   ordinary text without R code
## 
##   |                                                          |...........................                       |  55%
## label: by-bonus-pay (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |............................                      |  56%
##   ordinary text without R code
## 
##   |                                                          |.............................                     |  58%
## label: by-assignment-current-choice (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |.............................                     |  59%
##   ordinary text without R code
## 
##   |                                                          |..............................                    |  60%
## label: by-year (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |...............................                   |  62%
##   ordinary text without R code
## 
##   |                                                          |................................                  |  63%
## label: by-survey_lag (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |................................                  |  64%
##   ordinary text without R code
## 
##   |                                                          |.................................                 |  66%
## label: by-manning_proportion (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |..................................                |  67%
##   ordinary text without R code
## 
##   |                                                          |..................................                |  68%
## label: by-critical_war (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |...................................               |  70%
##   ordinary text without R code
## 
##   |                                                          |....................................              |  71%
## label: by-billet_current (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |....................................              |  73%
##   ordinary text without R code
## 
##   |                                                          |.....................................             |  74%
## label: by-geographic_preference (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |......................................            |  75%
##   ordinary text without R code
## 
##   |                                                          |......................................            |  77%
## label: by-rank-and-specialty-type (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |.......................................           |  78%
##   ordinary text without R code
## 
##   |                                                          |........................................          |  79%
## label: by-rank-and-assignment-current-choice (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |........................................          |  81%
##   ordinary text without R code
## 
##   |                                                          |.........................................         |  82%
## label: by-rank-and-bonus_pay (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |..........................................        |  84%
##   ordinary text without R code
## 
##   |                                                          |..........................................        |  85%
## label: by-billet_current-and-critical_war (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |...........................................       |  86%
##   ordinary text without R code
## 
##   |                                                          |............................................      |  88%
## label: by-bonus_pay-and-manning_proportion (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |.............................................     |  89%
##   ordinary text without R code
## 
##   |                                                          |.............................................     |  90%
## label: by-billet-and-rate (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
## 
##   |                                                          |..............................................    |  92%
##   ordinary text without R code
## 
##   |                                                          |...............................................   |  93%
## label: graph-equal-slopes (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                          |...............................................   |  95%
##   ordinary text without R code
## 
##   |                                                          |................................................  |  96%
## label: session-info-3 (with options) 
## List of 1
##  $ echo: logi FALSE
## 
##   |                                                          |................................................. |  97%
##   ordinary text without R code
## 
##   |                                                          |................................................. |  99%
## label: session-duration (with options) 
## List of 1
##  $ echo: logi FALSE
## 
##   |                                                          |..................................................| 100%
##    inline R code fragments
```

```
## output file: survey-response-1.knit.md
```

```
## /usr/bin/pandoc +RTS -K512m -RTS survey-response-1.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash+smart --output survey-response-1.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 3 --variable toc_float=1 --variable toc_selectors=h1,h2,h3 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --number-sections --variable 'theme:bootstrap' --include-in-header /tmp/RtmpTbCNeW/rmarkdown-str70663609fc38.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/lua/latex-div.lua
```

```
## 
## Output created: survey-response-1.html
```

```
## /home/wibeasley/Documents/bbmc/usnavy-assignment-survey-1/analysis/survey-response-1/survey-response-1.html
```

```
## 
## Starting `survey-response-2.Rmd` at 2020-01-24 23:20:40.
```

```
## 
## 
## processing file: survey-response-2.Rmd
```

```
##   |                                                                                                  |                                                                                          |   0%  |                                                                                                  |.                                                                                         |   2%
##    inline R code fragments
## 
##   |                                                                                                  |...                                                                                       |   3%
## label: unnamed-chunk-1-2 (with options) 
## List of 2
##  $ echo   : symbol F
##  $ message: symbol F
## 
##   |                                                                                                  |....                                                                                      |   5%
##   ordinary text without R code
## 
##   |                                                                                                  |......                                                                                    |   6%
## label: set-options (with options) 
## List of 1
##  $ echo: symbol F
## 
##   |                                                                                                  |.......                                                                                   |   8%
##   ordinary text without R code
## 
##   |                                                                                                  |.........                                                                                 |  10%
## label: load-sources (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |..........                                                                                |  11%
##   ordinary text without R code
## 
##   |                                                                                                  |...........                                                                               |  13%
## label: load-packages (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |.............                                                                             |  14%
##   ordinary text without R code
## 
##   |                                                                                                  |..............                                                                            |  16%
## label: declare-globals (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |................                                                                          |  17%
##   ordinary text without R code
## 
##   |                                                                                                  |.................                                                                         |  19%
## label: rmd-specific (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |...................                                                                       |  21%
##   ordinary text without R code
## 
##   |                                                                                                  |....................                                                                      |  22%
## label: load-data (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |.....................                                                                     |  24%
##   ordinary text without R code
## 
##   |                                                                                                  |.......................                                                                   |  25%
## label: tweak-data (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ results: chr "show"
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |........................                                                                  |  27%
##    inline R code fragments
## 
##   |                                                                                                  |..........................                                                                |  29%
## label: marginals (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                                                                  |...........................                                                               |  30%
##   ordinary text without R code
## 
##   |                                                                                                  |.............................                                                             |  32%
## label: survey-response (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |..............................                                                            |  33%
##   ordinary text without R code
## 
##   |                                                                                                  |...............................                                                           |  35%
## label: outcome-correlations (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
```

```
##   |                                                                                                  |.................................                                                         |  37%
##   ordinary text without R code
## 
##   |                                                                                                  |..................................                                                        |  38%
## label: by-rank (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |....................................                                                      |  40%
##   ordinary text without R code
## 
##   |                                                                                                  |.....................................                                                     |  41%
## label: by-specialty-type (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.......................................                                                   |  43%
##   ordinary text without R code
## 
##   |                                                                                                  |........................................                                                  |  44%
## label: by-bonus-pay (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.........................................                                                 |  46%
##   ordinary text without R code
## 
##   |                                                                                                  |...........................................                                               |  48%
## label: by-assignment-current-choice (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |............................................                                              |  49%
##   ordinary text without R code
## 
##   |                                                                                                  |..............................................                                            |  51%
## label: by-manning_proportion (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |...............................................                                           |  52%
##   ordinary text without R code
## 
##   |                                                                                                  |.................................................                                         |  54%
## label: by-critical_war (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |..................................................                                        |  56%
##   ordinary text without R code
## 
##   |                                                                                                  |...................................................                                       |  57%
## label: by-billet_current (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.....................................................                                     |  59%
##   ordinary text without R code
## 
##   |                                                                                                  |......................................................                                    |  60%
## label: by-rank-and-specialty-type (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |........................................................                                  |  62%
##   ordinary text without R code
## 
##   |                                                                                                  |.........................................................                                 |  63%
## label: by-rank-and-assignment-current-choice (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
## 
##   |                                                                                                  |...........................................................                               |  65%
##   ordinary text without R code
## 
##   |                                                                                                  |............................................................                              |  67%
## label: by-rank-and-bonus_pay (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.............................................................                             |  68%
##   ordinary text without R code
## 
##   |                                                                                                  |...............................................................                           |  70%
## label: by-billet_current-and-critical_war (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |................................................................                          |  71%
##   ordinary text without R code
## 
##   |                                                                                                  |..................................................................                        |  73%
## label: by-bonus_pay-and-manning_proportion (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |...................................................................                       |  75%
##   ordinary text without R code
## 
##   |                                                                                                  |.....................................................................                     |  76%
## label: by-billet-and-rate (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |......................................................................                    |  78%
##   ordinary text without R code
## 
##   |                                                                                                  |.......................................................................                   |  79%
## label: 3-predictor (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.........................................................................                 |  81%
##   ordinary text without R code
## 
##   |                                                                                                  |..........................................................................                |  83%
## label: 3-predictor-with-weights (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
## 
##   |                                                                                                  |............................................................................              |  84%
##   ordinary text without R code
## 
##   |                                                                                                  |.............................................................................             |  86%
## label: billet-intercept (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |...............................................................................           |  87%
##   ordinary text without R code
## 
##   |                                                                                                  |................................................................................          |  89%
## label: specialty-intercept (with options) 
## List of 3
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
##  $ results: chr "asis"
```

```
##   |                                                                                                  |.................................................................................         |  90%
##   ordinary text without R code
## 
##   |                                                                                                  |...................................................................................       |  92%
## label: nonsignificant-additions (with options) 
## List of 2
##  $ echo   : symbol echo_chunks
##  $ message: symbol message_chunks
## 
##   |                                                                                                  |....................................................................................      |  94%
##   ordinary text without R code
## 
##   |                                                                                                  |......................................................................................    |  95%
## label: session-info-3 (with options) 
## List of 1
##  $ echo: logi FALSE
## 
##   |                                                                                                  |.......................................................................................   |  97%
##   ordinary text without R code
## 
##   |                                                                                                  |......................................................................................... |  98%
## label: session-duration (with options) 
## List of 1
##  $ echo: logi FALSE
## 
##   |                                                                                                  |..........................................................................................| 100%
##    inline R code fragments
```

```
## output file: survey-response-2.knit.md
```

```
## /usr/bin/pandoc +RTS -K512m -RTS survey-response-2.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash+smart --output survey-response-2.html --email-obfuscation none --self-contained --standalone --section-divs --table-of-contents --toc-depth 3 --variable toc_float=1 --variable toc_selectors=h1,h2,h3 --variable toc_collapsed=1 --variable toc_smooth_scroll=1 --variable toc_print=1 --template /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --number-sections --variable 'theme:bootstrap' --include-in-header /tmp/RtmpTbCNeW/rmarkdown-str706665c6e309.html --mathjax --variable 'mathjax-url:https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --lua-filter /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6/rmarkdown/rmd/lua/latex-div.lua
```

```
## 
## Output created: survey-response-2.html
```

```
## /home/wibeasley/Documents/bbmc/usnavy-assignment-survey-1/analysis/survey-response-2/survey-response-2.html
```

```r
message("Completed flow of `", basename(base::getwd()), "` at ", Sys.time(), "")
```

```
## Completed flow of `usnavy-assignment-survey-1` at 2020-01-24 23:21:06
```

<img src="figure/flow-Rmdrun-1.png" title="plot of chunk run" alt="plot of chunk run" style="display: block; margin: auto;" />

```r
elapsed_duration
```

```
##    user  system elapsed 
## 103.699   6.201 115.826
```

```r
options(warn=warn_level_initial)  # Restore the whatever warning level you started with.
```

```r
# close(file_log)
if( sink_log ) {
  sink(file = NULL, type = "message") # ends the last diversion (of the specified type).
  message("Closing flow log file at ", gsub("/", "\\\\", config$path_log_flow))
}

# bash: Rscript flow.R
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.6.2 (2019-12-12)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 19.10
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.8.0
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.8.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8       
##  [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.27     survey_3.37    survival_3.1-8 Matrix_1.2-18  ggplot2_3.2.1  magrittr_1.5  
## 
## loaded via a namespace (and not attached):
##  [1] httr_1.4.1                  pkgload_1.0.2               tidyr_1.0.0                
##  [4] viridisLite_0.3.0           splines_3.6.2               OuhscMunge_0.1.9.9012      
##  [7] assertthat_0.2.1            highr_0.8                   yaml_2.2.0                 
## [10] remotes_2.1.0               sessioninfo_1.1.1           corrplot_0.84              
## [13] pillar_1.4.3                backports_1.1.5             lattice_0.20-38            
## [16] glue_1.3.1                  digest_0.6.23               checkmate_1.9.4            
## [19] rvest_0.3.5                 testit_0.11.1               colorspace_1.4-1           
## [22] htmltools_0.4.0             pkgconfig_2.0.3             devtools_2.2.1             
## [25] broom_0.5.3                 config_0.3                  purrr_0.3.3                
## [28] scales_1.1.0                webshot_0.5.2               processx_3.4.1             
## [31] tibble_2.1.3                generics_0.0.2              farver_2.0.3               
## [34] usethis_1.5.1               ellipsis_0.3.0              withr_2.1.2                
## [37] lazyeval_0.2.2              cli_2.0.1                   crayon_1.3.4               
## [40] memoise_1.1.0               evaluate_0.14               ps_1.3.0                   
## [43] fs_1.3.1                    fansi_0.4.1                 TabularManifest_0.1-16.9003
## [46] nlme_3.1-143                xml2_1.2.2                  pkgbuild_1.0.6             
## [49] rsconnect_0.8.16            tools_3.6.2                 prettyunits_1.1.0          
## [52] hms_0.5.3                   mitools_2.4                 lifecycle_0.1.0            
## [55] stringr_1.4.0               munsell_0.5.0               callr_3.4.0                
## [58] packrat_0.5.0               kableExtra_1.1.0            compiler_3.6.2             
## [61] rlang_0.4.2                 rstudioapi_0.10             labeling_0.3               
## [64] rmarkdown_2.1               testthat_2.3.1              gtable_0.3.0               
## [67] DBI_1.1.0                   markdown_1.1                R6_2.4.1                   
## [70] dplyr_0.8.3                 utf8_1.1.4                  zeallot_0.1.0              
## [73] rprojroot_1.3-2             readr_1.3.1                 desc_1.2.0                 
## [76] stringi_1.4.5               Rcpp_1.0.3                  import_1.1.0               
## [79] vctrs_0.2.1                 tidyselect_0.2.5            xfun_0.12
```

```r
Sys.time()
```

```
## [1] "2020-01-24 23:21:07 CST"
```

