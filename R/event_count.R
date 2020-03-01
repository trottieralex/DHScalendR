
#' Count number of occurences of the event
#'
#' @param calendar string(s) of DHS calendar, months in original order (i.e. recent -> older)
#' @param event code(s) of event of interest (can take regex)
#' @param sequences look for sequence of event - if FALSE individual events
#'
#' @return
#' @export
#'
#' @importFrom stringr str_count
#'
#' @examples
event_count <- function(calendar,
                        event,
                        sequences = TRUE
){
    # Check and edit event
    if(!is.logical(sequences)){
        stop("Wrong value for argument lookingfor")
    }
    event <- ifelse(sequences,
                    paste0(event, "+"),
                    event)

    return(
        str_count(trimws(calendar),
                  event))
}
