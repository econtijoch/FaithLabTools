Example_pcr_2_map_filename <- system.file("extdata", "Example_PCR_Quantification_Plate2_Map.csv", package = "FaithLabTools")

Example_pcr_2_map <- utils::read.csv(Example_pcr_2_map_filename)

devtools::use_data(Example_pcr_2_map, overwrite = TRUE)