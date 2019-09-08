#' @title Extract from DHS model dataset
#'
#' @description Contains 100 random rows for variables of interest
#' including the main calendar. Comes from SPSS file, variable names
#' format differs in other file types(e.g. lowercase, underscore, etc.).
#'
#' @source The DHS program from model dataset zzir62fl.sav.
#' \url{https://dhsprogram.com/data/download-model-datasets.cfm}
#'
#' @docType data
#'
#' @usage data(dhs_extract)
#'
#' @format A data frame with following variables (as characters/numerical):
#' \describe{
#'  \item{V005}{Sample weight.}
#'  \item{V008}{Date of interview (CMC).}
#'  \item{V011}{Date of birth (CMC).}
#'  \item{V017}{CMC start of calendar/health.}
#'  \item{V025}{Type of place of residence.}
#'  \item{V211}{Date of first birth (CMC).}
#'  \item{V223}{Completeness of information.}
#'  \item{V501}{Current marital status.}
#'  \item{V509}{Date of first marriage (CMC).}
#'  \item{VCAL.1}{THE CALENDAR.}
#' }
#'
"dhs_extract"
