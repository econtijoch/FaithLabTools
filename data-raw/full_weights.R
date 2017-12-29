Full_weights_filename <- system.file("extdata", "Example_Full_Weights.txt", package = "FaithLabTools")

Example_full_weights <-  readr::read_delim(Full_weights_filename, delim = '\t', col_names = F)

devtools::use_data(Example_full_weights, overwrite = TRUE)
