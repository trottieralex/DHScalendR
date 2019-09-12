
#' Recode Data - DHS Calendar
#'
#' @param x is a vector of encoded data
#' @param recodebook is a data frame containings information about code
#' @param code name column of recodebook with the code of x (character)
#' @param recoding name column of recodebook with meaning of the code (character)
#'
#' @return
#' @export
#'
#' @examples
#' events <- c("0","0","P","P","P","T","A","A","A","A","3","3","3")
#' calendar_recode(events)
#'
calendar_recode <- function(x,
                            recodebook = dhs_calendar_codebook,
                            code = "Recode",
                            recoding = "Meaning"){

    #Check validity of recodebook
    if(!is.data.frame(recodebook)){
        stop("recodebook must be a data frame")
    }
    if(!all(c(code, recoding) %in% names(recodebook),
            is.character(code),
            is.character(recoding))){
        stop("code and recoding must be names of recodebook columns (characters)")
    }

    #Make sure recoding are characters... +simplify loop
    code <- as.character(recodebook[, code])
    recoding <- as.character(recodebook[, recoding])

    x <- ifelse(x %in% code,
                recoding[match(x, code)],
                "Missing")

    return(x)
}
