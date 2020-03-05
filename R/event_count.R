
#' Count number of occurences of the event
#'
#' @param calendar string(s) of DHS calendar, months in original order (i.e. recent -> older)
#' @param event code(s) of event of interest (can take regex)
#' @param sequences look for sequence of event - if FALSE individual events [default: TRUE]
#'
#' @return
#' @export
#'
#' @importFrom stringr str_count
#'
#' @examples
#' dat_calendar <- c("333000BPPP", "333000TPPP000", "012305670")
#' event_count(dat_calendar, 0)
#' event_count(dat_calendar, "0", sequences = FALSE)
event_count <- function(calendar,
                        event,
                        sequences = TRUE
){
    # Check input
    if(!is.logical(sequences)){
        stop("Wrong value for argument sequences (TRUE/FALSE)")
    }
    if(is.numeric(event)){
        event <- as.character(event)
    }
    if(!is.character(event)){
        stop("event must be numeric or character")
    }
    # Edit event input
    event <- ifelse(sequences,
                    paste0(event, "+"),
                    event)
    # Output count
    return(
        str_count(trimws(calendar),
                  event))
}
