#### Preamble ####
# Purpose: Simulates US General Sensus Data on Labour Statistics
# Author: David James Dimalanta, Harrison Huang, Michael Fang
# Date: 8 March 2024
# Contact: david.dimalanta@mail.utoronto.ca
# License: MIT
# Pre-requisites: Not Applicable


#### Workspace setup ####
library(tidyverse)


# Set Random Seed for Reproducibility
set.seed(123)


#### Simulate Full-Time Work by Gender US General Sensus Data ####

# set parameters
years <- 1972:2022
low_women <- 100
high_women <- 350

low_men <- 250
high_men <- 600

# Simulate Female data
sim_women_data <-
  tibble(
    sim_women_count =
    runif(n = years, min = low_women, max = high_women),
    noise = rnorm(n = years, mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_women_data, n = 51)

# Simulate Male data
sim_men_data <-
  tibble(
    sim_men_count =
    runif(n = years, min = low_men, max = high_men),
    noise = rnorm(n = years, mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_men_data, n = 51)


#### Simulate Part-Time Work by Gender US General Census Data ####

# set parameters for part-time work
years <- 1972:2022
low_women_pt <- 70
high_women_pt <- 250

low_men_pt <- 40
high_men_pt <- 160

# Simulate Female part-time data
sim_women_pt_data <-
  tibble(
    sim_women_pt_count =
    runif(n = length(years), min = low_women_pt, max = high_women_pt),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_women_pt_data, n = 51)

# Simulate Male part-time data
sim_men_pt_data <-
  tibble(
    sim_men_pt_count =
    runif(n = length(years), min = low_men_pt, max = high_men_pt),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_men_pt_data, n = 51)


#### Simulate Keeping the House Data by Gender US General Census Data ####

# Set parameters for keeping the house
years <- 1972:2022
low_women_kh <- 250
high_women_kh <- 410

low_men_kh <- 5
high_men_kh <- 40

# Simulate Female keeping the house data
sim_women_kh_data <-
  tibble(
    sim_women_kh_count =
    runif(n = length(years), min = low_women_kh, max = high_women_kh),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_women_kh_data, n = 51)

# Simulate Male keeping the house data
sim_men_kh_data <-
  tibble(
    sim_men_kh_count =
    runif(n = length(years), min = low_men_kh, max = high_men_kh),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_men_kh_data, n = 51)

#### Simulate Unemployment Data by Gender US General Census Data ####

# Set parameters for unemployment
years <- 1972:2022
low_men_unemp <- 25
high_men_unemp <- 200

low_women_unemp <- 5
high_women_unemp <- 150

# Simulate Male unemployment data
sim_men_unemp_data <-
  tibble(
    sim_men_unemp_count =
    runif(n = length(years), min = low_men_unemp, max = high_men_unemp),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_men_unemp_data, n = 51)

# Simulate Female unemployment data
sim_women_unemp_data <-
  tibble(
    sim_women_unemp_count =
    runif(n = length(years), min = low_women_unemp, max = high_women_unemp),
    noise = rnorm(n = length(years), mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_women_unemp_data, n = 51)
