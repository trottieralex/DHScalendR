
#' Check if Combination of Events in calendar
#'
#' @param calendar string(s) of DHS calendar, months in original order (i.e. recent -> older)
#' @param event1 code(s) of the earlier/older event(s) of interest
#' @param n_months number of months between events (numerical)
#' @param event2 code(s) of the later/recent event(s) of interest
#'
#' @return wheter or not each calendar items contain the combination of events
#' @export
#'
#' @examples
#' dat_calendar <- c("3300000BPP", "5000TPP111", "0123005670")
#' event_combo(calendar = dat_calendar, event1 = "P", n_months = 6, event2 = c(1:9))
#' event_combo(calendar = dat_calendar, event1 = "P", n_months = 4, event2 = c(1:9))
event_combo <- function(calendar, event1, n_months, event2){
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




#' Extract combination of events (pattern or part of it)
#'
#' @param calendar string(s) of calendar, months in original order (i.e. recent -> older)
#' @param event1 code(s) of the earlier/older event(s) of interest
#' @param n_months number of months between events (numerical)
#' @param event2 code(s) of the later/recent event(s) of interest
#' @param output chose if return "event1", "event2" or the whole "pattern" detected [default: "pattern"]
#'
#' @importFrom stringr str_extract
#'
#' @return the combination/pattern of interest
#' @export
#'
#' @examples
#' dat_calendar <- c("3300000BPP", "5000TPP111", "0123005670")
#' event_combo_extract(calendar = dat_calendar,
#' event1 = c("B", "T"), n_months = 6, event2 = c(1:9))
#' event_combo_extract(calendar = dat_calendar,
#' event1 = c("B", "T"), n_months = 6, event2 = c(1:9),
#' output = "event2")
event_combo_extract <- function(calendar,
                                   event1, n_months, event2,
                                   output = "pattern"){
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
        #One of event2
        "[", paste(event2, collapse = "|"), "]{1}",
        #X months of neither event1 or event2
            "[^", paste(c(event1, event2), collapse = "|"), "]",
            "{0,", as.character(n_months-1), "}",
        #One of event1
        "[", paste(event1, collapse = "|"), "]"
    )

    #Extract output
    pattern <- str_extract(calendar, patt)
    if(output == "pattern"){
        return(pattern)
    }
    if(output == "event1"){
        return(substr(pattern, nchar(pattern), nchar(pattern)))
    }
    if(output == "event2"){
        return(substr(pattern, 1, 1))
    }
}

