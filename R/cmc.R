

#' Transform CMC Format to Date Format
#'
#' @param x is a numerical CMC date format
#'
#' @return date as a Date format
#' @export
#'
#' @import lubridate
#' @import Rcpp
#'
#' @examples
#' cmc_to_Date(761) #1963-05-01
#'
cmc_to_Date <- function(x){
    ymd("1899-12-01") %m+% months(x)
}


#' Transform Date to CMC Format
#'
#' @param x is a date format object
#'
#' @return date in CMC format
#' @export
#'
#' @examples
#' cmc_from_Date(as.Date("1963-05-13")) #761
#'
cmc_from_Date <- function(x){
    return(12 * (as.numeric(strftime(x, "%Y")) - 1900) +
               as.numeric(strftime(x, "%m"))
           )
}


#' Transform CMC Format to Years
#'
#' @param x is a numerical CMC date format
#'
#' @return a year with decimal
#' @export
#'
#' @examples
#' cmc_to_Year(1072) #1989.25
#'
cmc_to_Year <- function(x){
    (x / 12) + (1900 - 1/12)
}


#' Transform Years to CMC Format
#'
#' @param x is a year with decimal
#'
#' @return date in a CMC format
#' @export
#'
#' @examples
#' #Will run warning the first time
#' cmc_from_Year(1989.296) #1072
#'
cmc_from_Year <- function(x){
    cmc_from_Date(date_decimal(x))
}


