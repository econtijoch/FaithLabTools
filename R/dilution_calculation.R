#' Dilution calculator
#'
#' @param data_table data table containing smples to be diluted
#' @param concentration_column string containing name of column that contains concentration information
#' @param target_concentration target concentration of dilution (e.g. 2 for 16S, 25 for metagenomics)
#' @param maximum_sample_volume maximum amount of sample to be used to generate diluted sample (should definitely be less than the volume of your sample, but if it is too small, will limit the number of your samples that can be accurately diluted)
#' @param maximum_volume maximum volume of diluted sample (often limited by plate volume, e.g. 200 uL)
#' @param print_for_robot TRUE/FALSE to indicate whether or not a file should be made to be used with the robot (default = FALSE)
#' @param output_directory directory to save file for use with the robot print_for_robot must be TRUE (default = working directory)
#' @param output_filename filename for output file. If none is given, default will be "robot_dilution_file_YYYY_MM_DD.csv". It is not necessary to provide the '.csv' extension.
#'
#' @return data table with additional columns that are ready for dilutions
#' @export
#'

dilution_calculation <- function(data_table, concentration_column, target_concentration = 2, maximum_sample_volume = 40, maximum_volume = 200, print_for_robot = FALSE, output_directory = getwd(), output_filename = NULL) {
  # concentration_column <- dplyr::enquo(concentration_variable)
  concentration_column  <- as.name(concentration_column)

  output <- data_table %>%
    dplyr::mutate(Source_Concentration = (!!concentration_column),
                  Source_Volume = dplyr::case_when((!!concentration_column) <= target_concentration ~ maximum_sample_volume,
                                                   (!!concentration_column) <= 10*target_concentration ~ target_concentration*maximum_sample_volume/(!!concentration_column),
                                                   (!!concentration_column) <= maximum_volume*target_concentration/2 ~(maximum_volume*target_concentration/2)/(!!concentration_column),
                                                   (!!concentration_column) <= 3*maximum_volume*target_concentration/4 ~ (3*maximum_volume*target_concentration/4)/(!!concentration_column),
                                                   (!!concentration_column) <= maximum_volume*target_concentration ~ (maximum_volume*target_concentration)/(!!concentration_column),
                                                   (!!concentration_column) > maximum_volume*target_concentration ~ 1),
                  Source_Volume = plyr::round_any(Source_Volume, 0.05),
                  Water_Volume = dplyr::case_when((!!concentration_column) <= target_concentration ~ 0,
                                                  (!!concentration_column) <= 10*target_concentration ~ maximum_sample_volume - Source_Volume,
                                                  (!!concentration_column) <= maximum_volume*target_concentration/2 ~ maximum_volume/2 - Source_Volume,
                                                  (!!concentration_column) <= 3*maximum_volume*target_concentration/4 ~ (3*maximum_volume/4) - Source_Volume,
                                                  (!!concentration_column) <= maximum_volume*target_concentration ~ (maximum_volume) - Source_Volume,
                                                  (!!concentration_column) > maximum_volume*target_concentration ~ maximum_volume - 1),
                  Water_Volume = plyr::round_any(Water_Volume, 0.05),
                  Final_Volume = Source_Volume + Water_Volume,
                  Final_Concentration = ((!!concentration_column)*Source_Volume)/Final_Volume,
                  Final_Concentration = plyr::round_any(Final_Concentration, 0.05),
                  Note = dplyr::case_when((!!concentration_column) <= target_concentration ~ paste0("[WARNING - Low] Starting Concentration (",  plyr::round_any(Source_Concentration, 0.1), ") is less than target concentration (", target_concentration, "): Transferred maximum source volume (", maximum_sample_volume, " + 0 uL Water/EB"),
                                             (!!concentration_column) <= 10*target_concentration ~ paste0("[OK] Starting Concentration (",  plyr::round_any(Source_Concentration, 0.1), ") is between target concentration (", target_concentration, ") and 10x target concentration (", 10*target_concentration, "): Transferred ", Source_Volume, " uL + ", Water_Volume, " uL Water/EB"),
                                             (!!concentration_column) <= maximum_volume*target_concentration/2 ~ paste0("[OK] Starting Concentration is greater than 10x target concentration (",  plyr::round_any(Source_Concentration, 0.1), " ng/uL) using larger volume for dilution: Transferred ", Source_Volume, " uL + ", Water_Volume, " uL Water/EB"),
                                             (!!concentration_column) <= maximum_volume*target_concentration ~ paste0("[OK] Starting Concentration is under limit of dilution, maximum volume (", maximum_volume, ") x target concentration (", target_concentration, ") using large volume for dilution:  Transferred ", Source_Volume, " uL + ", Water_Volume, " uL Water/EB"),
                                             (!!concentration_column) > maximum_volume*target_concentration ~ paste0("[WARNING - Hi] Starting Concentration is greater than limit of dilution: Transferred ", Source_Volume, " uL + ", Water_Volume, " uL Water/EB")))

  if (print_for_robot) {
    if (!("PlateID" %in% colnames(data_table))) {
      stop("File does not contain a column named 'PlateID'. This is necessary to keep track of which samples come from which plates.")
    }
    if (!("SampleWell" %in% colnames(data_table))) {
      stop("File does not contain a column named 'SampleWell'. This is necessary to keep track of which samples come from which wells.")
    }

    robot_output <- output
    n_samples <- nrow(data_table)
    total_number_of_plates_needed <- ceiling(n_samples/96)

    robot_output$Destination <- ""
    robot_output$DestinationWell <- ""

    for (i in 1:total_number_of_plates_needed) {
      for (j in 1:96) {
        entry <- ((i - 1) * 96) + j
        if (entry <= n_samples) {
          robot_output[entry, "Destination"] <- paste("Normalized_Plate_", i, sep = "")
          row <- (j - 1) %/% 12
          column <- j - (12 * (row))
          row_id <- c("A", "B", "C", "D", "E", "F", "G", "H")
          robot_output[entry, "DestinationWell"] <- paste(row_id[row + 1], sprintf("%02d", column), sep = "")
        }
      }
      }

    robot_output <- robot_output %>%
      dplyr::mutate(WaterSource = "WaterSource",
                    WaterWell = 1,
                    DNASource = paste0("Unnormalized_", stringr::str_replace_all(PlateID, "\\s", "_")),
                    DNASourceWell = suppressWarnings(well_parser(SampleWell)),
                    DestinationWell = suppressWarnings(well_parser(DestinationWell)),
                    DNA_Vol = Source_Volume,
                    Water_Vol = Water_Volume) %>%
      dplyr::select(WaterSource, WaterWell, DNASource, DNASourceWell, Destination, DestinationWell, DNA_Vol, Water_Vol, Note, Source_Concentration, Final_Concentration, Final_Volume)


    if (!is.null(output_filename)) {
      robot_output_name <- paste0(output_directory, "/", output_filename, '.csv')
    } else {
      robot_output_name <- paste0(output_directory, '/robot_dilution_file_', gsub("-", "_", Sys.Date()), '.csv')
    }



    message(paste0("Dilution of ", n_samples, " samples will require ", total_number_of_plates_needed, " plate(s)."))
    message(paste0("Robot file saved as ", robot_output_name))



    utils::write.table(x = robot_output, file = robot_output_name, quote = FALSE, sep = ',', eol = "\r\n", col.names = TRUE, row.names = FALSE)


  }

  return(output)
}

