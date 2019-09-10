
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DHScalendR

<!-- badges: start -->

<!-- badges: end -->

The goal of DHScalendR is to make the use of the DHS calendar easier to
use in R. **This package is currently being developped**, but it already
contains functions to:

  - Deal with CMC date format (back and forth)
  - Split Calendar into months columns

Next additions will include ways to:

  - Recoding of the calendar
  - Measure of specified events (i.e. contraceptive failure or
    post-partum
adoption)

## Installation

<!-- You can install the released version of DHScalendR from [CRAN](https://CRAN.R-project.org) with: -->

To install the current version of this package:

``` r
devtools::install_github("trottieralex/DHScalendR")
```

## Data

This package contains a small exemple dataset extracted from a DHS model
dataset.

``` r
data <- dhs_extract
head(data)
?dhs_extract
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
cmc_from_Date(as.Date("1963-05-13")) #Show following warning the 1st time
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

## Split DHS calendar

This function divides the DHS calendar from a data frame into month
columns that are added to the said data frame under the name: “CMCx” +
\[CMC date of the month\]

``` r
dataset <- dhs_extract[95:100, c("V008", "V025", "VCAL.1")]

dataset_plus_CMCx <- calendar_split(dataset, "V008", "VCAL.1")

dataset_plus_CMCx[ ,1:10]
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
```
