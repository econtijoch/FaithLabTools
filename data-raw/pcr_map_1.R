Example_pcr_1_map_filename <- system.file("extdata", "Example_PCR_Quantification_Plate1_Map.csv", package = "FaithLabTools")

Example_pcr_1_map <- utils::read.csv(Example_pcr_1_map_filename)

devtools::use_data(Example_pcr_1_map, overwrite = TRUE)