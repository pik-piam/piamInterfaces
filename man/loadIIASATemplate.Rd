% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadIIASATemplate.R
\name{loadIIASATemplate}
\alias{loadIIASATemplate}
\title{Loads IIASA template (xlsx or yaml)}
\usage{
loadIIASATemplate(iiasatemplate)
}
\arguments{
\item{iiasatemplate}{filename of xlsx or yaml file provided by IIASA}
}
\description{
Loads IIASA template (xlsx or yaml)
}
\examples{
\dontrun{
# Simple use. Generates submission file in output folder:
loadIIASATemplate(
  iiasatemplate <- "template.xlsx"
)
}
}
\author{
Oliver Richters
}
