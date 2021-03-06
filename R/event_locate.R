
#' Get location event in a calendar variable
#'
#' @param calendar string(s) of DHS calendar, months in original order (i.e. recent -> older)
#' @param event code(s) of event of interest (can take regex)
#' @param sequences look for sequence of event - if FALSE individual events [default: TRUE]
#' @param recent_oldest return location most recent or the oldest event in the calendar [default: "recent"]
#' @param start_end return location of the start or the end of the event [default: "start"]
#' @param interview variable of the date of interview [default: 0]
#'
#' @return location of the event in the string (most recent or oldest occurence)
#'
#' @importFrom stringr str_locate
#'
#' @export
#'
#' @examples
#' dat_calendar <- c("3300000BPP", "5000TPP111", "0123005670")
#' event_locate(dat_calendar, "P")
#' event_locate(dat_calendar, "P", sequences = FALSE)
#' event_locate(dat_calendar, 0)
#' event_locate(dat_calendar, 0, recent_oldest = "oldest")
#' event_locate(dat_calendar, 0, recent_oldest = "oldest", start_end = "end")
#' event_locate(dat_calendar, 0, interview = c(0, 10, 100))
event_locate <- function(calendar,
                         event,
                         sequences = TRUE,
                         recent_oldest = "recent",
                         start_end = "start",
                         interview = 0
                         ){
    #Check for correct inputs
    if(!is.logical(sequences)){
        stop("Wrong value for argument sequences (TRUE/FALSE)")
    }
    if(!recent_oldest %in% c("recent", "oldest")){
        stop("recent_oldest must be either 'recent' or 'oldest'")
    }
    if(!start_end %in% c("start", "end")){
        stop("start_end must be either 'start' or 'end'")
    }
    # Edit event input
    event <- ifelse(sequences,
                    paste0(event, "+"),
                    event)
    #Prepare data and get index of event
    if(recent_oldest == "recent"){
        #Prepare calendar
        calendar <- trimws(calendar)
        start_end <- ifelse(start_end == "start",2,1)
        #Get Index
        output <- str_locate(calendar, event)[ ,start_end]
    }
    if(recent_oldest == "oldest"){
        calendar <- trimws(sapply(
            lapply(strsplit(calendar, NULL), rev), paste, collapse="")
            )
        start_end <- ifelse(start_end == "start",1,2)
        output <- str_locate(calendar, event)[ ,start_end]
        output <- nchar(calendar) + 1 - output
    }
    #Transform index into month
    output <- interview - output
    #Return value
    return(output)
}

