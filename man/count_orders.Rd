% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count_functions.R
\name{count_orders}
\alias{count_orders}
\title{Counts the number of orders from a data.table of message counts}
\usage{
count_orders(x)
}
\arguments{
\item{x}{a file or a data.frame containing the message types and the counts}
}
\value{
a numeric value of number of orders in x
}
\description{
Counts the number of orders from a data.table of message counts
}
\examples{
\dontrun{
  raw_file <- "20170130.PSX_ITCH_50"

  msg_count <- count_messages(raw_file)

  count_orders(msg_count)
}
}
\seealso{
\code{\link{count_messages}}
}
