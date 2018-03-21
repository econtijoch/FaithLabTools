Example_pcr_1_filename <- system.file("extdata", "Example_PCR_Quantification_Plate1_raw.xls", package = "FaithLabTools")

Example_pcr_1_data <- readxl::read_excel(Example_pcr_1_filename)

devtools::use_data(Example_pcr_1_data, overwrite = TRUE)
