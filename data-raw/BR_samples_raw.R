BR_samples_raw_filename <- system.file("extdata", "Example_BR_raw.xls", package = "FaithLabTools")

Example_BR_samples_raw <- readxl::read_excel(BR_samples_raw_filename)

devtools::use_data(Example_BR_samples_raw, overwrite = TRUE)

