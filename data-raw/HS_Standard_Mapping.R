HS_standard_mapping_filename <- system.file("extdata", "Example_HS_Standards_Mapping.csv", package = "FaithLabTools")

Example_HS_standard_mapping <- utils::read.csv(HS_standard_mapping_filename)

devtools::use_data(Example_HS_standard_mapping, overwrite = TRUE)
