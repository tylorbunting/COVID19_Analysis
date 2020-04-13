# source "https://gist.github.com/smithdanielle/9913897"
# check.packages function: install and load multiple R packages.
# Check to see if packages are installed. Install them if they are not, then load them into the R session.
check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# set packages to install
packages<-c("flexdashboard",
                     "plotly",
                     "readr",
                     "httr",
                     "shiny",
                     "tidyr",
                     "dplyr",
                     "lubridate",
                     "tidyverse",
                     "ggplot2",
                     "purrr",
                     "RColorBrewer",
                     "rmarkdown",
                     "git2r",
                     "keyring")
check.packages(packages)
