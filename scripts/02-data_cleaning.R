#### Preamble ####
# Purpose: Cleans the raw US Sensus data
# Author: David James Dimalanta, Harrison Huang, Michael Fang
# Date: 8 March 2024
# Contact: david.dimalanta@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - 01-download_data.R

#### Workspace setup ####
library(dplyr)
library(tidyverse)
library(knitr)
library(janitor)
library(lubridate)
library(readr)
library(ggplot2)

#### Clean data ####

# read in datasets
raw_data <- read_csv("data/raw_data/labor_data.csv")
raw_education_data <- read_csv("data/raw_data/education.csv")
raw_fefam_data <- read_csv("data/raw_data/fefam.csv")
raw_fehire_data <- read_csv("data/raw_data/should_hire_women.csv")
raw_discaffw_data <- read_csv("data/raw_data/women_wont_get_job.csv")
# clean names for datasets
cleaned_data <- clean_names(raw_data)
cleaned_education_data <- clean_names(raw_education_data)
cleaned_fefam_data <- clean_names(raw_fefam_data)
cleaned_fehire_data <- clean_names(raw_fehire_data)
cleaned_discaffw_data <- clean_names(raw_discaffw_data)

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

# clean discaffw dataset
discaffw_data <- cleaned_discaffw_data |>
  select(year_gss_year_for_this_respondent, x6, x7, x8, x9) |>
  slice(3:15) |>
  rename(year = year_gss_year_for_this_respondent,
         very_likely = x6, somewhat_likely = x7,
         somewhat_unlikely = x8, very_unlikely = x9)

# clean fehire dataset
fehire_data <- cleaned_fehire_data |>
  select(year_gss_year_for_this_respondent, x6, x7, x8, x9) |>
  slice(3:25) |>
  rename(year = year_gss_year_for_this_respondent,
         strongly_agree = x6, agree = x7,
         disagree = x8, strongly_disagree = x9)

# clean fefam dataset
fefam_data <- cleaned_fefam_data |>
  select(year_gss_year_for_this_respondent, x6, x7, x8, x9) |>
  slice(3:25) |>
  rename(year = year_gss_year_for_this_respondent,
         strongly_agree = x6, agree = x7,
         disagree = x8, strongly_disagree = x9)

# clean education dataset
education_data <- cleaned_education_data |>
  select(year, female, x8, x9, x10, x11) |>
  slice(2:35) |>
  rename(less_than_highschool = female,
         high_school = x8,
         junior_college = x9,
         bachelor = x10,
         graduate = x11)


# Format year data as numeric for line graphs
ft_data$year <- as.numeric(ft_data$year)
pt_data$year <- as.numeric(pt_data$year)
unem_data$year <- as.numeric(unem_data$year)
domestic_data$year <- as.numeric(domestic_data$year)
education_data$year <- as.numeric(education_data$year)
fefam_data$year <- as.numeric(fefam_data$year)
fehire_data$year <- as.numeric(fehire_data$year)
discaffw_data$year <- as.numeric(discaffw_data$year)

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

education_data_long <- education_data |>
  pivot_longer(cols = c(less_than_highschool, high_school, junior_college, bachelor, graduate),
               names_to = "Education Level",
               values_to = "Count") |>
  mutate(Count = as.numeric(Count))

fefam_data_long <- fefam_data |>
  pivot_longer(cols = c(strongly_agree, agree, disagree, strongly_disagree),
               names_to = "Response to: better for man to work, woman tend home",
               values_to = "count") |>
  mutate(count = as.numeric(count))

fehire_data_long <- fehire_data |>
  pivot_longer(cols = c(strongly_agree, agree, disagree, strongly_disagree),
               names_to = "Response",
               values_to = "Count") |>
  mutate(Count = as.numeric(Count))

discaffw_data_long <- discaffw_data |>
  pivot_longer(cols = c(very_likely, somewhat_likely, somewhat_unlikely, very_unlikely),
               names_to = "Response",
               values_to = "Count") |>
  mutate(Count = as.numeric(Count))



### Save cleaned data to analysis_data folder
write_csv(ft_data, "data/analysis_data/full_time_data.csv")
write_csv(pt_data, "data/analysis_data/part_time_data.csv")
write_csv(unem_data, "data/analysis_data/unemployed_data.csv")
write_csv(domestic_data, "data/analysis_data/domestic_work_data.csv")
write_csv(education_data, "data/analysis_data/education_data.csv")
write_csv(fefam_data, "data/analysis_data/fefam_data.csv")
write_csv(fehire_data, "data/analysis_data/fehire_data.csv")
write_csv(discaffw_data, "data/analysis_data/discaffw_data.csv")


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


# education line graph
ggplot(education_data_long, aes(x = year, y = Count, group = `Education Level`, color = `Education Level`)) +
  geom_line() +
  labs(title = "Education Levels Over Time",
       x = "Year",
       y = "Count",
       color = "Education Level") +
  theme_minimal()

# fefam line graph
ggplot(fefam_data_long, aes(x = year, y = count, group = `Response to: better for man to work, woman tend home`, color = `Response to: better for man to work, woman tend home`)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1200)) +
  labs(title = "Responses to: better for man to work, woman tend home",
       x = "Year",
       y = "Count") +
  theme_minimal()

# fehire line graph
ggplot(fehire_data_long, aes(x = year, y = Count, group = Response, color = Response)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1000)) +
  labs(title = "Fehire Responses Over Time",
       x = "Year",
       y = "Count",
       color = "Response Category") +
  theme_minimal()

# discaffw line graph
ggplot(discaffw_data_long, aes(x = year, y = Count, group = Response, color = Response)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 700)) +
  labs(title = "Discaffw Responses Over Time",
       x = "Year",
       y = "Count",
       color = "Response Category") +
  theme_minimal()