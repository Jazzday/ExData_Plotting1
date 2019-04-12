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
data$Datetime <- as_datetime(data$Date) + as.hms(data$Time)


#construct plot and save to file
png('plot4.png', width = 480, height = 480)

par(mfrow=c(2,2))

#1
plot(data$Global_active_power ~ data$Datetime, 
     ylab = 'Global Active Power(kilowatts)',
     type = 'l' )

#2
plot(data$Voltage ~ data$Datetime,
     xlab = 'datetime', 
     ylab = 'Voltage', 
     type = 'l')

#3
plot(data$Sub_metering_1 ~data$Datetime,
     ylab = 'Energy sub metering',
     type = 'l')
lines(data$Sub_metering_2 ~data$Datetime, 
      col = 'red') 
lines(data$Sub_metering_3 ~data$Datetime, 
      col = 'blue')
legend("topright" , 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c("black", "red", "blue"), 
       lty = 1)
#4
plot(data$Global_reactive_power ~ data$Datetime,
     xlab = 'datetime', 
     ylab = 'Global_reactive_power', 
     type = 'l')

dev.off()