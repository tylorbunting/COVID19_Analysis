# SETUP ENVIRONMENT -------------------------------------------------------
library("rmarkdown")
library("flexdashboard")
library("plotly")
library("readr")
library("httr")
library("tidyverse")
library("dplyr")
library("lubridate")
library("ggplot2")
library("purrr")
library("RColorBrewer")
library("shiny")
# setup the pandoc environment variable otherwise RScript.exe will break (more info below)
# https://stackoverflow.com/questions/28432607/pandoc-version-1-12-3-or-higher-is-required-and-was-not-found-r-shiny
Sys.setenv(RSTUDIO_PANDOC = "C:/Program Files/RStudio/bin/pandoc")
# setup the file path for the index.Rmd file
index_filepath <- "C:/Users/tbun2893/Documents/GitHub/COVID19_Analysis/index.Rmd"

# 1. UPDATE FLEXDASHBOARD AND GET NEW DATA --------------------------------
writeLines(paste0(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), ": Updating flex dashboard"))
render(input = index_filepath)
