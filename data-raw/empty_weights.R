Empty_weights_filename <- system.file("extdata", "Example_Empty_Weights.txt", package = "FaithLabTools")

Example_empty_weights <- readr::read_delim(Empty_weights_filename, delim = '\t', col_names = F)

devtools::use_data(Example_empty_weights, overwrite = TRUE)
