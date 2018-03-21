Example_pcr_3_filename <- system.file("extdata", "Example_PCR_Quantification_Plate3_raw.xls", package = "FaithLabTools")

Example_pcr_3_data <- readxl::read_excel(Example_pcr_3_filename)

devtools::use_data(Example_pcr_3_data, overwrite = TRUE)
