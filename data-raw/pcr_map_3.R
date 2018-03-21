Example_pcr_3_map_filename <- system.file("extdata", "Example_PCR_Quantification_Plate3_Map.csv", package = "FaithLabTools")

Example_pcr_3_map <- utils::read.csv(Example_pcr_3_map_filename)

devtools::use_data(Example_pcr_3_map, overwrite = TRUE)