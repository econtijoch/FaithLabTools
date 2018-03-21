#' Robot equal combine
#'
#' @param dataset input data set (e.g. DNA quantification of PCR products)
#' @param min_volume minimum volume of sample to combine
#' @param max_volume maximum volume of sample to combine
#' @param number_of_pools number of different pools to create (default = "Auto" which creates as few as possible while maintaining each pool under the maximum pool size)
#' @param maximum_pool_size maximum volume of any one pool
#' @param starting_plate_size 384 or 96
#' @param print_for_robot TRUE/FALSE to indicate whether or not a file should be made to be used with the robot (default = FALSE)
#' @param output_directory directory to save file for use with the robot print_for_robot must be TRUE (default = working directory)
#' @param output_filename filename for output file. If none is given, default will be "robot_pooling_file_YYYY_MM_DD.csv". It is not necessary to provide the '.csv' extension.
#'
#'
#' @return table that helps pool samples using robot (+/- saved .csv file)
#' @export
#'

robot_equal_combine <- function(dataset, min_volume = 1.5, max_volume = 6, number_of_pools = "Auto", maximum_pool_size = 500, starting_plate_size = 384, print_for_robot = FALSE, output_directory = getwd(), output_filename = NULL) {

  if (!all(c("BarcodeID", "PlateID", "SampleWell", "DNA_Concentration") %in% colnames(dataset))) {
    stop("Input dataset must contain the following columns:\nBarcodeID - designates individual samples\nPlateID - Name of plate where samples are located (will be put on the robot to combine)\nSampleWell - well within PlateID that sample is located (e.g. A01, O23, etc.)\nDNA_Concentration - DNA concentration")
  }

  sample_number <- nrow(dataset)
  robot_table <- dataset %>% dplyr::select(BarcodeID, PlateID, SampleWell, DNA_Concentration) %>%
    dplyr::mutate(BarcodeID = as.character(BarcodeID),
                  PlateID = stringr::str_replace_all(as.character(PlateID), "\\s", "_"),
                  Note = "",
                  DNASource = PlateID,
                  StartingConc = DNA_Concentration)

  maximum <- max(robot_table$DNA_Concentration)*min_volume

  for (i in 1:nrow(robot_table)) {
    volume_needed <- maximum/robot_table[i, 'DNA_Concentration']
    if (volume_needed > max_volume) {
      volume_needed <- max_volume
      robot_table[i, 'Warning'] <- paste0('[Warning]: Volume needed > ', max_volume, ' uL: transferred ', max_volume, ' uL only')
    }
    robot_table[i, 'volume_needed_even_pooling'] <- volume_needed

  }

  total_pooled_volume <- sum(robot_table$volume_needed_even_pooling)


  column_wise_destinations <- data.frame(Well_Number = 1:96, Well = well_number_to_location(1:96)) %>%
    dplyr::mutate(Row = substr(Well, 1, 1), Column = substr(Well, 2, 3)) %>%
    dplyr::arrange(Column)

  if (number_of_pools != "Auto" & is.numeric(number_of_pools)) {
    n_pools <- number_of_pools
  } else if (number_of_pools == "Auto") {
    n_pools <- ceiling(total_pooled_volume/maximum_pool_size)
    message(paste0("\nSamples will be pooled into ", n_pools, " pools. \nNote: Robot will pool into deep-well 96 well plate, starting at A01, then B01, etc."))
  } else {
    message("Unclear number of pools to make. Input a number or 'Auto'")
  }


  robot_table$DNASourceWell <- unlist(lapply(robot_table$SampleWell, well_parser, size = starting_plate_size))

  robot_table$DNA_Vol <- plyr::round_any(robot_table$volume_needed_even_pooling, 0.01)
  robot_table$Destination <- "Pooled_Samples"
  possible_destinations <- column_wise_destinations$Well_Number
  robot_table$DestinationWell <- rep(possible_destinations[1:n_pools], length.out = nrow(robot_table))

  robot_table$DNA_pooled <- robot_table$DNA_Vol*robot_table$DNA_Concentration

  output <- robot_table %>%
    dplyr::select(DNASource, DNASourceWell, Destination, DestinationWell, DNA_Vol, Warning,  BarcodeID, PlateID, SampleWell, DNA_pooled) %>%
    as.data.frame()

  output <- output %>% dplyr::arrange(DestinationWell)

  output_summary <- output %>%
    dplyr::group_by(DestinationWell) %>%
    dplyr::summarize(Volume = sum(DNA_Vol)) %>%
    dplyr::mutate(DestinationWell = well_number_to_location(DestinationWell))

  message(output_summary %>% pander::pander())

  message(paste('Total pooled volume:', plyr::round_any(sum(output_summary$Volume), 0.1)))
  message(paste0('\nApproximate amount of DNA pooled from each sample: ', plyr::round_any(stats::median(output$DNA_pooled), 0.1), " ng"))
  message("\nNames of plates needed for robot pooling:")
  message(paste(unique(output$PlateID), collapse = "\n"))

  if (print_for_robot) {
    if (!("PlateID" %in% colnames(dataset))) {
      stop("File does not contain a column named 'PlateID'. This is necessary to keep track of which samples come from which plates.")
    }
    if (!("SampleWell" %in% colnames(dataset))) {
      stop("File does not contain a column named 'SampleWell'. This is necessary to keep track of which samples come from which wells.")
    }

    if (!is.null(output_filename)) {
      robot_output_name <- paste0(output_directory, "/", output_filename, '.csv')
    } else {
      robot_output_name <- paste0(output_directory, '/robot_pooling_file_', gsub("-", "_", Sys.Date()), '.csv')
    }

    message(paste0("Robot file saved as ", robot_output_name))



    utils::write.table(x = output, file = robot_output_name, quote = FALSE, sep = ',', eol = "\r\n", col.names = TRUE, row.names = FALSE)


  }



  return(output)
}
