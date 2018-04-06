#' Read Bruker Biotyper data into data table
#'
#' @param bruker_html_file path to Bruker biotyper html file output
#'
#' @return data table containing Bruker biotyper data
#' @export
#'
read_bruker_file <- function(bruker_html_file) {
  html_object <- xml2::read_html(bruker_html_file)
  html_tables <- rvest::html_table(html_object)
  biotyper_data <- html_tables[[2]]
  return(biotyper_data)
}