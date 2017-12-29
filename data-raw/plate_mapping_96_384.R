plate_mapping_96_384_filename <- system.file("extdata", "plate_mapping_96_384.csv", package = "FaithLabTools")

plate_mapping_96_384 <- readr::read_csv(plate_mapping_96_384_filename)

devtools::use_data(plate_mapping_96_384, overwrite = TRUE)

