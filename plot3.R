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

# Create plot3.png
png(file = "plot3.png")
with(electric, plot(date.time,Sub_metering_1,
                         type = "l", xlab = "", ylab= "Energy sub metering"))
with(electric, lines(date.time, Sub_metering_2,col = "red"))
with(electric, lines(date.time, Sub_metering_3,col = "blue"))
legend("topright", col = c("black","red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()