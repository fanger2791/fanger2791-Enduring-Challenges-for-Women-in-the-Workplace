#### Preamble ####
# Purpose: Basic data integrity checks for datasets using tidyverse. This script first defines the check_census_data function tailored to check for:  # nolint
# - The range of years present in the dataset to ensure it matches expected years.
# - Missing values in the men and women columns to spot any incomplete data.
# - The data type for year, men, and women to ensure they are numeric as expected for analysis.
# - Negative values in men and women counts, which could indicate data entry errors. # nolint
# Author: David James Dimalanta, Harrison Huang, Michael Fang
# Date: 8 March 2024
# Contact: david.dimalanta@mail.utoronto.ca
# License: MIT
# Prerequisites:
# - 01-download_data.R
# - 02-data_cleaning.R



#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Load Data ####
ft_data <- read_csv("data/analysis_data/full_time_data.csv")
pt_data <- read_csv("data/analysis_data/part_time_data.csv")
unem_data <- read_csv("data/analysis_data/unemployed_data.csv")
domestic_data <- read_csv("data/analysis_data/domestic_work_data.csv")

#### Test data ####
#### Define data check function for US Census data ####
check_census_data <- function(data, dataset_name) {
  cat("### Checks for", dataset_name, "###\n")

  # Check for range of years
  if("year" %in% names(data)) {
    year_range <- range(data$year, na.rm = TRUE)
    cat("Year range:", year_range[1], "-", year_range[2], "\n")
  } else {
    cat("Year column missing.\n")
  }

  # Check for missing values in 'men' and 'women'
  missing_men <- sum(is.na(data$men))
  missing_women <- sum(is.na(data$women))
  cat("Missing values in men:", missing_men, "\n")
  cat("Missing values in women:", missing_women, "\n")

  # Check data type for 'men', 'women', and 'year'
  cat("Data type for men:", class(data$men)[1], "\n")
  cat("Data type for women:", class(data$women)[1], "\n")
  cat("Data type for year:", class(data$year)[1], "\n")

  # Check for negative values (which might be data entry errors)
  negative_men <- sum(data$men < 0, na.rm = TRUE)
  negative_women <- sum(data$women < 0, na.rm = TRUE)
  cat("Negative counts in men:", negative_men, "\n")
  cat("Negative counts in women:", negative_women, "\n\n")
}

#### Apply checks to each cleaned dataset ####
check_census_data(ft_data, "Full-Time Data")
check_census_data(pt_data, "Part-Time Data")
check_census_data(unem_data, "Unemployment Data")
check_census_data(domestic_data, "Domestic Work Contribution Data")
