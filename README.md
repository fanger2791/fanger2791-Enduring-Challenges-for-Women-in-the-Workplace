# Evolving Dynamics: The U.S. Labor Force from 1972 to 2022: The Enduring Challenges for Women in the Workplace

## Overview

This paper analyzes data aquired from the U.S. General Social Survey (GSS) from 1972 through 2022
that investigates the evolving dynamics of the U.S. labor force, with a particular focus on women's experiences in the workplaces. The paper will highlight the strides made towards gender equality in the workplace over the years, yet points to the deep-rooted barriers that remain, offering insights into the diversity of women's experiences within the workforce.

## File Structure

The repo is structured as:

- data contains the cleaned dataset that was constructed and data sources used in analysis including the raw data
- paper contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
- scripts contains the R scripts used to simulate, download, and clean data.

## How to Run and Reproduce

1. Run `scripts/download_data.R` to download the raw data. It will state that downloading the Raw data must be done through GSS and must be tabulated using the variables stated in the paper. The link to the GSS can be found at this URL:

https://gss.norc.org/Get-The-Data

2. Run `scripts/simulate_data.R` to simulate what the data could look like
3. Run `scripts/test_data.R` to test the data
4. Run `scripts/data_cleaning.R` to generate the clean data
5. Run `/paper/paper.qmd` and render the quarto file to see the pdf


## Statement on LLM usage

LLMS were not used in this paper's writing, research, or computational aspects.
