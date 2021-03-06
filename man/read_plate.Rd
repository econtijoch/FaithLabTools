% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_plate.R
\name{read_plate}
\alias{read_plate}
\title{Function to read in mapping file and tweak format so that it is friendly with the rest of the package functinos}
\usage{
read_plate(plate_reader_file, size = 96, plate_name = NA)
}
\arguments{
\item{plate_reader_file}{Fluorescence data from the plate reader (can be in .csv or .xls(x) format -- if in excel file, only the FIRST sheet within the file will be read)}

\item{size}{optional size of plate (96 or 384)}

\item{plate_name}{optional name to giv ethe plate}
}
\value{
a list containing: 1) a data frame with the data from the plate reader file and 2) the number of measurements taken for each sample
}
\description{
Function to read in mapping file and tweak format so that it is friendly with the rest of the package functinos
}
