BR_standard_mapping_filename <- system.file("extdata", "Example_BR_Standards_Mapping.csv", package = "FaithLabTools")

Example_BR_standard_mapping <- utils::read.csv(BR_standard_mapping_filename)

devtools::use_data(Example_BR_standard_mapping, overwrite = TRUE)
