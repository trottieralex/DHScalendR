
#' Get location event in a calendar variable
#'
#' @param calendar string(s) of DHS calendar, months in original order (i.e. recent -> older)
#' @param event code(s) of event of interest (can take regex)
#' @param sequences look for sequence of event - if FALSE individual events
#' @param recent_oldest return location most recent or the oldest event in the calendar
#' @param start_end return location of the start or the end of the event
#' @param interview variable of the date of interview
#'
#' @return
#' @export
#'
#' @examples
event_locate <- function(calendar,
                         event,
                         sequences = TRUE,
                         recent_oldest = "recent",
                         start_end = "start",
                         interview = 0
                         ){

    #Check for correct inputs
    if(length(recent_oldest) != 1 | length(start_end) != 1){
        stop("recent_oldest and start_end
             parameters must be of length one")
    }

    if(!recent_oldest %in% c("recent", "oldest")){
        stop("recent_oldest must be either 'recent' or 'oldest'")
    }
    if(!start_end %in% c("start", "end")){
        stop("start_end must be either 'start' or 'end'")
    }

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
            lapply(strsplit(dd, NULL), rev), paste, collapse="")
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

