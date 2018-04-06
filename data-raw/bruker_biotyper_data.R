Example_Bruker_biotyper_html_filename <- system.file("extdata", "Example_Bruker_File.html", package = "FaithLabTools")

Example_Bruker_biotyper_html_file <- readr::read_file(Example_Bruker_biotyper_html_filename)

devtools::use_data(Example_Bruker_biotyper_html_file, overwrite = TRUE)
