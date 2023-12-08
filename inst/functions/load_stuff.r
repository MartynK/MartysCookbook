# This file is for loading the relevant libraries & functions
# (decided to put them into a separate file to save space)

require(dplyr)   # must have due to pipes
require(knitr)   # table formatting
require(ggplot2) # plots
require(readxl)  # for data wrangling
require(labelled) # labells for data, see : # https://raw.githubusercontent.com/rstudio/cheatsheets/main/labelled.pdf
require(lubridate) # date stufff
require(huxtable)  # for default martys table style
require(effects)
require(emmeans)
require(kableExtra) # more elaborate table stuff (must have)
require(gtsummary) # table stuff, *the* package for crosstabs
require(nlme)
require(splines)
require(DHARMa) # cool model diagnostic tool

source_all_files <- function(directory) {
  file_paths <- list.files(directory, pattern = "\\.[rR]$", full.names = TRUE)
  
  for (file_path in file_paths) {
    source(file_path)
  }
}

source_all_files(here::here("R"))


## Importing the custom functions
#source( here::here( "inst", "functions", "functions.r"))
