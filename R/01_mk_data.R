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

# Define functions
# ------------------------------------------------------------------------------
cars_to_mess_with = function(x, n = 5){
  messy_cars = x %>% 
    select(car) %>%
    sample_n(n) %>%
    pull
  return(messy_cars)
}

# Create data
# ------------------------------------------------------------------------------
set.seed(281571)

# Create mtcars tibble with rownames
my_mtcars_tibble = mtcars %>%
  rownames_to_column %>%
  as_tibble %>%
  rename(car = rowname)

# Create data list
my_data_list = list(mtcars = mtcars, iris = iris)

# Clean excel sheet, but with multiple sheets
# ------------------------------------------------------------------------------

# Write to file
write.xlsx(x = my_data_list, file = 'data/my_spreadsheet.xlsx')

# Messy excel sheet, but with just one sheet
# ------------------------------------------------------------------------------

# Replace '.' with ',' as decimal separator
my_mtcars_messy = my_mtcars_tibble
messy_cars = cars_to_mess_with(x = my_mtcars_messy)
my_mtcars_messy = my_mtcars_messy %>%
  mutate(mpg = str_replace(mpg, "\\.", ","))

# Add some NAs
messy_cars = cars_to_mess_with(x = my_mtcars_messy)
my_mtcars_messy = my_mtcars_messy %>%
  mutate(hp = ifelse(car %in% messy_cars, NA, hp))

# Add some weird NAs
messy_cars = cars_to_mess_with(x = my_mtcars_messy)
my_mtcars_messy = my_mtcars_messy %>%
  mutate(disp = ifelse(car %in% messy_cars, -99, disp))

# Add quotations marks
my_mtcars_messy = my_mtcars_messy %>%
  mutate(cyl = cyl %>% as.character %>% str_c('"', ., '"'))

# Add some annoying white space
messy_cars = cars_to_mess_with(x = my_mtcars_messy)
my_mtcars_messy = my_mtcars_messy %>%
  mutate(gear = ifelse(car %in% messy_cars, str_c(gear, ' '), gear))

# Write to file
write.xlsx(x = my_mtcars_messy, file = 'data/my_spreadsheet2.xlsx')

# Danish decimal separator
# ------------------------------------------------------------------------------

# Swap decimals
swap_dec_sep = function(x){ return( str_replace(x, "\\.", ",") ) }
my_mtcars_dec = my_mtcars_tibble %>% mutate_if(is.numeric, swap_dec_sep)

# Write to file
write.xlsx(x = my_mtcars_dec, file = 'data/my_spreadsheet3.xlsx')

# Proper mtcars tsv
# ------------------------------------------------------------------------------
mtcars2 = mtcars %>% rownames_to_column %>% as_tibble %>% rename(car = rowname)
write_tsv(x = mtcars2, path = 'data/mtcars2.tsv')
