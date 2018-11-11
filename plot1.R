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

# Create plot1.png
png(file = "plot1.png")
hist(electric$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()