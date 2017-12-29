#' Raw Fluorescence data for the plate measured with Broad-Range dye
#'
#' A dataset that contains the information from a plate reader file, and is used to re-create a raw fluorescence file as if it came from the plate reader. This data is used in the sample_file_maker script to generate sample raw files.
#'
#' @docType data
#' @format This data is not in a standard format since it is simply the data read in directly from an excel file.
#' @source Generated in lab.
#' @name Example_BR_samples_raw
"Example_BR_samples_raw"

#' Mapping file for the plate containing Broad-Range dye standard curve
#'
#' A dataset that contains the information from a mapping, and is used to re-create a template mapping file. This data is used in the sample_file_maker script to generate a sample mapping file. This dataset contains an example of how to include standards for a standard curve
#'
#' @docType data
#' @format A table with 96 rows and 10 columns
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_BR_standard_mapping
"Example_BR_standard_mapping"

#' Raw Fluorescence data for the plate measured with High-Sensitivity dye
#'
#' A dataset that contains the information from a plate reader file, and is used to re-create a raw fluorescence file as if it came from the plate reader. This data is used in the sample_file_maker script to generate sample raw files.
#'
#' @docType data
#' @format This data is not in a standard format since it is simply the data read in directly from a .csv file.
#' @source Generated in lab.
#' @name Example_HS_samples_raw
"Example_HS_samples_raw"

#' Mapping file for the plate containing High-Sensitivity dye standard curve
#'
#' A dataset that contains the information from a mapping, and is used to re-create a template mapping file. This data is used in the sample_file_maker script to generate a sample mapping file. This dataset contains an example of how to include standards for a standard curve
#'
#' @docType data
#' @format A table with 96 rows and 10 columns
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_HS_standard_mapping
"Example_HS_standard_mapping"


#' Empty tube weight file
#'
#' A file that contains the empty tube weights of tubes used in experiment - scanned for tube barcode and BarcodeID for linking with mapping file
#'
#' @docType data
#' @format tab-delimited text file
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_empty_weights
"Example_empty_weights"


#' Full tube weight file
#'
#' A file that contains the full tube weights of tubes used in experiment - scanned for tube barcode for linking with empty weights file
#'
#' @docType data
#' @format tab-delimited text file
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_full_weights
"Example_full_weights"


#' Mapping file for samples in microbial density experiment
#'
#' A dataset that contains the information from a mapping, and is used to re-create a template mapping file. This data is used in the sample_file_maker script to generate a sample mapping file
#'
#' @docType data
#' @format A table with 96 rows and 21 columns
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_mapping_file
"Example_mapping_file"


#' Sample Info for samples in microbial density experiment
#'
#' A dataset that contains the information used to create a mapping file
#'
#' @docType data
#' @format A table with 96 rows and 21 columns
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_sample_info
"Example_sample_info"


#' Raw Fluorescence data for the plate containing standards
#'
#' A dataset that contains the information from a plate reader file, and is used to re-create a raw fluorescence file as if it came from the plate reader. This data is used in the sample_file_maker script to generate sample raw files.
#'
#' @docType data
#' @format This data is not in a standard format since it is simply the data read in directly from a .csv file.
#' @source Generated in lab.
#' @name Example_tandards_raw
"Example_standards_raw"


#' Tube Order from 96-well format barcode scanner (.csv)
#'
#' A dataset that contains the location of tubes used in experiment
#'
#' @docType data
#' @format A table with up to 96 rows
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_matrix_plate_scan
"Example_matrix_plate_scan"



#' Fully processed other data (.csv)
#'
#' A dataset that contains processed data from othere experiments
#'
#' @docType data
#' @format Table with many samples
#' @source Generated in lab for the purposes of analyzing this type of data
#' @name Example_other_data
"Example_other_data"

#' Table containing 16S indexes (barcodes)
#'
#' A data frame containing the location and sequencing indexes for 16S
#'
#' @docType data
#' @format Table
#' @source Generated for helping demultiplex 16S libraries
#' @name index_mapping_16S
"index_mapping_16S"

#' Table containing metagenomic sequencing indexes from IDT (barcodes)
#'
#' A data frame containing the location and sequencing indexes for metagenomics
#'
#' @docType data
#' @format Table
#' @source Generated for helping demultiplex metagenomics libraries
#' @name index_mapping_metagenomics
"index_mapping_metagenomics"

#' Table to help map four 96-well plate locations to one 384 well plate
#'
#' A data frame containing the location of each 'quadrant' of 96 well plates to one single 384-well plate
#'
#' @docType data
#' @format Table
#' @source Generated for helping shift between 4x96-well and 384-well plate formats
#' @name plate_mapping_96_384
"plate_mapping_96_384"