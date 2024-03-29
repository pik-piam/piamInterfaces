#' checkVariablesNames checks reporting and mappings on inconsistency in variable names
#'
#' Pass a vector of variable names including the units. Get warnings if inconsistencies are found
#' for the reporting
#' @param vars vector with variable names and units such as "PE (EJ)"
#' @author Oliver Richters
#' @export
checkVarNames <- function(vars) {

  barspace <- grep("[\\| ]{2}|^[\\| ]|[\\| ]$", vars, value = TRUE)
  if (length(barspace) > 0) {
    warning("These variable names have wrong bars and spaces: ", paste(barspace, collapse = ", "))
  }

  naVar <- grep("[\\|\\( ]NA[\\|\\) ]|^NA", vars, value = TRUE)
  if (length(naVar) > 0) {
    warning("These variables and units contain NA: ", paste(naVar, collapse = ", "))
  }

  noUnit <- grep(" \\(.*\\)$", vars, value = TRUE, invert = TRUE)
  if (length(noUnit) > 0) {
    warning("These variables have no units: ", paste(noUnit, collapse = ", "))
  }

  return(c(barspace, naVar, noUnit))
}
