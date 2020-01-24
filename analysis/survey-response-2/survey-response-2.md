---
title: Attitudes Regarding the Assignment Process Among Navy Medical Corps Officers
date: "Date: 2020-01-24"
output:
  html_document:
    keep_md: yes
    toc: 4
    toc_float: true
    number_sections: true
---

This report covers the survey about attitudes collected by Richard Childers, MD and Joel Schofer, MD.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->


<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load 'sourced' R files.  Suppress the output when loading sources. --> 


<!-- Load packages, or at least verify they're available on the local machine.  Suppress the output when loading packages. --> 


<!-- Load any global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


Summary {.tabset .tabset-fade .tabset-pills}
============================================

Notes 
-----------------------------------

1. The current report covers 951 responses.
1. We excluded 17 cases because their orders preceded the year 2012 and 26 cases because the `year_executed_order` value was missing.

Unanswered Questions
-----------------------------------

Answered Questions
-----------------------------------

Histograms
============================================

Univariate
-----------------------------------
![](figure-png/marginals-1.png)<!-- -->![](figure-png/marginals-2.png)<!-- -->

```
Warning: Factor `iv` contains implicit NA, consider using `forcats::fct_explicit_na`
```

![](figure-png/marginals-3.png)<!-- -->![](figure-png/marginals-4.png)<!-- -->![](figure-png/marginals-5.png)<!-- -->

```
Warning: Factor `iv` contains implicit NA, consider using `forcats::fct_explicit_na`
```

![](figure-png/marginals-6.png)<!-- -->![](figure-png/marginals-7.png)<!-- -->![](figure-png/marginals-8.png)<!-- -->![](figure-png/marginals-9.png)<!-- -->![](figure-png/marginals-10.png)<!-- -->![](figure-png/marginals-11.png)<!-- -->![](figure-png/marginals-12.png)<!-- -->

```
Satisfaction summary
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   1.00    3.00    4.00    3.63    5.00    5.00      79 
```

```
Satisfaction summary (emergency medicine only)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  1.000   3.000   4.000   3.759   5.000   5.000       5 
```

```
Counts by bonus pay & specialty
```



|bonus_pay_cut4 |specialty_type |   n|
|:--------------|:--------------|---:|
|$0             |operational    |  78|
|$0             |resident       |  50|
|$20-24k        |nonsurgical    | 322|
|$20-24k        |family         | 177|
|$20-24k        |operational    |  12|
|$24-32k        |nonsurgical    |  70|
|$24-32k        |surgical       | 109|
|$24-32k        |unknown        |   6|
|32k+           |nonsurgical    |  79|
|32k+           |surgical       |  48|

Survey Response
============================================

```
Overall unweighted mean satisfaction:
```

```
[1] 3.629587
```

```
Overall weighted mean satisfaction:
```

```
                    mean     SE
satisfaction_rank 3.4141 0.0645
```

```
`specialty_type` unweighted mean satisfaction:
```

```
# A tibble: 6 x 2
  specialty_type satisfaction_rank
  <fct>                      <dbl>
1 nonsurgical                 3.92
2 surgical                    3.68
3 family                      3.35
4 operational                 2.66
5 resident                    3.52
6 unknown                     3.4 
```

```
`specialty_type` weighted mean satisfaction:
```

```
# A tibble: 5 x 3
  specialty_type satisfaction_rank     se
  <fct>                      <dbl>  <dbl>
1 nonsurgical                 3.92 0.0587
2 surgical                    3.68 0.107 
3 family                      3.35 0.111 
4 operational                 2.66 0.162 
5 resident                    3.52 0.192 
```

```
`billet_current` unweighted mean satisfaction:
```

```
# A tibble: 6 x 2
  billet_current           satisfaction_rank
  <fct>                                <dbl>
1 CONUS MTF                             3.85
2 Non-Operational/Clinical              3.65
3 OCONUS MTF                            3.41
4 CONUS Operational                     3.12
5 OCONUS Operational                    2.45
6 Other                                 4   
```

```
`billet_current` weighted mean satisfaction:
```

```
# A tibble: 6 x 3
  billet_current           satisfaction_rank     se
  <fct>                                <dbl>  <dbl>
1 CONUS MTF                             3.70 0.0721
2 Non-Operational/Clinical              3.33 0.317 
3 OCONUS MTF                            3.50 0.154 
4 CONUS Operational                     2.94 0.167 
5 OCONUS Operational                    2.16 0.266 
6 Other                                 3.78 0.482 
```

Relationships between Outcomes
============================================

                             satisfaction rank   transparency rank   favoritism rank   assignment current choice
--------------------------  ------------------  ------------------  ----------------  --------------------------
satisfaction_rank                        1.000               0.771             0.486                      -0.519
transparency_rank                        0.771               1.000             0.488                      -0.405
favoritism_rank                          0.486               0.488             1.000                      -0.325
assignment_current_choice               -0.519              -0.405            -0.325                       1.000

![](figure-png/outcome-correlations-1.png)<!-- -->![](figure-png/outcome-correlations-2.png)<!-- -->


Analyses - 1 Predictor
============================================

By Rank
-----------------------------------
### satisfaction_rank

