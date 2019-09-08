
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DHScalendR

<!-- badges: start -->

<!-- badges: end -->

The goal of DHScalendR is to make the use of the DHS calendar easier to
use in R. **This package is currently being developped**, but it already
contains functions to:

  - Deal with CMC date format (back and forth)

Next additions will include ways to:

  - Decomposition of the calendar string to months
  - Recoding of the calendar
  - Measure of specified events (i.e. contraceptive failure or
    post-partum
adoption)

## Installation

<!-- You can install the released version of DHScalendR from [CRAN](https://CRAN.R-project.org) with: -->

``` r
library(DHScalendR)
# devtools::install_github("")
```

## Transform CMC date format

The DHS widely use CMC format date (number of month counting from
January 1900). A format often convenient for analysis, but hardly
interpretable. These function make the transfer CMC from/to Date and
years as decimal straigthforward.

``` r

# The Date of the Teharan declaration:
cmc_to_Date(761) #1963-05-01
#> [1] "1963-05-01"
cmc_from_Date(as.Date("1963-05-13")) #761
#> Note: method with signature 'Timespan#Timespan' chosen for function '%/%',
#>  target signature 'Interval#Period'.
#>  "Interval#ANY", "ANY#Period" would also be valid
#> [1] 761

# or for April 19, 1989
cmc_to_Year(1072) #1989.25
#> [1] 1989.25
cmc_from_Year(1989.296) #1072
#> [1] 1072
```
