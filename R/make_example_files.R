#' Function to generate sample data files to work wtih locally
#' @param directory If given, a directory into which to create files
#' @return A collection of files useful for getting started with the FaithLabTools package
#' @export
#'

make_example_files <- function(directory = getwd()) {

  utils::data('Example_BR_samples_raw')
  utils::data('Example_HS_samples_raw')
  utils::data('Example_BR_standard_mapping')
  utils::data('Example_HS_standard_mapping')
  utils::data('Example_empty_weights')
  utils::data('Example_full_weights')
  utils::data('Example_mapping_file')
  utils::data('Example_sample_info')
  utils::data('Example_standards_raw')
  utils::data('Example_matrix_plate_scan')
  utils::data('Example_other_data')


  starting <- getwd()
  if (file.exists(directory)) {
    setwd(directory)
  } else {
    dir.create(directory)
    setwd(directory)
  }

  # Make excel files
  writexl::write_xlsx(x = Example_BR_samples_raw, path = paste(directory, "Example_BR_raw.xlsx", sep = "/"))
  writexl::write_xlsx(x = Example_HS_samples_raw, path = paste(directory, "Example_HS_raw.xlsx", sep = "/"))
  writexl::write_xlsx(x = Example_standards_raw, path = paste(directory, "Example_standards_raw.xlsx", sep = "/"))

  # Make .csv files
  readr::write_csv(Example_BR_standard_mapping, path = paste(directory, "Example_BR_standards_mapping.csv", sep = "/"))
  readr::write_csv(Example_HS_standard_mapping, path = paste(directory, "Example_HS_standards_mapping.csv", sep = "/"))
  readr::write_csv(Example_mapping_file, path = paste(directory, "Example_mapping.csv", sep = "/"))
  readr::write_csv(Example_sample_info, path = paste(directory, "Example_sampleInfo.csv", sep = "/"))
  readr::write_csv(Example_matrix_plate_scan, path = paste(directory, "Example_matrix_plate_scan.csv", sep = "/"))
  readr::write_csv(Example_other_data, path = paste(directory, "Example_other_data.csv", sep = "/"))

  # Make .txt files
  readr::write_delim(Example_empty_weights, path = paste(directory, "Example_empty_weights.txt", sep = "/"), delim = '\t', col_names = F)
  readr::write_delim(Example_full_weights, path = paste(directory, "Example_full_weights.txt", sep = "/"), delim = '\t', col_names = F)

  setwd(starting)
}
