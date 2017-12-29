
#' Measure DNA concentration for using qubit to quantify DNA
#'
#' @param plate_reader_file relative location to relevant plate reader file (accepts excel files)
#' @param standards_plate_reader_file relative location to the plate reader file containing the standards (if it is the same as the plate you want to quantify, it is not necessary to explicitly specify
#' @param standard_wells a vector containing the wells that contain the standards in increasing concentration (e.g. c("A01", "A02", "A03", "A04", "A05", "A06", "A07", "A08"))
#' @param dye_used "BR" or "HS" to specify quantification with HS or BR dye
#' @param qubit_volume volume of sample used for quantification (default = 2)
#' @param elution_volume volume of your sample (used to compute total DNA in sample, default = 100)
#' @param plate_size size of plate (default = 96, alternative is 384 - not tested yet)
#' @param plate_name name to give plate (helps when using multiple plates)
#' @param print_standard_curve TRUE or FALSE to indicate whether or not to save a .pdf image containing the standard curve
#'
#' @return table with DNA concentrations for each sample, given the input parameters
#' @export
#'


measure_dna_concentration <- function(plate_reader_file, standards_plate_reader_file = plate_reader_file, standard_wells, dye_used, qubit_volume = 2, elution_volume = 100, plate_size = 96, plate_name = "DNA_Plate", print_standard_curve = FALSE) {

  if (dye_used == "HS") {
    standard_values <- c(0, 5, 10, 20, 40, 60, 80, 100)
  } else if (dye_used == "BR") {
    standard_values <- c(0, 50, 100, 200, 400, 600, 800, 1000)
  } else {
    stop("Dye must be 'HS' or 'BR'")
  }

  plate <- read_plate(plate_reader_file = plate_reader_file, size = plate_size, plate_name = plate_name)

  standard_data <- read_plate(plate_reader_file = standards_plate_reader_file, size = plate_size) %>%
    dplyr::filter(Well %in% standard_wells)

  standard_data$`DNA in Standard` <- standard_values

  standard_curve <- stats::lm(standard_data$`DNA in Standard` ~ standard_data$Measurement)

  scale_x <- standard_curve$coefficients[2]
  intercept <- standard_curve$coefficients[1]
  rsquared <- summary(standard_curve)$r.squared

  # Make Plot of Standard Curve
  standards_info <- paste(paste("Line of best fit: Y = ", round(scale_x, 5), "* X ", round(intercept, 5)), paste("R^2 = ",
                                                                                                                 round(rsquared, 5)), sep = "\n")

  name <- paste0(plate_name, "_", dye_used, "_", "Standard Curve.pdf")
  standards_plot <- ggplot2::ggplot(data = standard_data, ggplot2::aes_string(x = "Measurement", y = "`DNA in Standard`")) +
    ggplot2::geom_point(size = 4) + ggplot2::labs(x = "Measurement", y = "ug DNA in Standard", main = "Standard Curve") +
    ggplot2::geom_smooth(method = "lm", se = FALSE) +
    ggplot2::annotate("text", x = 0, y = max(standard_data$`DNA in Standard`), hjust = 0, label = standards_info) + ggplot2::theme_bw() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(size = 18, angle = 0, hjust = 0.5, color = "black"))

  if (print_standard_curve == TRUE) {
    cowplot::save_plot(filename = name, plot = standards_plot, base_height = 6, base_width = 6)
  }


  message(paste0("Standards Information:\nLine of best fit: Y = ", round(scale_x, 5), "* X ", round(intercept, 5), "\nR^2 = ", round(rsquared, 5)))

  sample_data <- plate %>%
    dplyr::mutate(`Qubit Volume` = qubit_volume,
                  `DNA Concentration (ng/uL)` = (Measurement * scale_x + intercept)/qubit_volume,
                  `Elution Volume` = elution_volume,
                  `Total DNA (ug)` = `DNA Concentration (ng/uL)` * elution_volume / 1000,
                  Plate = plate_name) %>%
    dplyr::select(Plate, dplyr::everything())

  if (standards_plate_reader_file == plate_reader_file) {
    sample_data <- sample_data %>% dplyr::filter(!(Well %in% standard_wells))
  }

  return(sample_data)
}
