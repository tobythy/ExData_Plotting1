# Load the data
electric <- read.table("household_power_consumption.txt", sep = ";",
                       na.strings = "?", header = TRUE, 
                       colClasses = c("character", "character", "numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric",
                                      "numeric"))

#subset for Feb. 1-2, 2007
date <- grepl("^[1-2]\\/2\\/2007", electric$Date)
electric <- electric[date,]
rownames(electric) <- NULL

# Combine date and time columns
electric$date.time <- paste(electric$Date, electric$Time)

# Convert date.time column to POSIXct
electric$date.time <- as.POSIXct(electric$date.time, format = "%d/%m/%Y %H:%M:%S")

# Create plot 4

png(file = "plot4.png")
par(mfrow = c(2, 2)) 

with(electric, {
    plot(date.time,Global_active_power,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(date.time, Voltage, type = "l")
    plot(date.time,Sub_metering_1,
         type = "l", xlab = "", ylab= "Energy sub metering")
    lines(date.time, Sub_metering_2,col = "red")
    lines(date.time, Sub_metering_3,col = "blue")
    legend("topright", col = c("black","red", "blue"), lty = 1, bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(date.time, Global_reactive_power, type = "l")
})

dev.off() 