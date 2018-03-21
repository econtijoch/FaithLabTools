Example_pcr_stds_filename <- system.file("extdata", "Example_PCR_Quantification_Standards_raw.xls", package = "FaithLabTools")

Example_pcr_stds_data <- readxl::read_excel(Example_pcr_stds_filename)

devtools::use_data(Example_pcr_stds_data, overwrite = TRUE)
