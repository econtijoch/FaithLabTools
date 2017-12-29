index_mapping_metagenomics_filename <- system.file("extdata", "index_mapping_metagenomics.csv", package = "FaithLabTools")

index_mapping_metagenomics <- readr::read_csv(index_mapping_metagenomics_filename)

devtools::use_data(index_mapping_metagenomics, overwrite = TRUE)

index_mapping_16S_filename <- system.file("extdata", "index_mapping_16S.csv", package = "FaithLabTools")

index_mapping_16S <- readr::read_csv(index_mapping_16S_filename)

devtools::use_data(index_mapping_16S, overwrite = TRUE)

