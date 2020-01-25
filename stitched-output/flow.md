



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
```

```
## Error in config::get(): Config file config.yml not found in current working directory or parent directories
```

```r
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
  "run_r"     , "manipulation/special-manning-by-rank-ellis.R",
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
## [1] FALSE  TRUE  TRUE  TRUE
```

```r
if( !all(file_found) ) {
  warning("--Missing files-- \n", paste0(ds_rail$path[!file_found], collapse="\n"))
  stop("All source files to be run should exist.")
}
```

```
## Warning: --Missing files-- 
## manipulation/special-manning-by-rank-ellis.R
```

```
## Error in eval(expr, envir, enclos): All source files to be run should exist.
```



```r
message("Starting flow of `", basename(base::getwd()), "` at ", Sys.time(), ".")
```

```
## Starting flow of `usnavy-assignment-survey-1` at 2020-01-24 22:33:56.
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
## Starting `special-manning-by-rank-ellis.R` at 2020-01-24 22:33:56.
```

```
## Warning in file(filename, "r", encoding = encoding): cannot
## open file 'manipulation/special-manning-by-rank-ellis.R': No
## such file or directory
```

```
## Error in file(filename, "r", encoding = encoding): cannot open the connection
```

```
## Timing stopped at: 0.001 0 0.001
```

```r
message("Completed flow of `", basename(base::getwd()), "` at ", Sys.time(), "")
```

```
## Completed flow of `usnavy-assignment-survey-1` at 2020-01-24 22:33:56
```

```r
elapsed_duration
```

```
## Error in eval(expr, envir, enclos): object 'elapsed_duration' not found
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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils    
## [6] datasets  methods   base     
## 
## other attached packages:
## [1] survey_3.37    survival_3.1-8 Matrix_1.2-18 
## [4] ggplot2_3.2.1  magrittr_1.5  
## 
## loaded via a namespace (and not attached):
##  [1] tidyselect_0.2.5            xfun_0.12                  
##  [3] purrr_0.3.3                 mitools_2.4                
##  [5] corrplot_0.84               splines_3.6.2              
##  [7] lattice_0.20-38             colorspace_1.4-1           
##  [9] vctrs_0.2.1                 generics_0.0.2             
## [11] htmltools_0.4.0             viridisLite_0.3.0          
## [13] yaml_2.2.0                  utf8_1.1.4                 
## [15] rlang_0.4.2                 pillar_1.4.3               
## [17] glue_1.3.1                  withr_2.1.2                
## [19] DBI_1.1.0                   lifecycle_0.1.0            
## [21] stringr_1.4.0               munsell_0.5.0              
## [23] gtable_0.3.0                rvest_0.3.5                
## [25] kableExtra_1.1.0            evaluate_0.14              
## [27] labeling_0.3                knitr_1.27                 
## [29] import_1.1.0                OuhscMunge_0.1.9.9012      
## [31] fansi_0.4.1                 highr_0.8                  
## [33] broom_0.5.3                 Rcpp_1.0.3                 
## [35] readr_1.3.1                 backports_1.1.5            
## [37] scales_1.1.0                TabularManifest_0.1-16.9003
## [39] webshot_0.5.2               config_0.3                 
## [41] farver_2.0.3                hms_0.5.3                  
## [43] packrat_0.5.0               digest_0.6.23              
## [45] stringi_1.4.5               dplyr_0.8.3                
## [47] cli_2.0.1                   tools_3.6.2                
## [49] lazyeval_0.2.2              tibble_2.1.3               
## [51] crayon_1.3.4                tidyr_1.0.0                
## [53] pkgconfig_2.0.3             zeallot_0.1.0              
## [55] ellipsis_0.3.0              xml2_1.2.2                 
## [57] assertthat_0.2.1            rmarkdown_2.1              
## [59] httr_1.4.1                  rstudioapi_0.10            
## [61] R6_2.4.1                    nlme_3.1-143               
## [63] compiler_3.6.2
```

```r
Sys.time()
```

```
## [1] "2020-01-24 22:33:56 CST"
```

