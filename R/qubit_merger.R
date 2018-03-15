#' Function to improve accuracy of DNA measurements for samples measured with both HS and BR dye
#'
#' @param hs_data data frame with HS dye data
#' @param br_data data frame with BR dye data
#'
#' @return data frame with more accurate DNA concentrations and microbial density measurements
#' @export


qubit_merger <- function(hs_data, br_data) {
  hs_data_long <- hs_data %>% dplyr::mutate_(HS_Measurement = "Measurement", HS_dna_concentration = "`DNA Concentration (ng/uL)`") %>% dplyr::select_("-Measurement", "-`DNA Concentration (ng/uL)`", "-`Total DNA (ug)`", "-`Qubit Volume`")
  br_data_long <- br_data  %>% dplyr::mutate_(BR_Measurement = "Measurement", BR_dna_concentration = "`DNA Concentration (ng/uL)`") %>% dplyr::select_("-Measurement", "-`DNA Concentration (ng/uL)`", "-`Total DNA (ug)`", "-`Qubit Volume`")

  combined_data <- dplyr::full_join(hs_data_long, br_data_long)

  output_data <- combined_data %>% dplyr::mutate(
    `DNA Concentration (ng/uL)` = ifelse(
      test = (HS_dna_concentration < 75 & BR_dna_concentration < 50), yes =  HS_dna_concentration, no = ifelse(
        test = (BR_dna_concentration > 50 & HS_dna_concentration > 75), yes = BR_dna_concentration, no = (HS_dna_concentration + BR_dna_concentration)/2
      )
    ),
    `Qubit Dye Used` = ifelse(
      test = (HS_dna_concentration < 75 & BR_dna_concentration < 50), yes =  "HS", no = ifelse(
        test = (BR_dna_concentration > 50 & HS_dna_concentration > 75), yes = "BR", no = "Average"
      )
    ),
    `Total DNA (ug)` = `DNA Concentration (ng/uL)` * `Elution Volume` / 1000,
  )
  return(output_data)
}
