library(lubridate)

setwd("~/prof-dev/JHU-Rprogramming/Exploratory-Analysis/week1")

# read in household electricity consumption data
electricityData <- read.table("./data/household_power_consumption.txt",
                              header = TRUE, sep = ";", dec = ".")


# convert date and time variables to date/time classes
electricityData$DateTime <- strptime(paste(electricityData$Date, 
                                           electricityData$Time), 
                                     format="%d/%m/%Y %H:%M:%S")

electricityData$Date <- as.Date(strptime(electricityData$Date, "%d/%m/%Y"))

# subset data to dates 2007-02-01 and 2007-02-02
electData <- subset(electricityData, 
                    (electricityData$Date == "2007-02-01" |
                       electricityData$Date == "2007-02-02"))


# convert data to numeric and create weekday variable
electData$Global_active_power <- as.numeric(electData$Global_active_power)
electData$Sub_metering_1 <- as.numeric(electData$Sub_metering_1)
electData$Sub_metering_2 <- as.numeric(electData$Sub_metering_2)
electData$Voltage <- as.numeric(electData$Voltage)
electData$Global_reactive_power <- as.numeric(electData$Global_reactive_power)
electData$Day <- wday(electData$DateTime, label=TRUE) 

# adjust margins
par(mfrow = c(2, 2), mar = c(3, 4, 2, 1), oma = c(0, 0, 0, 0))

# plot 1
plot(electData$DateTime,electData$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power")

# plot 2
plot(electData$DateTime,electData$Voltage,
     type = "l", xlab = "", ylab = "Voltage")

# plot 3
plot(electData$DateTime,electData$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(electData$DateTime, electData$Sub_metering_2,
      col = "red", type = "l")
lines(electData$DateTime, electData$Sub_metering_3,
      col = "blue", type = "l")
  # add a legend
legend("topright", 
       legend = c("Sub Meter 1", "Sub Meter 2", "Sub Meter 3"), 
       col = c("black", "red", "blue"),
       lty = 1, cex=0.5)

# plot 4
plot(electData$DateTime,electData$Global_reactive_power,
     type = "l", xlab = "Weekday", ylab = "Global Reactive Power")

# copy as png
dev.copy(png, file = "plot4.png") ## Copy plot to a PNG file
dev.off() ## Close the PNG device!

