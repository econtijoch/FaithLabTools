Sample_info_filename <- system.file("extdata", "Example_SampleInfo.csv", package = "FaithLabTools")

Example_sample_info <- readr::read_csv(Sample_info_filename)

devtools::use_data(Example_sample_info, overwrite = TRUE)
