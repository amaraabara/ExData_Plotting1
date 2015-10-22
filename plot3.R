setwd("~/Dropbox/Data_Science/Coursera/EDA/Project1")

file <- fread("household_power_consumption.txt", 
              sep = ";", na.strings = c("?", ""))

file1 <- as.data.frame(file)

# converting the date variable into date format
file1$Date <- as.Date(file1$Date, format = "%d/%m/%Y")


# pasting the date and time variables together
file1$timetemp <- paste(file1$Date, file1$Time)


# converting the date and time variable into POSIXct 
library(lubridate)
file1$Time <- ymd_hms(file1$timetemp, truncated = 3)


# filtering out data for relevant dates
library(dplyr)
power.data <- filter(file1, Time > "2007-01-31 23:59:00" & 
                             Time < "2007-02-03 00:00:00")


# Plot3
plot(power.data$Sub_metering_1 ~ power.data$Time, type = "l",
     ylab = "Energy sub meeting", xlab = " ")
lines(power.data$Sub_metering_2 ~ power.data$Time, col = "red")
lines(power.data$Sub_metering_3 ~ power.data$Time, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), cex = 0.5, 
       lty=c(1,1,1), col= c("black", "red", "blue"), text.font = 2)


# Saving the plot to a png device
dev.copy(device = png, filename = "plot3.png", width = 480, height = 480) 
dev.off()
