# Description
# This scripts created various data files used for Nordicdatalab courses

# Clear workspace
# ------------------------------------------------------------------------------
rm(list = ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('readxl')
library('openxlsx')

# Create data
# ------------------------------------------------------------------------------

# Excel sheet
write.xlsx(x = list(mtcars = mtcars, iris = iris),
           file = 'data/my_spreadsheet.xlsx')
