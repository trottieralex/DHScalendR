

#' Split Calendar Into Individual Months
#'
#' @param dhs dataframe containing the following variables
#' @param interview name as string of the "Date of interview (CMC)" variable
#' @param calendar name as string of the "Calendar" variable
#'
#' @importFrom reshape2 colsplit
#'
#' @return same dataframe + calendar divided with one column "CMCx" per month
#' @export
#'
#' @examples
#' dataset <- dhs_extract[95:100, c("V008", "V025", "VCAL.1")]
#' dataset_plus_CMCx <- calendar_split(dataset, "V008", "VCAL.1")
#' dataset_plus_CMCx[ ,1:10]
calendar_split <- function(dhs,
                           interview = "V008",
                           calendar = "VCAL.1"){

    # Check if arguments valid
    if(!(is.character(interview) & is.character(calendar))){
        stop("Both interview and calendar arguments must be names of variables as characters")
    }

    if(!(is.data.frame(dhs))){
        stop("dhs argument must be a data frame")
    }

    #Keep info to keep order of original dataset
    columnNames <- names(dhs)
    dhs$key <- 1:nrow(dhs)

    #Prepare the data
    dhs$cal <- trimws(dhs[,calendar], which = "both")
    dd2 <- data.frame(NA)

    #Split the calendar into CMCx columns
    for(iii in unique(dhs[[interview]])){
        dd <- dhs[which(dhs[[interview]] == iii),]

        dd <- cbind.data.frame(
            dd[,which(names(dd)!="cal")],
            colsplit(dd$cal,
                     "",
                     paste0("CMCx", iii:(iii-120)))
        )
        dd2 <- merge(dd, dd2, all = TRUE)
    }

    #Re-order data.frame as the original
    dd2 <- dd2[order(dd2$key),]
    newColumns <- sort(names(dd2)[!apply(is.na(dd2), 2, all)])
    newColumns <- newColumns[startsWith(newColumns, "CMCx")]

    return(dd2[c(columnNames, newColumns)])
}
