#' Matrix plate parser
#'
#' @param matrix_barcode_plate_scan file from matrix rack scanner
#' @param plate_name name of plate. If not provided, will pull name from the plate scanner file (RackID)
#' @return table of tubes
#' @export
#'

matrix_plate_parser <- function(matrix_barcode_plate_scan, plate_name = NA) {
  # Read in order file if .csv
  if (utils::tail(unlist(strsplit(matrix_barcode_plate_scan, "\\.")), n = 1) == "csv") {
    tube_order <-
      readr::read_csv(
        matrix_barcode_plate_scan,
        skip = 0
      ) %>% dplyr::mutate(SampleWell = paste0(LocationRow, sprintf(LocationColumn, fmt = '%02.0f')), TubeBarcode = TubeCode, PlateID = ifelse(is.na(plate_name), RackID, plate_name)) %>% dplyr::select(PlateID, SampleWell, TubeBarcode)
  } else if (utils::tail(unlist(strsplit(matrix_barcode_plate_scan, "\\.")), n = 1) == "xls" |
             utils::tail(unlist(strsplit(matrix_barcode_plate_scan,
                                         "\\.")), n = 1) == "xlsx") {
    # Read in order file if .xls , .xlsx
    order_file <-
      readxl::read_excel(matrix_barcode_plate_scan, col_names = F)
    if (is.na(plate_name)) {
      plate_name <- "No_Name_Plate"
    }
    tube_order <-
      data.frame(
        PlateID = NA,
        SampleWell = NA,
        TubeBarcode = NA,
        stringsAsFactors = FALSE
      )

    # Parse plate layout to table
    rows <- LETTERS[1:8]
    cols <- sprintf(1:12, fmt = '%02.0f')

    rows_length <- length(rows)
    cols_length <- length(cols)

    wells <- ""
    for (r in 1:rows_length) {
      for (c in 1:cols_length) {
        index <- (r - 1) * 12 + c
        index_name <- paste0(rows[r], cols[c])
        wells <- c(wells, index_name)

        tube_order[index, "SampleWell"] <-
          as.character(index_name)
        if (nchar(as.character(order_file[r, c])) == 9) {
          tube_order[index, "TubeBarcode"] <-
            paste0("0", as.character(order_file[r, c]))
        } else {
          tube_order[index, "TubeBarcode"] <-
            as.character(order_file[r, c])
        }
      }
    }
    tube_order$PlateID <- plate_name
  }

  return(tube_order)
}
