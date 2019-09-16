
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DHScalendR

<!-- badges: start -->

<!-- badges: end -->

The goal of DHScalendR is to make the use of the DHS calendar easier to
use in R. **This package is currently being developped**, but it already
contains functions to:

  - Deal with CMC date format (back and forth)
  - Split Calendar into months columns
  - Recoding of the calendar
  - Subset using dates (CMC)
  - Check for combination of events (e.g. postpartum FP use = Birth & )

Next additions will include ways to:

  - Locate events
  - *NB. Also need better documentation and further tests.*
  - *NB. The type of input will also evolve by version
0.3.0*

## Installation

<!-- You can install the released version of DHScalendR from [CRAN](https://CRAN.R-project.org) with: -->

To install the current version of this package:

``` r
devtools::install_github("trottieralex/DHScalendR")
```

## Data

This package contains a small exemple dataset extracted from a DHS model
dataset, and also a codebook to recode the calendar. The later is
primarily to use with the calendar\_recode function, but is available
for consultation or use.

``` r
# Exemple dataset
data <- dhs_extract
head(data)
?dhs_extract

# Calendar codebook
head(dhs_calendar_codebook)
```

## Transform CMC date format

The DHS widely use CMC format date (number of month counting from
January 1900). A format often convenient for analysis, but hardly
interpretable. These function make the transfer CMC from/to Date and
years as decimal straigthforward.

``` r
library(DHScalendR)

# The Date of the Teharan declaration:
cmc_to_Date(761)
#> [1] "1963-05-01"
cmc_from_Date(as.Date("1963-05-13")) #Show warning the 1st time
#> Note: method with signature 'Timespan#Timespan' chosen for function '%/%',
#>  target signature 'Interval#Period'.
#>  "Interval#ANY", "ANY#Period" would also be valid
#> [1] 761

# or for April 19, 1989
cmc_to_Year(1072)
#> [1] 1989.25
cmc_from_Year(1989.296)
#> [1] 1072
```

## Split and recode DHS calendar

The split function divides the DHS calendar from a data frame into month
columns that are added to the said data frame under the name: “CMCx” +
\[CMC date of the month\]. Once split, the recode function coud be use
to obtain more meaning full labels or classification.

``` r
dataset <- dhs_extract[95:100, c("V008", "V025", "VCAL.1")]

#Dividing months into columns
dataset <- calendar_split(dataset, "V008", "VCAL.1")
(dataset <- dataset[ ,1:10])
#>   V008  V025
#> 3 1387 Rural
#> 2 1387 Rural
#> 5 1387 Urban
#> 6 1388 Rural
#> 1 1387 Rural
#> 4 1387 Rural
#>                                                                             VCAL.1
#> 3              0000000000000000000000000000BPPPPPPPP0000000000000000000BPPPPPPPP00
#> 2              0000000000000000000000000000000000000000000000000000000000000BPPPPP
#> 5              PP00000000000000000000000000000000000000000000000000000000000000000
#> 6             00000000000000BPPPPPPPP000000000000000000000000000000000000000BPPPPP
#> 1              0000000000000000000000000000000000000000000000000000000000000000000
#> 4              000000000000000000000BPPPPPPPP0000000000000000000000000000000BPPPPP
#>   CMCx1321 CMCx1322 CMCx1323 CMCx1324 CMCx1325 CMCx1326 CMCx1327
#> 3        0        0        P        P        P        P        P
#> 2        P        P        P        P        P        B        0
#> 5        0        0        0        0        0        0        0
#> 6        P        P        P        P        P        B        0
#> 1        0        0        0        0        0        0        0
#> 4        P        P        P        P        P        B        0

#Recoding of calendar months
calendar_recode(dataset$CMCx1326)
#> [1] "Pregnancy" "Birth"     "Non-use"   "Birth"     "Non-use"   "Birth"
calendar_recode(c("1","0","P","P","P","T","A","A","A","A","3","3","3"), 
                recoding = "modern_DHS6")
#>  [1] "Modern"      "None"        "Pregnant"    "Pregnant"    "Pregnant"   
#>  [6] "Pregnant"    "Traditional" "Traditional" "Traditional" "Traditional"
#> [11] "Modern"      "Modern"      "Modern"
```

## Subset by dates

A simple way to subset the DHS calendar for a predefined period of time.

``` r

dataset <- DHScalendR::dhs_extract[5:9, ]

# Request first half of 2014
calendar_subset(calendar = dataset$VCAL.1, 
                interview = dataset$V008, 
                starting = 1381, 
                ending = cmc_from_Date(as.Date("2015-06-30")))
#> [1] "PPPPPP" "NNNNNN" "111111" "000000" "PPP000"
```

## Check for combination of events

Look for any event2 that hapenned X months or less after any event1.

``` r

example <- c("333000TPPP", "000000BPPP", "0000LLLBPPP")
fp <- dhs_calendar_codebook$Recode[dhs_calendar_codebook$modern_DHS6 == "Modern"]

# Check if use any modern FP in the 6 months after end pregnancy
calendar_combo(calendar = example, 
               event1 = c("B", "T"), 
               n_months = 6,
               event2 = fp) 
#> [1]  TRUE FALSE  TRUE
```
