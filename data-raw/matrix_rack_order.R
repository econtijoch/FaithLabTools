Example_matrix_plate_scan_filename <- system.file("extdata", "Example_Matrix_Rack_Scanner_File.csv", package = "FaithLabTools")

Example_matrix_plate_scan <- utils::read.csv(Example_matrix_plate_scan_filename)

devtools::use_data(Example_matrix_plate_scan, overwrite = TRUE)

