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
