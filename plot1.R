library(dplyr)
library(lubridate)
library(hms)
Sys.setlocale("LC_TIME", "English") 

filepath = "household_power_consumption.txt"

#Read and convert data
data <- read.table(filepath, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = '?')
data <- data %>%
filter(Date ==  '1/2/2007' | Date == '2/2/2007')

data$Date <- dmy(data$Date)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <-   as.numeric(data$Global_reactive_power)
data$Voltage <-   as.numeric(data$Voltage)
data$Global_intensity <-   as.numeric(data$Global_intensity)
data$Sub_metering_1 <-   as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <-   as.numeric(data$Sub_metering_2)

#construct plot and save to file
png('plot1.png', width = 480, height = 480)
hist(data$Global_active_power, 
        col = 'red', 
        ylim = c(0,1200), 
        xlab = 'Global Active Power (kilowatts)',
        main = 'Global Active Power')
dev.off()