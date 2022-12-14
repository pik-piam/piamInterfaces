% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateMappingfile.R
\name{generateMappingfile}
\alias{generateMappingfile}
\title{Generate mapping from the template containing all the metadata}
\usage{
generateMappingfile(
  templates = NULL,
  outputDirectory = "output",
  fileName = NULL,
  logFile = NULL,
  iiasatemplate = NULL,
  targetVar = "variable",
  targetUnit = "unit",
  remindVar = "piam_variable",
  remindUnit = "piam_unit",
  factorCol = "piam_factor",
  weightCol = NULL,
  spatialCol = "spatial",
  model = "REMIND-MAgPIE"
)
}
\arguments{
\item{templates}{either a character or vector of project templates to use as a starting point for
creating the mapping, valid projects are "AR6", "SHAPE", "NAVIGATE"}

\item{outputDirectory}{path to directory to place generated files (default: output)}

\item{fileName}{name of the mapping file to be created, if provided, the file is created in the "output" folder,
otherwise a data frame is returned (optional)}

\item{logFile}{name of the comments file to be created, if provided,
the file is created in the "output" folder, otherwise a data frame is
returned (optional)}

\item{iiasatemplate}{filename of xlsx or yaml file provided by IIASA}

\item{targetVar}{(vector of) column name in template(s) containing the target variable names
(default: variable)}

\item{targetUnit}{column name in template containing the target units (default: unit)}

\item{remindVar}{column name in template containing the REMIND variable names (default: piam_variable)}

\item{remindUnit}{column name in template containing the REMIND units (default: piam_unit)}

\item{factorCol}{column name in template containing conversion factors (default: piam_factor)}

\item{weightCol}{column name in template containing weight factors (optional)}

\item{spatialCol}{column name in template containing regional restrictions
for reporting the corresponding variable (optional)}

\item{model}{exact name of the source model, used as column in comments file (default: REMIND-MAgPIE)}
}
\description{
Generate mapping from the template containing all the metadata
}
\examples{
\dontrun{
# Simple use. Creates NAVIGATE mapping and saves it to /output/template_navigate.csv:
generateMappingfile(
  templates = "NAVIGATE",
  fileName = "template_navigate.csv"
)
# More complex use. Creates combined mapping from NAVIGATE and SHAPE template:
generateMappingfile(
  templates = c("NAVIGATE", "SHAPE"),
  fileName = "template_combined.csv"
)
}
}
\author{
Falk Benke, Oliver Richters
}
