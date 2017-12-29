#' Function to read in sample info from a file (excel or .csv)
#' @param file_path string containing path to file
#' @return Sample information in a data frame
#' @export
#'

read_sample_info <- function(file_path) {

  # Import file, handle xls(x) vs csv files
  if (utils::tail(unlist(strsplit(file_path, "\\.")), n = 1) == "csv") {
    file <- readr::read_csv(file_path)
  } else if (utils::tail(unlist(strsplit(file_path, "\\.")), n = 1) == "xls" | utils::tail(unlist(strsplit(file_path,
                                                                                                                   "\\.")), n = 1) == "xlsx") {
    file <- readxl::read_excel(file_path)
  }
#
#   if (!("Plate" %in% colnames(file))) {
#     warning("File does not contain a column named 'Plate'. This may be important in using other FaithLabTools functions in keeping track of samples across multiple plates. Consider adding a column to your file that gives each unique plate a name.")
#   }
#   if (!("Well" %in% colnames(file))) {
#     warning("File does not contain a column named 'Well'. This may be important in using other FaithLabTools functions in keeping track of samples across multiple plates.")
#   } else {
#     # Make sure wells are in the 2-digit format
#     file$Well <- as.character(file$Well)
#     well_rows <- stringr::str_sub(file$Well, 1, 1)
#     well_columns <- sprintf(as.numeric(stringr::str_sub(file$Well, 2, -1L)), fmt = '%02.0f')
#     file$Well <- paste0(well_rows, well_columns)
#   }
#   if (!("BarcodeID" %in% colnames(file))) {
#     warning("File does not contain a column named 'BarcodeID'. This may be important in using other FaithLabTools functions.")
#   }
    return(file)
}
