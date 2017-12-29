mapping_filename <- system.file("extdata", "Example_Mapping.csv", package = "FaithLabTools")

Example_mapping_file <- utils::read.csv(mapping_filename)

devtools::use_data(Example_mapping_file, overwrite = TRUE)