Example_pcr_2_filename <- system.file("extdata", "Example_PCR_Quantification_Plate2_raw.xls", package = "FaithLabTools")

Example_pcr_2_data <- readxl::read_excel(Example_pcr_2_filename)

devtools::use_data(Example_pcr_2_data, overwrite = TRUE)
