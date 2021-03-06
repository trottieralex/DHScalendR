% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/event_count.R
\name{event_count}
\alias{event_count}
\title{Count number of occurences of the event}
\usage{
event_count(calendar, event, sequences = TRUE)
}
\arguments{
\item{calendar}{string(s) of DHS calendar, months in original order (i.e. recent -> older)}

\item{event}{code(s) of event of interest (can take regex)}

\item{sequences}{look for sequence of event - if FALSE individual events [default: TRUE]}
}
\value{
number of time the event occured in the calendar string
}
\description{
Count number of occurences of the event
}
\examples{
dat_calendar <- c("3300000BPP", "5000TPP111", "0123005670")
event_count(dat_calendar, 0)
event_count(dat_calendar, "0", sequences = FALSE)
}
