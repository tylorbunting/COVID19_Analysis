# SETUP ENVIRONMENT -------------------------------------------------------
# import libraries
library("readr")
library("httr")
library("tidyr")
library("dplyr")
library("lubridate")
library("ggplot2")
library("purrr")

# create functions
Get_Max_Locations <- function(local, data_table) {
  data_table %>%
  filter(Location == local) %>%
  group_by(Location) %>%
  summarise(Count = max(Count))
}





# 1. EXTRACT RAW DATA FROM GITHUB -----------------------------------------
# data sources https://github.com/CSSEGISandData/COVID-19
Data_Co <- read_csv(content(GET("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv")))
Data_Re <- read_csv(content(GET("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv")))
Data_De <- read_csv(content(GET("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv")))



# 2. TRANSFORM DATA -------------------------------------------------------
# mutate all data sources to create Case_Type column
Data_Co <- Data_Co %>%
  mutate(Case_Type = "Confirmed")

Data_Re <- Data_Re %>%
  mutate(Case_Type = "Recovered")

Data_De <- Data_De %>%
  mutate(Case_Type = "Deaths")

# merge all tables
Data <- rbind.data.frame(Data_Co,
                         Data_Re,
                         Data_De)

# transform the data with a gath
Data <- gather(data = Data, key = dates, value = count, -`Province/State`, -`Country/Region`, -Lat, -Long, -Case_Type)

# tramsforms the names of columns
names(Data) <- c("Location", "Country", "Lat", "Long", "Case_Type", "Dates", "Count")

# change the Dates column so that its a date type instead of a character type
Data$Dates <- mdy(Data$Dates)

# change Case_Type so its a factor
Data$Case_Type <- as.factor(Data$Case_Type)




# 3. CREATE FINAL TABLES FOR VISUALISATION --------------------------------
Data_Australia <- Data %>%
  filter(Country == "Australia") %>%
  mutate(Location = if_else(Location == "Queensland", "QLD", 
                            if_else(Location == "New South Wales", "NSW", 
                                    if_else(Location == "Victoria", "VIC",
                                            if_else(Location == "South Australia", "SA",
                                                    if_else(Location == "Western Australia", "WA",
                                                            if_else(Location == "Australian Capital Territory", "ACT",
                                                                    if_else(Location == "From Diamond Princess", "DPC",
                                                                            if_else(Location == "Northern Territory", "NT",
                                                                                    if_else(Location == "Tasmania", "TAS",
                                                                                            Location))))))))))

Data_Australia_Co <- Data_Australia %>%
  filter(Case_Type == "Confirmed")

Data_Australia_Re <- Data_Australia %>%
  filter(Case_Type == "Recovered")

Data_Australia_De <- Data_Australia %>%
  filter(Case_Type == "Deaths")

Data_Australia_Max_Locations_Co <- map_df(unique(Data_Australia_Co$Location), Get_Max_Locations, data_table = Data_Australia_Co)

Data_Australia_Max_Locations_Re <- map_df(unique(Data_Australia_Re$Location), Get_Max_Locations, data_table = Data_Australia_Re)

Data_Australia_Max_Locations_De <- map_df(unique(Data_Australia_De$Location), Get_Max_Locations, data_table = Data_Australia_De)

# CLEAN UP ENVIRONMENT ----------------------------------------------------


