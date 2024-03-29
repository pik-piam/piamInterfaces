minimalLength <- list("AR6" = 1900, "NAVIGATE" = 1900)
for (mapping in names(mappingNames())) {
  test_that(paste("checks on mapping", mapping), {
    expect_silent(mappingData <- getTemplate(mapping))
    expect_true(all(c("variable", "unit", "piam_variable", "piam_unit", "piam_factor") %in% names(mappingData)))
    expect_true(class(mappingData) == "data.frame")
    expect_true(length(mappingData$variable) > max(0, unlist(minimalLength[mapping])))
    # look for empty cells in variable column
    expect_true(sum(is.na(mappingData$variable)) == 0)

    # look for merge conflicts
    conflictsigns <- grep("===|<<<|>>>", mappingData[, 1], value = TRUE)
    if (length(conflictsigns) > 0) {
      warning("Lines that look like merge conflicts:\n", paste(conflictsigns, collapse = "\n"))
    }
    expect_true(length(conflictsigns) == 0, label = paste0(mapping, " has no merge conflicts"))

    # check for inconsistent variable + unit combinations
    nonempty <- dplyr::filter(mappingData, ! is.na(.data$piam_variable), ! .data$piam_variable == "TODO")
    allVarUnit <- paste0(nonempty$piam_variable, " (", nonempty$piam_unit, ")")
    unclearVar <- nonempty$piam_variable[duplicated(nonempty$piam_variable) & ! duplicated(allVarUnit)]
    unclearVarUnit <- sort(unique(allVarUnit[nonempty$piam_variable %in% unclearVar]))
    if (length(unclearVarUnit) > 0) {
      warning("Inconsistent units found for piam_variable:\n",
              paste(unclearVarUnit, collapse = "\n"))
    }
    expect_true(length(unclearVarUnit) == 0, label = paste("PIAM variables and units are consistent for", mapping))

    allVarUnit <- paste0(mappingData$variable, " (", mappingData$unit, ")")
    unclearVar <- mappingData$variable[duplicated(mappingData$variable) & ! duplicated(allVarUnit)]
    unclearVarUnit <- sort(unique(allVarUnit[mappingData$variable %in% unclearVar]))
    if (length(unclearVarUnit) > 0) {
      warning("Inconsistent units found for project variable:\n",
              paste(unclearVarUnit, collapse = "\n"))
    }
    expect_true(length(unclearVarUnit) == 0, label = paste("variables and units are consistent for", mapping))

    unitfails <- mappingData %>%
      filter(! checkUnitFactor(mappingData)) %>%
      select(c("variable", "unit", "piam_variable", "piam_unit", "piam_factor")) %>%
      arrange(.data$variable)
    if (nrow(unitfails) > 0) {
      printoutput <- withr::with_options(list(width = 180), print(unitfails, n = 200, na.print = "")) %>%
        capture.output()
      warning("Failing units in ", mapping, ".\nIf that is a false positive, ",
              "adjust areUnitsIdentical() or checkUnitFactor()\n",
              paste(printoutput, collapse = "\n"))
    }
    expect_true(nrow(unitfails) == 0)

    # checks only if source is supplied
    if ("source" %in% colnames(mappingData)) {
      # check for empty piam_variable with source
      sourceWithoutVar <- mappingData %>%
        filter(! is.na(.data$source), is.na(.data$piam_variable)) %>%
        pull("variable")
      if (length(sourceWithoutVar) > 0) {
        warning("These variables in mapping ", mapping, " have a source, but nothing specified in piam_variable:\n",
                paste(sourceWithoutVar, collapse = "\n"))
      }
      expect_true(length(sourceWithoutVar) == 0)

      # check for piam_variable without source if source is supplied
      varWithoutSource <- mappingData %>%
        filter(! is.na(.data$piam_variable), ! .data$piam_variable %in% "TODO", is.na(.data$source)) %>%
        pull("piam_variable") %>%
        unique()
      if (length(varWithoutSource) > 0) {
        warning("These piam_variable in mapping ", mapping, " have no source:\n",
                paste(varWithoutSource, collapse = "\n"))
      }
      expect_true(length(varWithoutSource) == 0)
    } # end source checks
  })
}
