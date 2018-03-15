robot_equal_combine <- function(dataset, min_volume = 1.5, max_volume = 6, number_of_pools = "Auto", maximum_pool_size = 500, starting_plate_size = 384) {

  if (!all(c("BarcodeID", "PlateID", "SampleWell", "dna_concentration") %in% colnames(dataset))) {
    stop("Input dataset must contain the following columns:\nBarcodeID - designates individual samples\nPlateID - Name of plate where samples are located (will be put on the robot to combine)\nSampleWell - well within PlateID that sample is located (e.g. A01, O23, etc.)\ndna_concentration - DNA concentration")
  }

  sample_number <- nrow(dataset)
  robot_table <- dataset %>% dplyr::select(BarcodeID, PlateID, SampleWell, dna_concentration) %>%
    dplyr::mutate(BarcodeID = as.character(BarcodeID),
                  PlateID = as.character(PlateID),
                  Warning = "",
                  DNASource = PlateID,
                  StartingConc = dna_concentration)

  maximum <- max(robot_table$dna_concentration)*min_volume

  for (i in 1:nrow(robot_table)) {
    volume_needed <- maximum/robot_table[i, 'dna_concentration']
    if (volume_needed > max_volume) {
      volume_needed <- max_volume
      robot_table[i, 'Warning'] <- paste0('[Warning]: Volume needed > ', max_volume, ' uL: transferred ', max_volume, ' uL only')
    }
    robot_table[i, 'volume_needed_even_pooling'] <- volume_needed

  }

  total_pooled_volume <- sum(robot_table$volume_needed_even_pooling)


  column_wise_destinations <- data.frame(Well_Number = 1:96, Well = well_number_to_well(1:96)) %>% mutate(Row = substr(Well, 1, 1), Column = substr(Well, 2, 3)) %>% arrange(Column)

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

  robot_table$DNA_pooled <- robot_table$DNA_Vol*robot_table$dna_concentration

  output <- robot_table %>%
    dplyr::select(DNASource, DNASourceWell, Destination, DestinationWell, DNA_Vol, Warning,  BarcodeID, PlateID, SampleWell, DNA_pooled) %>%
    as.data.frame()

  output <- output %>% dplyr::arrange(DestinationWell)

  output_summary <- output %>% group_by(DestinationWell) %>% summarize(Volume = sum(DNA_Vol)) %>% mutate(DestinationWell = well_number_to_well(DestinationWell))

  message(output_summary %>% pander::pander())

  message(paste('Total pooled volume:', plyr::round_any(sum(output_summary$Volume), 0.1)))

  message("\nNames of plates needed for robot dilution:")
  message(paste(unique(output$PlateID), collapse = "\n"))

  return(output)
}
