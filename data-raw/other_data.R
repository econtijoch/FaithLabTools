other_data_raw_filename <- system.file("extdata", "Example_Other_Data.csv", package = "FaithLabTools")

Example_other_data <- readr::read_csv(other_data_raw_filename)

devtools::use_data(Example_other_data, overwrite = TRUE)
