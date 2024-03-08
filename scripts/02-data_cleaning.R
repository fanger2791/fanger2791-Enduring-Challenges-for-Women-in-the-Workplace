#### Preamble ####
# Purpose: Cleans the raw US Sensus data
# Author: David James Dimalanta, Harrison Huang, Michael Fang
# Date: 8 March 2024
# Contact: david.dimalanta@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(dplyr)
library(tidyverse)
library(knitr)
library(janitor)
library(lubridate)
library(readr)
library(ggplot2)

#### Clean data ####

# read in data
raw_data <- read_csv("data/raw_data/labor_data.csv")

# clean names
cleaned_data <- clean_names(raw_data)

# Filter by Full-Time Data
ft_data <- cleaned_data |>
  select(year_gss_year_for_this_respondent, x24, x25) |>
  slice(5:38) |>
  rename(year = year_gss_year_for_this_respondent, men = x24, women = x25)

# Filter by Part-Time Data
pt_data <- cleaned_data |>
  select(year_gss_year_for_this_respondent, x30, x31) |>
  slice(5:38) |>
  rename(year = year_gss_year_for_this_respondent, men = x30, women = x31)

# Filter by Unemployment Data
unem_data <- cleaned_data |>
  select(year_gss_year_for_this_respondent, x42, x43) |>
  slice(5:38) |>
  rename(year = year_gss_year_for_this_respondent, men = x42, women = x43)

# Filter by Domestic Work Contribution Data
domestic_data <- cleaned_data |>
  select(year_gss_year_for_this_respondent, x60, x61) |>
  slice(5:38) |>
  rename(year = year_gss_year_for_this_respondent, men = x60, women = x61)

# Format year data as numeric for line graphs
ft_data$year <- as.numeric(ft_data$year)
pt_data$year <- as.numeric(pt_data$year)
unem_data$year <- as.numeric(unem_data$year)
domestic_data$year <- as.numeric(domestic_data$year)

# Reshape the data to long format for line graphs and convert 'count' to numeric
ft_data_long <- ft_data |>
  pivot_longer(cols = c(men, women), names_to = "gender", values_to = "count") |>
  mutate(count = as.numeric(count))

pt_data_long <- pt_data |>
  pivot_longer(cols = c(men, women), names_to = "gender", values_to = "count") |>
  mutate(count = as.numeric(count))

unem_data_long <- unem_data |>
  pivot_longer(cols = c(men, women), names_to = "gender", values_to = "count") |>
  mutate(count = as.numeric(count))

domestic_data_long <- domestic_data |>
  pivot_longer(cols = c(men, women), names_to = "gender", values_to = "count") |>
  mutate(count = as.numeric(count))

### Save cleaned data to analysis_data folder
write_csv(ft_data, "data/analysis_data/full_time_data.csv")
write_csv(pt_data, "data/analysis_data/part_time_data.csv")
write_csv(unem_data, "data/analysis_data/unemployed_data.csv")
write_csv(domestic_data, "data/analysis_data/domestic_work_data.csv")


# Full-Time Work Data Line Graph
ggplot(ft_data_long, aes(x = year, y = count, color = gender, group = gender)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1500)) +
  labs(title = "Line Graph of Full-Time Work", x = "Year", y = "Count") +
  theme_minimal()

# Part-Time Work Data Line Graph
ggplot(pt_data_long, aes(x = year, y = count, color = gender, group = gender)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 300)) +
  labs(title = "Line Graph of Part-Time Work", x = "Year", y = "Count") +
  theme_minimal()

# Unemployment Data Line Graph
ggplot(unem_data_long, aes(x = year, y = count, color = gender, group = gender)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 250)) +
  labs(title = "Line Graph of Unemployment", x = "Year", y = "Count") +
  theme_minimal()

# Domestic Work Contribution Data Line Graph
ggplot(domestic_data_long, aes(x = year, y = count, color = gender, group = gender)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 500)) +
  labs(title = "Line Graph of Domestic Work Contribution", x = "Year", y = "Count") +
  theme_minimal()