![](figure-png/by-rank-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + officer_rate_f </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.1361502 </td>
   <td style="text-align:right;"> 0.0903269 </td>
   <td style="text-align:right;"> 34.720017 </td>
   <td style="text-align:right;"> 0.00e+00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4 </td>
   <td style="text-align:right;"> 0.4547589 </td>
   <td style="text-align:right;"> 0.1158670 </td>
   <td style="text-align:right;"> 3.924834 </td>
   <td style="text-align:right;"> 9.37e-05 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5 </td>
   <td style="text-align:right;"> 0.7953566 </td>
   <td style="text-align:right;"> 0.1268635 </td>
   <td style="text-align:right;"> 6.269388 </td>
   <td style="text-align:right;"> 0.00e+00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6 </td>
   <td style="text-align:right;"> 0.9934794 </td>
   <td style="text-align:right;"> 0.1557247 </td>
   <td style="text-align:right;"> 6.379715 </td>
   <td style="text-align:right;"> 0.00e+00 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0619066 </td>
   <td style="text-align:right;"> 0.0586569 </td>
   <td style="text-align:right;"> 1.318277 </td>
   <td style="text-align:right;"> 19.04967 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> -1472.875 </td>
   <td style="text-align:right;"> 2955.751 </td>
   <td style="text-align:right;"> 2979.593 </td>
   <td style="text-align:right;"> 1504.982 </td>
   <td style="text-align:right;"> 866 </td>
  </tr>
</tbody>
</table>

By Specialty Type
-----------------------------------
### satisfaction_rank

![](figure-png/by-specialty-type-1.png)<!-- --><br/>Data:<code> [ ds ds$specialty_type != "unknown"  </code><br/>Formula:<code> ~ satisfaction_rank 1 + specialty_type </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.9172414 </td>
   <td style="text-align:right;"> 0.0625729 </td>
   <td style="text-align:right;"> 62.602823 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typesurgical </td>
   <td style="text-align:right;"> -0.2326776 </td>
   <td style="text-align:right;"> 0.1238796 </td>
   <td style="text-align:right;"> -1.878257 </td>
   <td style="text-align:right;"> 0.0606834 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typefamily </td>
   <td style="text-align:right;"> -0.5635828 </td>
   <td style="text-align:right;"> 0.1195853 </td>
   <td style="text-align:right;"> -4.712809 </td>
   <td style="text-align:right;"> 0.0000028 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeoperational </td>
   <td style="text-align:right;"> -1.2544507 </td>
   <td style="text-align:right;"> 0.1540125 </td>
   <td style="text-align:right;"> -8.145121 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeresident </td>
   <td style="text-align:right;"> -0.4020899 </td>
   <td style="text-align:right;"> 0.2356418 </td>
   <td style="text-align:right;"> -1.706360 </td>
   <td style="text-align:right;"> 0.0883012 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0811978 </td>
   <td style="text-align:right;"> 0.0769342 </td>
   <td style="text-align:right;"> 1.305062 </td>
   <td style="text-align:right;"> 19.04449 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> -1458.551 </td>
   <td style="text-align:right;"> 2929.103 </td>
   <td style="text-align:right;"> 2957.693 </td>
   <td style="text-align:right;"> 1468.146 </td>
   <td style="text-align:right;"> 862 </td>
  </tr>
</tbody>
</table>

By Bonus Pay
-----------------------------------
### satisfaction_rank

![](figure-png/by-bonus-pay-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + bonus_pay_cut4 </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.8411215 </td>
   <td style="text-align:right;"> 0.1285699 </td>
   <td style="text-align:right;"> 22.097867 </td>
   <td style="text-align:right;"> 0e+00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay_cut4$20-24k </td>
   <td style="text-align:right;"> 0.8846169 </td>
   <td style="text-align:right;"> 0.1423437 </td>
   <td style="text-align:right;"> 6.214653 </td>
   <td style="text-align:right;"> 0e+00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay_cut4$24-32k </td>
   <td style="text-align:right;"> 0.9289934 </td>
   <td style="text-align:right;"> 0.1633872 </td>
   <td style="text-align:right;"> 5.685841 </td>
   <td style="text-align:right;"> 0e+00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay_cut432k+ </td>
   <td style="text-align:right;"> 0.9110153 </td>
   <td style="text-align:right;"> 0.1778978 </td>
   <td style="text-align:right;"> 5.121004 </td>
   <td style="text-align:right;"> 4e-07 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0472242 </td>
   <td style="text-align:right;"> 0.0439312 </td>
   <td style="text-align:right;"> 1.329938 </td>
   <td style="text-align:right;"> 14.34077 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> -1483.945 </td>
   <td style="text-align:right;"> 2977.89 </td>
   <td style="text-align:right;"> 3001.744 </td>
   <td style="text-align:right;"> 1535.262 </td>
   <td style="text-align:right;"> 868 </td>
  </tr>
</tbody>
</table>

By Assignment Current Choice
-----------------------------------
### satisfaction_rank

![](figure-png/by-assignment-current-choice-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + assignment_current_choice </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 4.7192430 </td>
   <td style="text-align:right;"> 0.0674241 </td>
   <td style="text-align:right;"> 69.99342 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> assignment_current_choice </td>
   <td style="text-align:right;"> -0.5721764 </td>
   <td style="text-align:right;"> 0.0342102 </td>
   <td style="text-align:right;"> -16.72533 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.2693047 </td>
   <td style="text-align:right;"> 0.268342 </td>
   <td style="text-align:right;"> 1.074932 </td>
   <td style="text-align:right;"> 279.7366 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> -1133.799 </td>
   <td style="text-align:right;"> 2273.598 </td>
   <td style="text-align:right;"> 2287.502 </td>
   <td style="text-align:right;"> 877.0091 </td>
   <td style="text-align:right;"> 759 </td>
  </tr>
</tbody>
</table>


By Manning Proportion
-----------------------------------
### manning_proportion

![](figure-png/by-manning_proportion-1.png)<!-- -->![](figure-png/by-manning_proportion-2.png)<!-- -->

By Critical War
-----------------------------------
![](figure-png/by-critical_war-1.png)<!-- -->

By Billet Current
-----------------------------------
![](figure-png/by-billet_current-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.8472469 </td>
   <td style="text-align:right;"> 0.0553450 </td>
   <td style="text-align:right;"> 69.5139096 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.2014136 </td>
   <td style="text-align:right;"> 0.1974596 </td>
   <td style="text-align:right;"> -1.0200240 </td>
   <td style="text-align:right;"> 0.3080020 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.4372469 </td>
   <td style="text-align:right;"> 0.1425066 </td>
   <td style="text-align:right;"> -3.0682562 </td>
   <td style="text-align:right;"> 0.0022201 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.7311755 </td>
   <td style="text-align:right;"> 0.1358693 </td>
   <td style="text-align:right;"> -5.3814634 </td>
   <td style="text-align:right;"> 0.0000001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.3972469 </td>
   <td style="text-align:right;"> 0.2148854 </td>
   <td style="text-align:right;"> -6.5022872 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOther </td>
   <td style="text-align:right;"> 0.1527531 </td>
   <td style="text-align:right;"> 0.4412199 </td>
   <td style="text-align:right;"> 0.3462063 </td>
   <td style="text-align:right;"> 0.7292718 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0731888 </td>
   <td style="text-align:right;"> 0.0678376 </td>
   <td style="text-align:right;"> 1.313205 </td>
   <td style="text-align:right;"> 13.67732 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> -1471.899 </td>
   <td style="text-align:right;"> 2957.797 </td>
   <td style="text-align:right;"> 2991.193 </td>
   <td style="text-align:right;"> 1493.423 </td>
   <td style="text-align:right;"> 866 </td>
  </tr>
</tbody>
</table>


Analyses - 2 Predictors
============================================


By Rank and Specialty Type
-----------------------------------
### satisfaction_rank

![](figure-png/by-rank-and-specialty-type-1.png)<!-- --><br/>Data:<code> [ ds ds$specialty_type != "unknown"  </code><br/>Formula:<code> ~ satisfaction_rank 1 + officer_rate_f * specialty_type </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.7794118 </td>
   <td style="text-align:right;"> 0.1553781 </td>
   <td style="text-align:right;"> 24.3239628 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4 </td>
   <td style="text-align:right;"> -0.0092968 </td>
   <td style="text-align:right;"> 0.1832411 </td>
   <td style="text-align:right;"> -0.0507355 </td>
   <td style="text-align:right;"> 0.9595483 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5 </td>
   <td style="text-align:right;"> 0.2560492 </td>
   <td style="text-align:right;"> 0.1891705 </td>
   <td style="text-align:right;"> 1.3535366 </td>
   <td style="text-align:right;"> 0.1762449 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6 </td>
   <td style="text-align:right;"> 0.5539216 </td>
   <td style="text-align:right;"> 0.2373440 </td>
   <td style="text-align:right;"> 2.3338342 </td>
   <td style="text-align:right;"> 0.0198372 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typesurgical </td>
   <td style="text-align:right;"> -0.1127451 </td>
   <td style="text-align:right;"> 0.3654966 </td>
   <td style="text-align:right;"> -0.3084710 </td>
   <td style="text-align:right;"> 0.7577997 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typefamily </td>
   <td style="text-align:right;"> -0.9315857 </td>
   <td style="text-align:right;"> 0.2446039 </td>
   <td style="text-align:right;"> -3.8085478 </td>
   <td style="text-align:right;"> 0.0001499 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeoperational </td>
   <td style="text-align:right;"> -1.3667134 </td>
   <td style="text-align:right;"> 0.2240553 </td>
   <td style="text-align:right;"> -6.0998925 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeresident </td>
   <td style="text-align:right;"> -0.2294118 </td>
   <td style="text-align:right;"> 0.3259239 </td>
   <td style="text-align:right;"> -0.7038814 </td>
   <td style="text-align:right;"> 0.4816999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4:specialty_typesurgical </td>
   <td style="text-align:right;"> -0.2384509 </td>
   <td style="text-align:right;"> 0.4064573 </td>
   <td style="text-align:right;"> -0.5866567 </td>
   <td style="text-align:right;"> 0.5575904 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5:specialty_typesurgical </td>
   <td style="text-align:right;"> 0.0516431 </td>
   <td style="text-align:right;"> 0.4328109 </td>
   <td style="text-align:right;"> 0.1193202 </td>
   <td style="text-align:right;"> 0.9050499 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6:specialty_typesurgical </td>
   <td style="text-align:right;"> -0.1253501 </td>
   <td style="text-align:right;"> 0.4939158 </td>
   <td style="text-align:right;"> -0.2537885 </td>
   <td style="text-align:right;"> 0.7997205 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4:specialty_typefamily </td>
   <td style="text-align:right;"> 0.6244337 </td>
   <td style="text-align:right;"> 0.3157016 </td>
   <td style="text-align:right;"> 1.9779237 </td>
   <td style="text-align:right;"> 0.0482607 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5:specialty_typefamily </td>
   <td style="text-align:right;"> 0.3285571 </td>
   <td style="text-align:right;"> 0.3403586 </td>
   <td style="text-align:right;"> 0.9653265 </td>
   <td style="text-align:right;"> 0.3346565 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6:specialty_typefamily </td>
   <td style="text-align:right;"> 0.4871412 </td>
   <td style="text-align:right;"> 0.3909269 </td>
   <td style="text-align:right;"> 1.2461183 </td>
   <td style="text-align:right;"> 0.2130651 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4:specialty_typeoperational </td>
   <td style="text-align:right;"> 0.6680270 </td>
   <td style="text-align:right;"> 0.4205932 </td>
   <td style="text-align:right;"> 1.5882972 </td>
   <td style="text-align:right;"> 0.1125919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5:specialty_typeoperational </td>
   <td style="text-align:right;"> 2.3312524 </td>
   <td style="text-align:right;"> 1.3051914 </td>
   <td style="text-align:right;"> 1.7861383 </td>
   <td style="text-align:right;"> 0.0744341 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6:specialty_typeoperational </td>
   <td style="text-align:right;"> 0.6583800 </td>
   <td style="text-align:right;"> 0.5362841 </td>
   <td style="text-align:right;"> 1.2276701 </td>
   <td style="text-align:right;"> 0.2199115 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4:specialty_typeresident </td>
   <td style="text-align:right;"> -0.0791647 </td>
   <td style="text-align:right;"> 0.4918785 </td>
   <td style="text-align:right;"> -0.1609436 </td>
   <td style="text-align:right;"> 0.8721761 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.1249664 </td>
   <td style="text-align:right;"> 0.1074244 </td>
   <td style="text-align:right;"> 1.281281 </td>
   <td style="text-align:right;"> 7.123859 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> -1434.353 </td>
   <td style="text-align:right;"> 2906.706 </td>
   <td style="text-align:right;"> 2997.22 </td>
   <td style="text-align:right;"> 1392.145 </td>
   <td style="text-align:right;"> 848 </td>
  </tr>
</tbody>
</table><br/>Data:<code> [ ds ds$specialty_type != "unknown"  </code><br/>Formula:<code> ~ satisfaction_rank 1 + officer_rate_f + specialty_type </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.6060419 </td>
   <td style="text-align:right;"> 0.1138533 </td>
   <td style="text-align:right;"> 31.6726901 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4 </td>
   <td style="text-align:right;"> 0.1894040 </td>
   <td style="text-align:right;"> 0.1227398 </td>
   <td style="text-align:right;"> 1.5431344 </td>
   <td style="text-align:right;"> 0.1231669 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5 </td>
   <td style="text-align:right;"> 0.4624532 </td>
   <td style="text-align:right;"> 0.1364136 </td>
   <td style="text-align:right;"> 3.3900819 </td>
   <td style="text-align:right;"> 0.0007306 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6 </td>
   <td style="text-align:right;"> 0.7806986 </td>
   <td style="text-align:right;"> 0.1587342 </td>
   <td style="text-align:right;"> 4.9182747 </td>
   <td style="text-align:right;"> 0.0000010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typesurgical </td>
   <td style="text-align:right;"> -0.2466207 </td>
   <td style="text-align:right;"> 0.1222314 </td>
   <td style="text-align:right;"> -2.0176535 </td>
   <td style="text-align:right;"> 0.0439382 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typefamily </td>
   <td style="text-align:right;"> -0.5476117 </td>
   <td style="text-align:right;"> 0.1188297 </td>
   <td style="text-align:right;"> -4.6083747 </td>
   <td style="text-align:right;"> 0.0000047 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeoperational </td>
   <td style="text-align:right;"> -1.0520849 </td>
   <td style="text-align:right;"> 0.1656575 </td>
   <td style="text-align:right;"> -6.3509630 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeresident </td>
   <td style="text-align:right;"> -0.1655041 </td>
   <td style="text-align:right;"> 0.2383040 </td>
   <td style="text-align:right;"> -0.6945081 </td>
   <td style="text-align:right;"> 0.4875516 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.113058 </td>
   <td style="text-align:right;"> 0.1058219 </td>
   <td style="text-align:right;"> 1.282431 </td>
   <td style="text-align:right;"> 15.62411 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> -1440.206 </td>
   <td style="text-align:right;"> 2898.412 </td>
   <td style="text-align:right;"> 2941.287 </td>
   <td style="text-align:right;"> 1411.091 </td>
   <td style="text-align:right;"> 858 </td>
  </tr>
</tbody>
</table>

By Rank and Assignment Current Choice
-----------------------------------


By Rank and Bonus Pay
-----------------------------------
### satisfaction_rank

![](figure-png/by-rank-and-bonus_pay-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + officer_rate_f + bonus_pay </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.9244122 </td>
   <td style="text-align:right;"> 0.1132714 </td>
   <td style="text-align:right;"> 25.817747 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4 </td>
   <td style="text-align:right;"> 0.2934115 </td>
   <td style="text-align:right;"> 0.1267040 </td>
   <td style="text-align:right;"> 2.315724 </td>
   <td style="text-align:right;"> 0.0208064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5 </td>
   <td style="text-align:right;"> 0.6032909 </td>
   <td style="text-align:right;"> 0.1408814 </td>
   <td style="text-align:right;"> 4.282261 </td>
   <td style="text-align:right;"> 0.0000206 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6 </td>
   <td style="text-align:right;"> 0.8478220 </td>
   <td style="text-align:right;"> 0.1620620 </td>
   <td style="text-align:right;"> 5.231467 </td>
   <td style="text-align:right;"> 0.0000002 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay </td>
   <td style="text-align:right;"> 0.0000158 </td>
   <td style="text-align:right;"> 0.0000051 </td>
   <td style="text-align:right;"> 3.072155 </td>
   <td style="text-align:right;"> 0.0021917 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0720318 </td>
   <td style="text-align:right;"> 0.0677406 </td>
   <td style="text-align:right;"> 1.311901 </td>
   <td style="text-align:right;"> 16.786 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> -1468.155 </td>
   <td style="text-align:right;"> 2948.309 </td>
   <td style="text-align:right;"> 2976.92 </td>
   <td style="text-align:right;"> 1488.738 </td>
   <td style="text-align:right;"> 865 </td>
  </tr>
</tbody>
</table><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + officer_rate_f * bonus_pay </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.6738295 </td>
   <td style="text-align:right;"> 0.1412220 </td>
   <td style="text-align:right;"> 18.933520 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4 </td>
   <td style="text-align:right;"> 0.9876528 </td>
   <td style="text-align:right;"> 0.2498733 </td>
   <td style="text-align:right;"> 3.952615 </td>
   <td style="text-align:right;"> 0.0000836 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5 </td>
   <td style="text-align:right;"> 0.8154021 </td>
   <td style="text-align:right;"> 0.3806246 </td>
   <td style="text-align:right;"> 2.142274 </td>
   <td style="text-align:right;"> 0.0324510 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6 </td>
   <td style="text-align:right;"> 1.1783927 </td>
   <td style="text-align:right;"> 0.4842708 </td>
   <td style="text-align:right;"> 2.433334 </td>
   <td style="text-align:right;"> 0.0151628 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay </td>
   <td style="text-align:right;"> 0.0000345 </td>
   <td style="text-align:right;"> 0.0000081 </td>
   <td style="text-align:right;"> 4.232110 </td>
   <td style="text-align:right;"> 0.0000256 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f4:bonus_pay </td>
   <td style="text-align:right;"> -0.0000374 </td>
   <td style="text-align:right;"> 0.0000115 </td>
   <td style="text-align:right;"> -3.245845 </td>
   <td style="text-align:right;"> 0.0012162 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f5:bonus_pay </td>
   <td style="text-align:right;"> -0.0000172 </td>
   <td style="text-align:right;"> 0.0000157 </td>
   <td style="text-align:right;"> -1.096670 </td>
   <td style="text-align:right;"> 0.2730919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate_f6:bonus_pay </td>
   <td style="text-align:right;"> -0.0000222 </td>
   <td style="text-align:right;"> 0.0000213 </td>
   <td style="text-align:right;"> -1.042449 </td>
   <td style="text-align:right;"> 0.2974956 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0832837 </td>
   <td style="text-align:right;"> 0.0758394 </td>
   <td style="text-align:right;"> 1.30619 </td>
   <td style="text-align:right;"> 11.18754 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> -1462.848 </td>
   <td style="text-align:right;"> 2943.696 </td>
   <td style="text-align:right;"> 2986.612 </td>
   <td style="text-align:right;"> 1470.687 </td>
   <td style="text-align:right;"> 862 </td>
  </tr>
</tbody>
</table><br/><code>Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + officer_rate_f + bonus_pay
Model 2: satisfaction_rank ~ 1 + officer_rate_f * bonus_pay
  Res.Df    RSS Df Sum of Sq      F  Pr(>F)
1    865 1488.7                            
2    862 1470.7  3    18.052 3.5268 0.01461
</code>

By Billet Current and Critical War
-----------------------------------
### satisfaction_rank

![](figure-png/by-billet_current-and-critical_war-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current + critical_war </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.8377622 </td>
   <td style="text-align:right;"> 0.1180247 </td>
   <td style="text-align:right;"> 32.5166107 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.2015313 </td>
   <td style="text-align:right;"> 0.1975770 </td>
   <td style="text-align:right;"> -1.0200137 </td>
   <td style="text-align:right;"> 0.3080071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.4370929 </td>
   <td style="text-align:right;"> 0.1425983 </td>
   <td style="text-align:right;"> -3.0652035 </td>
   <td style="text-align:right;"> 0.0022428 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.7312263 </td>
   <td style="text-align:right;"> 0.1359483 </td>
   <td style="text-align:right;"> -5.3787096 </td>
   <td style="text-align:right;"> 0.0000001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.3975988 </td>
   <td style="text-align:right;"> 0.2150434 </td>
   <td style="text-align:right;"> -6.4991486 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOther </td>
   <td style="text-align:right;"> 0.1509960 </td>
   <td style="text-align:right;"> 0.4418948 </td>
   <td style="text-align:right;"> 0.3417011 </td>
   <td style="text-align:right;"> 0.7326588 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> critical_warLow Deployer </td>
   <td style="text-align:right;"> 0.0112418 </td>
   <td style="text-align:right;"> 0.1235363 </td>
   <td style="text-align:right;"> 0.0910001 </td>
   <td style="text-align:right;"> 0.9275136 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0731976 </td>
   <td style="text-align:right;"> 0.0667689 </td>
   <td style="text-align:right;"> 1.313958 </td>
   <td style="text-align:right;"> 11.38609 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> -1471.894 </td>
   <td style="text-align:right;"> 2959.789 </td>
   <td style="text-align:right;"> 2997.955 </td>
   <td style="text-align:right;"> 1493.409 </td>
   <td style="text-align:right;"> 865 </td>
  </tr>
</tbody>
</table>

By Bonus_pay and Manning_proportion
-----------------------------------
### satisfaction_rank

![](figure-png/by-bonus_pay-and-manning_proportion-1.png)<!-- --><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + manning_proportion_cut3 + bonus_pay_cut3 </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.4680836 </td>
   <td style="text-align:right;"> 0.1647969 </td>
   <td style="text-align:right;"> 14.976514 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> manning_proportion_cut3Balanced </td>
   <td style="text-align:right;"> 0.3928698 </td>
   <td style="text-align:right;"> 0.1259855 </td>
   <td style="text-align:right;"> 3.118373 </td>
   <td style="text-align:right;"> 0.0018786 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> manning_proportion_cut3Over </td>
   <td style="text-align:right;"> 0.4651373 </td>
   <td style="text-align:right;"> 0.1209922 </td>
   <td style="text-align:right;"> 3.844358 </td>
   <td style="text-align:right;"> 0.0001297 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay_cut3$20-24k </td>
   <td style="text-align:right;"> 1.0172580 </td>
   <td style="text-align:right;"> 0.1493703 </td>
   <td style="text-align:right;"> 6.810311 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bonus_pay_cut3$24k+ </td>
   <td style="text-align:right;"> 0.8796862 </td>
   <td style="text-align:right;"> 0.1546106 </td>
   <td style="text-align:right;"> 5.689687 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0642006 </td>
   <td style="text-align:right;"> 0.0598832 </td>
   <td style="text-align:right;"> 1.318796 </td>
   <td style="text-align:right;"> 14.87015 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> -1476.106 </td>
   <td style="text-align:right;"> 2964.213 </td>
   <td style="text-align:right;"> 2992.838 </td>
   <td style="text-align:right;"> 1507.907 </td>
   <td style="text-align:right;"> 867 </td>
  </tr>
</tbody>
</table>No interaction between manning_proportion_cut3 & bonus_pay_cut3<br/><code>Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + manning_proportion_cut3 * bonus_pay_cut3
Model 2: satisfaction_rank ~ 1 + manning_proportion_cut3 + bonus_pay_cut3
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1    863 1499.7                           
2    867 1507.9 -4   -8.1779 1.1765 0.3197
</code><br/>Data:<code> ds </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current + critical_war </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 3.8377622 </td>
   <td style="text-align:right;"> 0.1180247 </td>
   <td style="text-align:right;"> 32.5166107 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.2015313 </td>
   <td style="text-align:right;"> 0.1975770 </td>
   <td style="text-align:right;"> -1.0200137 </td>
   <td style="text-align:right;"> 0.3080071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.4370929 </td>
   <td style="text-align:right;"> 0.1425983 </td>
   <td style="text-align:right;"> -3.0652035 </td>
   <td style="text-align:right;"> 0.0022428 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.7312263 </td>
   <td style="text-align:right;"> 0.1359483 </td>
   <td style="text-align:right;"> -5.3787096 </td>
   <td style="text-align:right;"> 0.0000001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.3975988 </td>
   <td style="text-align:right;"> 0.2150434 </td>
   <td style="text-align:right;"> -6.4991486 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOther </td>
   <td style="text-align:right;"> 0.1509960 </td>
   <td style="text-align:right;"> 0.4418948 </td>
   <td style="text-align:right;"> 0.3417011 </td>
   <td style="text-align:right;"> 0.7326588 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> critical_warLow Deployer </td>
   <td style="text-align:right;"> 0.0112418 </td>
   <td style="text-align:right;"> 0.1235363 </td>
   <td style="text-align:right;"> 0.0910001 </td>
   <td style="text-align:right;"> 0.9275136 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.0731976 </td>
   <td style="text-align:right;"> 0.0667689 </td>
   <td style="text-align:right;"> 1.313958 </td>
   <td style="text-align:right;"> 11.38609 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> -1471.894 </td>
   <td style="text-align:right;"> 2959.789 </td>
   <td style="text-align:right;"> 2997.955 </td>
   <td style="text-align:right;"> 1493.409 </td>
   <td style="text-align:right;"> 865 </td>
  </tr>
</tbody>
</table>

By Rank and Billet Type
-----------------------------------
### satisfaction_rank

**Conculsion**: `officer_rate` has a significant positive slope --sig predicting beyond `billet_current`.  But the billet levels have the same slope.<br/>Data:<code> ds_no_other_or_unknown </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current + officer_rate </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.3990535 </td>
   <td style="text-align:right;"> 0.2023713 </td>
   <td style="text-align:right;"> 11.854711 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.5251624 </td>
   <td style="text-align:right;"> 0.1972434 </td>
   <td style="text-align:right;"> -2.662510 </td>
   <td style="text-align:right;"> 0.0079021 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.4583431 </td>
   <td style="text-align:right;"> 0.1377637 </td>
   <td style="text-align:right;"> -3.327024 </td>
   <td style="text-align:right;"> 0.0009153 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.6710109 </td>
   <td style="text-align:right;"> 0.1320160 </td>
   <td style="text-align:right;"> -5.082800 </td>
   <td style="text-align:right;"> 0.0000005 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.3770516 </td>
   <td style="text-align:right;"> 0.2076934 </td>
   <td style="text-align:right;"> -6.630213 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate </td>
   <td style="text-align:right;"> 0.3440959 </td>
   <td style="text-align:right;"> 0.0462720 </td>
   <td style="text-align:right;"> 7.436374 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.1298574 </td>
   <td style="text-align:right;"> 0.1247569 </td>
   <td style="text-align:right;"> 1.26896 </td>
   <td style="text-align:right;"> 25.45982 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> -1420.469 </td>
   <td style="text-align:right;"> 2854.939 </td>
   <td style="text-align:right;"> 2888.229 </td>
   <td style="text-align:right;"> 1373.551 </td>
   <td style="text-align:right;"> 853 </td>
  </tr>
</tbody>
</table>Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current
Model 2: satisfaction_rank ~ 1 + billet_current + officer_rate
  Res.Df    RSS Df Sum of Sq    F    Pr(>F)
1    854 1462.6                            
2    853 1373.5  1    89.047 55.3 2.521e-13
Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current + officer_rate
Model 2: satisfaction_rank ~ 1 + billet_current * officer_rate
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1    853 1373.5                           
2    849 1365.3  4    8.2102 1.2763 0.2776
![](figure-png/by-billet-and-rate-1.png)<!-- -->

Models to Publish
===================================

3-predictor (and final) model
-----------------------------------
<br/>Data:<code> ds_no_other_or_unknown </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current + officer_rate + specialty_type </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.7449416 </td>
   <td style="text-align:right;"> 0.2216697 </td>
   <td style="text-align:right;"> 12.3830259 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.4449198 </td>
   <td style="text-align:right;"> 0.1985010 </td>
   <td style="text-align:right;"> -2.2413979 </td>
   <td style="text-align:right;"> 0.0252580 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.4035686 </td>
   <td style="text-align:right;"> 0.1380693 </td>
   <td style="text-align:right;"> -2.9229432 </td>
   <td style="text-align:right;"> 0.0035595 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.3935332 </td>
   <td style="text-align:right;"> 0.1549743 </td>
   <td style="text-align:right;"> -2.5393446 </td>
   <td style="text-align:right;"> 0.0112834 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.1452059 </td>
   <td style="text-align:right;"> 0.2149465 </td>
   <td style="text-align:right;"> -5.3278645 </td>
   <td style="text-align:right;"> 0.0000001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate </td>
   <td style="text-align:right;"> 0.2955084 </td>
   <td style="text-align:right;"> 0.0491857 </td>
   <td style="text-align:right;"> 6.0080167 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typesurgical </td>
   <td style="text-align:right;"> -0.2655425 </td>
   <td style="text-align:right;"> 0.1202900 </td>
   <td style="text-align:right;"> -2.2075190 </td>
   <td style="text-align:right;"> 0.0275446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typefamily </td>
   <td style="text-align:right;"> -0.4094283 </td>
   <td style="text-align:right;"> 0.1188588 </td>
   <td style="text-align:right;"> -3.4446620 </td>
   <td style="text-align:right;"> 0.0005998 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeoperational </td>
   <td style="text-align:right;"> -0.6634897 </td>
   <td style="text-align:right;"> 0.1855377 </td>
   <td style="text-align:right;"> -3.5760380 </td>
   <td style="text-align:right;"> 0.0003686 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeresident </td>
   <td style="text-align:right;"> -0.1987343 </td>
   <td style="text-align:right;"> 0.2359798 </td>
   <td style="text-align:right;"> -0.8421669 </td>
   <td style="text-align:right;"> 0.3999317 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.1506291 </td>
   <td style="text-align:right;"> 0.1416252 </td>
   <td style="text-align:right;"> 1.256672 </td>
   <td style="text-align:right;"> 16.72926 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> -1410.092 </td>
   <td style="text-align:right;"> 2842.184 </td>
   <td style="text-align:right;"> 2894.498 </td>
   <td style="text-align:right;"> 1340.762 </td>
   <td style="text-align:right;"> 849 </td>
  </tr>
</tbody>
</table>Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current + officer_rate
Model 2: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type
  Res.Df    RSS Df Sum of Sq      F    Pr(>F)
1    853 1373.5                              
2    849 1340.8  4    32.789 5.1907 0.0003911
![](figure-png/3-predictor-1.png)<!-- -->![](figure-png/3-predictor-2.png)<!-- -->![](figure-png/3-predictor-3.png)<!-- -->![](figure-png/3-predictor-4.png)<!-- -->

3-predictor model wieght sampling weights
-----------------------------------
<br/>Data:<code> ds_no_other_or_unknown </code><br/>Formula:<code> ~ satisfaction_rank 1 + billet_current + officer_rate + specialty_type </code><table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 2.5672108 </td>
   <td style="text-align:right;"> 0.2427369 </td>
   <td style="text-align:right;"> 10.5761050 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentNon-Operational/Clinical </td>
   <td style="text-align:right;"> -0.4852311 </td>
   <td style="text-align:right;"> 0.2196834 </td>
   <td style="text-align:right;"> -2.2087744 </td>
   <td style="text-align:right;"> 0.0274568 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS MTF </td>
   <td style="text-align:right;"> -0.2645507 </td>
   <td style="text-align:right;"> 0.1663384 </td>
   <td style="text-align:right;"> -1.5904370 </td>
   <td style="text-align:right;"> 0.1121086 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentCONUS Operational </td>
   <td style="text-align:right;"> -0.2267988 </td>
   <td style="text-align:right;"> 0.1489326 </td>
   <td style="text-align:right;"> -1.5228285 </td>
   <td style="text-align:right;"> 0.1281740 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> billet_currentOCONUS Operational </td>
   <td style="text-align:right;"> -1.0832312 </td>
   <td style="text-align:right;"> 0.2116975 </td>
   <td style="text-align:right;"> -5.1168828 </td>
   <td style="text-align:right;"> 0.0000004 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> officer_rate </td>
   <td style="text-align:right;"> 0.3307020 </td>
   <td style="text-align:right;"> 0.0525848 </td>
   <td style="text-align:right;"> 6.2889212 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typesurgical </td>
   <td style="text-align:right;"> -0.2780756 </td>
   <td style="text-align:right;"> 0.1284607 </td>
   <td style="text-align:right;"> -2.1646746 </td>
   <td style="text-align:right;"> 0.0306907 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typefamily </td>
   <td style="text-align:right;"> -0.4330843 </td>
   <td style="text-align:right;"> 0.1660709 </td>
   <td style="text-align:right;"> -2.6078272 </td>
   <td style="text-align:right;"> 0.0092719 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeoperational </td>
   <td style="text-align:right;"> -0.7198543 </td>
   <td style="text-align:right;"> 0.1616156 </td>
   <td style="text-align:right;"> -4.4541130 </td>
   <td style="text-align:right;"> 0.0000096 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> specialty_typeresident </td>
   <td style="text-align:right;"> -0.1449924 </td>
   <td style="text-align:right;"> 0.1527102 </td>
   <td style="text-align:right;"> -0.9494615 </td>
   <td style="text-align:right;"> 0.3426561 </td>
  </tr>
</tbody>
</table>

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
   <th style="text-align:right;"> sigma </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.1853017 </td>
   <td style="text-align:right;"> 0.1766653 </td>
   <td style="text-align:right;"> 2.545062 </td>
   <td style="text-align:right;"> 21.45595 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> -1528.984 </td>
   <td style="text-align:right;"> 3079.968 </td>
   <td style="text-align:right;"> 3132.282 </td>
   <td style="text-align:right;"> 5499.261 </td>
   <td style="text-align:right;"> 849 </td>
  </tr>
</tbody>
</table>


Billet Intercepts
-----------------------------------
![](figure-png/billet-intercept-1.png)<!-- -->

Specialty Intercepts
-----------------------------------
![](figure-png/specialty-intercept-1.png)<!-- -->


Nonsignificant Additions
-----------------------------------

```
The `officer_rate * specialty_type`  interaction doesn't sig improve the fit of the model
```

```
Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type
Model 2: satisfaction_rank ~ 1 + billet_current + officer_rate * specialty_type
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1    849 1340.8                           
2    845 1336.7  4    4.0491 0.6399 0.6341
```

```
`manning_proportion_cut3` doesn't sig improve the fit of the model
```

```
Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type
Model 2: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type + 
    manning_proportion_cut3
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1    849 1340.8                           
2    847 1339.9  2   0.88131 0.2786 0.7569
```

```
`bonus_pay_cut4` doesn't sig improve the fit of the model
```

```
Analysis of Variance Table

Model 1: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type
Model 2: satisfaction_rank ~ 1 + billet_current + officer_rate + specialty_type + 
    bonus_pay_cut4
  Res.Df    RSS Df Sum of Sq    F Pr(>F)
1    849 1340.8                         
2    846 1336.5  3    4.2181 0.89 0.4458
```


Session Information
============================================

For the sake of documentation and reproducibility, the current report was rendered in the following environment.  Click the line below to expand.

<details>
  <summary>Environment <span class="glyphicon glyphicon-plus-sign"></span></summary>

```
─ Session info ───────────────────────────────────────────────────────────────────────────────────
 setting  value                       
 version  R version 3.6.2 (2019-12-12)
 os       Ubuntu 19.10                
 system   x86_64, linux-gnu           
 ui       X11                         
 language (EN)                        
 collate  en_US.UTF-8                 
 ctype    en_US.UTF-8                 
 tz       America/Chicago             
 date     2020-01-24                  

─ Packages ───────────────────────────────────────────────────────────────────────────────────────
 package         * version     date       lib source                                  
 assertthat        0.2.1       2019-03-21 [1] CRAN (R 3.6.1)                          
 backports         1.1.5       2019-10-02 [1] CRAN (R 3.6.1)                          
 broom             0.5.3       2019-12-14 [1] CRAN (R 3.6.1)                          
 callr             3.4.0       2019-12-09 [1] CRAN (R 3.6.1)                          
 cli               2.0.1       2020-01-08 [1] CRAN (R 3.6.1)                          
 colorspace        1.4-1       2019-03-18 [1] CRAN (R 3.6.1)                          
 corrplot          0.84        2017-10-16 [1] CRAN (R 3.6.1)                          
 crayon            1.3.4       2017-09-16 [1] CRAN (R 3.6.1)                          
 DBI               1.1.0       2019-12-15 [1] CRAN (R 3.6.1)                          
 desc              1.2.0       2018-05-01 [1] CRAN (R 3.6.1)                          
 devtools          2.2.1       2019-09-24 [1] CRAN (R 3.6.1)                          
 digest            0.6.23      2019-11-23 [1] CRAN (R 3.6.1)                          
 dplyr             0.8.3       2019-07-04 [1] CRAN (R 3.6.1)                          
 ellipsis          0.3.0       2019-09-20 [1] CRAN (R 3.6.1)                          
 evaluate          0.14        2019-05-28 [1] CRAN (R 3.6.1)                          
 fansi             0.4.1       2020-01-08 [1] CRAN (R 3.6.1)                          
 farver            2.0.3       2020-01-16 [1] CRAN (R 3.6.1)                          
 fs                1.3.1       2019-05-06 [1] CRAN (R 3.6.1)                          
 generics          0.0.2       2018-11-29 [1] CRAN (R 3.6.1)                          
 ggplot2         * 3.2.1       2019-08-10 [1] CRAN (R 3.6.1)                          
 glue              1.3.1       2019-03-12 [1] CRAN (R 3.6.1)                          
 gtable            0.3.0       2019-03-25 [1] CRAN (R 3.6.1)                          
 highr             0.8         2019-03-20 [1] CRAN (R 3.6.1)                          
 hms               0.5.3       2020-01-08 [1] CRAN (R 3.6.1)                          
 htmltools         0.4.0       2019-10-04 [1] CRAN (R 3.6.1)                          
 httr              1.4.1       2019-08-05 [1] CRAN (R 3.6.1)                          
 kableExtra        1.1.0       2019-03-16 [1] CRAN (R 3.6.1)                          
 knitr           * 1.27        2020-01-16 [1] CRAN (R 3.6.1)                          
 labeling          0.3         2014-08-23 [1] CRAN (R 3.6.1)                          
 lattice           0.20-38     2018-11-04 [1] CRAN (R 3.6.1)                          
 lazyeval          0.2.2       2019-03-15 [1] CRAN (R 3.6.1)                          
 lifecycle         0.1.0       2019-08-01 [1] CRAN (R 3.6.1)                          
 magrittr        * 1.5         2014-11-22 [1] CRAN (R 3.6.1)                          
 Matrix          * 1.2-18      2019-11-27 [4] CRAN (R 3.6.1)                          
 memoise           1.1.0       2017-04-21 [1] CRAN (R 3.6.1)                          
 mitools           2.4         2019-04-26 [1] CRAN (R 3.6.1)                          
 munsell           0.5.0       2018-06-12 [1] CRAN (R 3.6.1)                          
 nlme              3.1-143     2019-12-10 [1] CRAN (R 3.6.1)                          
 pillar            1.4.3       2019-12-20 [1] CRAN (R 3.6.1)                          
 pkgbuild          1.0.6       2019-10-09 [1] CRAN (R 3.6.1)                          
 pkgconfig         2.0.3       2019-09-22 [1] CRAN (R 3.6.1)                          
 pkgload           1.0.2       2018-10-29 [1] CRAN (R 3.6.1)                          
 prettyunits       1.1.0       2020-01-09 [1] CRAN (R 3.6.1)                          
 processx          3.4.1       2019-07-18 [1] CRAN (R 3.6.1)                          
 ps                1.3.0       2018-12-21 [1] CRAN (R 3.6.1)                          
 purrr             0.3.3       2019-10-18 [1] CRAN (R 3.6.1)                          
 R6                2.4.1       2019-11-12 [1] CRAN (R 3.6.1)                          
 Rcpp              1.0.3       2019-11-08 [1] CRAN (R 3.6.1)                          
 readr             1.3.1       2018-12-21 [1] CRAN (R 3.6.1)                          
 remotes           2.1.0       2019-06-24 [1] CRAN (R 3.6.1)                          
 rlang             0.4.2       2019-11-23 [1] CRAN (R 3.6.1)                          
 rmarkdown         2.1         2020-01-20 [1] CRAN (R 3.6.2)                          
 rprojroot         1.3-2       2018-01-03 [1] CRAN (R 3.6.1)                          
 rstudioapi        0.10        2019-03-19 [1] CRAN (R 3.6.1)                          
 rvest             0.3.5       2019-11-08 [1] CRAN (R 3.6.1)                          
 scales            1.1.0       2019-11-18 [1] CRAN (R 3.6.1)                          
 sessioninfo       1.1.1       2018-11-05 [1] CRAN (R 3.6.1)                          
 stringi           1.4.5       2020-01-11 [1] CRAN (R 3.6.1)                          
 stringr           1.4.0       2019-02-10 [1] CRAN (R 3.6.1)                          
 survey          * 3.37        2020-01-21 [1] CRAN (R 3.6.2)                          
 survival        * 3.1-8       2019-12-03 [1] CRAN (R 3.6.1)                          
 TabularManifest   0.1-16.9003 2019-11-16 [1] Github (Melinae/TabularManifest@4cbc21c)
 testthat          2.3.1       2019-12-01 [1] CRAN (R 3.6.1)                          
 tibble            2.1.3       2019-06-06 [1] CRAN (R 3.6.1)                          
 tidyr             1.0.0       2019-09-11 [1] CRAN (R 3.6.1)                          
 tidyselect        0.2.5       2018-10-11 [1] CRAN (R 3.6.1)                          
 usethis           1.5.1       2019-07-04 [1] CRAN (R 3.6.1)                          
 utf8              1.1.4       2018-05-24 [1] CRAN (R 3.6.1)                          
 vctrs             0.2.1       2019-12-17 [1] CRAN (R 3.6.1)                          
 viridisLite       0.3.0       2018-02-01 [1] CRAN (R 3.6.1)                          
 webshot           0.5.2       2019-11-22 [1] CRAN (R 3.6.1)                          
 withr             2.1.2       2018-03-15 [1] CRAN (R 3.6.1)                          
 xfun              0.12        2020-01-13 [1] CRAN (R 3.6.1)                          
 xml2              1.2.2       2019-08-09 [1] CRAN (R 3.6.1)                          
 yaml              2.2.0       2018-07-25 [1] CRAN (R 3.6.1)                          
 zeallot           0.1.0       2018-01-28 [1] CRAN (R 3.6.1)                          

[1] /home/wibeasley/R/x86_64-pc-linux-gnu-library/3.6
[2] /usr/local/lib/R/site-library
[3] /usr/lib/R/site-library
[4] /usr/lib/R/library
```
</details>



Report rendered by wibeasley at 2020-01-24, 17:54 -0600 in 36 seconds.
