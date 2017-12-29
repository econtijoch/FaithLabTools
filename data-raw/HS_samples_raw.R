HS_samples_raw_filename <- system.file("extdata", "Example_HS_raw.xls", package = "FaithLabTools")

Example_HS_samples_raw <- readxl::read_excel(HS_samples_raw_filename)

devtools::use_data(Example_HS_samples_raw, overwrite = TRUE)
