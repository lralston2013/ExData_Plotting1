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


# convert active power data to numeric
electData$Global_active_power <- as.numeric(electData$Global_active_power)

# compose plot 1
hist(electData$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png") ## Copy plot to a PNG file
dev.off() ## Close the PNG device!

