#' Well number to location. Changes well number (e.g. 1, 2, 3, ...) to a well location (A01, A02, A03, ...)
#'
#' @param well_number numeric
#' @param size size of plate (96 or 384)
#'
#' @return well location (e.g. A01, A02, A03, etc)
#' @export
#'

well_number_to_location <- function(well_number, size = 96) {

  if (size == 384) {
    row <- ((well_number - 1) %/% 24) + 1

    column_number <- (well_number - ((row - 1)*24))

    column <- sprintf(column_number, fmt = '%02.0f')

    well_location <- paste0(LETTERS[row], column)
  } else if (size == 96) {
    row <- ((well_number - 1) %/% 12) + 1

    column_number <- (well_number - ((row - 1)*12))

    column <- sprintf(column_number, fmt = '%02.0f')

    well_location <- paste0(LETTERS[row], column)
  } else {
    message("Specify size as either 96 or 384")
  }


  return(well_location)
}
