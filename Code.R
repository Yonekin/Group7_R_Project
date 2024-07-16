# Load necessary libraries
library(dplyr)
library(ggplot2)
library(lubridate)

# Load the data
plant_1_gen <- read.csv("Plant_1_Generation_Data.csv")
plant_2_gen <- read.csv("Plant_2_Generation_Data.csv")
plant_1_weather <- read.csv("Plant_1_Weather_Sensor_Data.csv")
plant_2_weather <- read.csv("Plant_2_Weather_Sensor_Data.csv")

# Convert DATE_TIME to POSIXct for proper datetime handling
plant_1_gen$DATE_TIME <- dmy_hm(plant_1_gen$DATE_TIME)
plant_2_gen$DATE_TIME <- ymd_hms(plant_2_gen$DATE_TIME)
plant_1_weather$DATE_TIME <- ymd_hms(plant_1_weather$DATE_TIME)
plant_2_weather$DATE_TIME <- ymd_hms(plant_2_weather$DATE_TIME)

# Check for missing values
missing_values_plant_1_gen <- sum(is.na(plant_1_gen))
missing_values_plant_2_gen <- sum(is.na(plant_2_gen))
missing_values_plant_1_weather <- sum(is.na(plant_1_weather))
missing_values_plant_2_weather <- sum(is.na(plant_2_weather))

cat("Missing values in Plant 1 Generation Data: ", missing_values_plant_1_gen, "\n")
cat("Missing values in Plant 2 Generation Data: ", missing_values_plant_2_gen, "\n")
cat("Missing values in Plant 1 Weather Data: ", missing_values_plant_1_weather, "\n")
cat("Missing values in Plant 2 Weather Data: ", missing_values_plant_2_weather, "\n")

# Check for duplicate entries
duplicate_plant_1_gen <- sum(duplicated(plant_1_gen))
duplicate_plant_2_gen <- sum(duplicated(plant_2_gen))
duplicate_plant_1_weather <- sum(duplicated(plant_1_weather))
duplicate_plant_2_weather <- sum(duplicated(plant_2_weather))

cat("Duplicate entries in Plant 1 Generation Data: ", duplicate_plant_1_gen, "\n")
cat("Duplicate entries in Plant 2 Generation Data: ", duplicate_plant_2_gen, "\n")
cat("Duplicate entries in Plant 1 Weather Data: ", duplicate_plant_1_weather, "\n")
cat("Duplicate entries in Plant 2 Weather Data: ", duplicate_plant_2_weather, "\n")

# Integrate the data for each plant by merging on DATE_TIME and PLANT_ID
plant_1_data <- merge(plant_1_gen, plant_1_weather, by=c("DATE_TIME", "PLANT_ID"))
plant_2_data <- merge(plant_2_gen, plant_2_weather, by=c("DATE_TIME", "PLANT_ID"))



# Plot some basic visualizations to understand the data
ggplot(plant_1_data, aes(x=DATE_TIME, y=DC_POWER)) + geom_line() + ggtitle("Plant 1 DC Power Over Time")
ggplot(plant_2_data, aes(x=DATE_TIME, y=DC_POWER)) + geom_line() + ggtitle("Plant 2 DC Power Over Time")
getwd()
