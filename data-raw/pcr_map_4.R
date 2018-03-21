Example_pcr_4_map_filename <- system.file("extdata", "Example_PCR_Quantification_Plate4_Map.csv", package = "FaithLabTools")

Example_pcr_4_map <- utils::read.csv(Example_pcr_4_map_filename)

devtools::use_data(Example_pcr_4_map, overwrite = TRUE)