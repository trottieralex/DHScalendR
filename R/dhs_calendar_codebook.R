#' @title Extract from DHS model dataset
#'
#' @description Contains the meaning of the code used in the DHS calendar. Also includes two alternative classification of methods/events as either modern, traditional, pregnant or none.
#'
#' @source The codes and their meaning comes from the calendar tutorial provided by the DHS program:
#' \url{https://www.dhsprogram.com/data/calendar-tutorial/#references}
#' The alternative recoding as modern/traditional/pregnant/none are based on the "Guide to DHS statistics:
#' \url{https://dhsprogram.com/pubs/pdf/DHSG1/Guide_to_DHS_Statistics_DHS-7.pdf}
#'
#' @docType data
#'
#' @usage data(dhs_calendar_codebook)
#'
#' @format A data frame with following variables (as characters):
#' \describe{
#'  \item{Recode}{Codes used for contraception/events in the DHS calendar}
#'  \item{Meaning}{Signification of the codes}
#'  \item{modern_DHS3}{Classification as modern/traditional according to DHS3 (LAM and SDM as traditional)}
#'  \item{modern_DHS6}{Classification as modern/traditional according to DHS3 (LAM and SDM as modern)}
#' }
#'
"dhs_calendar_codebook"
