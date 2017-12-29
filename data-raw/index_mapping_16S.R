index_mapping_16S_filename <- system.file("extdata", "index_mapping_16S.csv", package = "FaithLabTools")

index_mapping_16S <- readr::read_csv(index_mapping_16S_filename)

devtools::use_data(index_mapping_16S, overwrite = TRUE)

