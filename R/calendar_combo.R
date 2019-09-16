

#' Check if Combinaison Events
#'
#' @param calendar string(s) of calendar, months in original order (i.e. recent -> older)
#' @param event1 code(s) of the first event(s) (older)
#' @param n_months number of months between events (numerical)
#' @param event2 code(s) of the second event(s) (recent)
#'
#' @return wheter or not each calendar items contain the combination of events
#' @export
#'
#' @examples
#' dat_calendar <- c("333000BPPP", "000000BPPP")
#' calendar_combo(calendar = dat_calendar, event1 = "B", n_months = 6, event2 = c(1:9))
calendar_combo <- function(calendar, event1, n_months, event2){
    #Check validity of inputs
    if( !(is.character(calendar) | is.factor(calendar)) ){
        stop("Calendar object should contain characters or factors.")
    }
    if(n_months < 1 | !is.numeric(n_months) |
       n_months%%1 != 0 | length(n_months) != 1) {
        stop("n_months should be a single/positive/whole number.")
    }
    if( !(is.vector(event1) & is.vector(event2)) ){
        stop("Events should be vectors")
    }

    #Create pattern Regex
    patt <- paste0(
        "[", paste(event2, collapse = "|"), "]",
        ".{0,", as.character(n_months-1), "}",
        "[", paste(event1, collapse = "|"), "]"
    )

    #Check if pattern in calendar
    return(grepl(patt, calendar))
}

