Standards_raw_filename <- system.file("extdata", "Example_Standards_raw.xls", package = "FaithLabTools")

Example_standards_raw <- readxl::read_excel(path = Standards_raw_filename)

devtools::use_data(Example_standards_raw, overwrite = TRUE)
