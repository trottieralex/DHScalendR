
#' Subset Months from DHS Calendar
#'
#' @param calendar string(s) of calendar, months in original order (i.e. recent -> older)
#' @param interview date of interview (CMC format, numeric)
#' @param starting date of first month of interest (CMC format, numeric)
#' @param ending date of last month of interest (CMC format, numeric)
#'
#' @return a vector containing the strings of months of interest
#' @export
#'
#' @examples
#' df <- DHScalendR::dhs_extract[5:9, ]
#' calendar_subset(calendar = df$VCAL.1, interview = df$V008, starting = 1379, ending = 1385)
calendar_subset <- function(calendar, interview, starting, ending){

    # Check if arguments valid
    if(!is.character(calendar)){
        stop("calendar should be a character object")
    }
    if(!is.numeric(interview) |
       !is.numeric(starting) | (starting%%1 != 0) |
       !is.numeric(ending) | (ending%%1 != 0)){
        stop("interview, starting and ending supposed to be numerical (CMC months, whole numbers)")
    }
    if((ending-starting) < 1){
        stop("Ending is before starting")
    }


    # Remove the usual leading spaces
    calendar <- trimws(calendar)

    # Translate start/end to position in string
    starting <- ifelse((interview - starting) < 0,
                       1,
                       (interview - starting) + 1)
    ending <- ifelse((interview - ending) < 0,
                     1,
                     (interview - ending) + 1)

    # Subset requested sequence
    output <- substring(calendar, ending, starting)

    # Check for incomplete output
    if( (length(unique(nchar(output))) != 1) |
        (any(nchar(output) == 0)) |
        (any(starting > nchar(calendar))) ){
        warning("Part requested sequence missing for some calendar elements")
    }

    # Return the result
    return(output)
}
