Example_pcr_4_filename <- system.file("extdata", "Example_PCR_Quantification_Plate4_raw.xls", package = "FaithLabTools")

Example_pcr_4_data <- readxl::read_excel(Example_pcr_4_filename)

devtools::use_data(Example_pcr_4_data, overwrite = TRUE)
