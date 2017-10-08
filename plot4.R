#!/usr/bin/env Rscript
                                                                                
library(dplyr)

dataFile <- "data/household_power_consumption.txt"

csvData.tbl <- read.csv2(dataFile)
csvData.tbl$Date <- as.Date(strptime(csvData.tbl$Date, format="%d/%m/%Y", "%Y-%m-%d"))
csvData.tbl <- tbl_df(csvData.tbl)
febr0102.tbl <- csvData.tbl %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

dateTime <- as.POSIXct(paste(febr0102.tbl$Date, febr0102.tbl$Time))
febr0102.tbl <- cbind(febr0102.tbl, dateTime)
febr0102.tbl <- tbl_df(febr0102.tbl)

ndx <- sapply(febr0102.tbl, is.factor)
febr0102.tbl[ndx] <- lapply(febr0102.tbl[ndx], function(x) as.numeric(as.character(x)))

# Open PNG graphics device
# Create plot 1
# Create empty plot
# Fill plot with data points connected via lines

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(febr0102.tbl$dateTime, febr0102.tbl$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
points(febr0102.tbl$dateTime, febr0102.tbl$Global_active_power, type="l")

# Create plot 2
# Create empty plot
# Fill plot with data points connected via lines
# Close PNG graphics device

plot(febr0102.tbl$dateTime, febr0102.tbl$Voltage, type="n", xlab="datetime", ylab="Voltage")
points(febr0102.tbl$dateTime, febr0102.tbl$Voltage, type="l")

# Create plot 3
# Create empty plot
# Fill plot with data points connected via lines
# Close PNG graphics device

plot(febr0102.tbl$dateTime, febr0102.tbl$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(febr0102.tbl$dateTime, febr0102.tbl$Sub_metering_1, type="l")
points(febr0102.tbl$dateTime, febr0102.tbl$Sub_metering_2, type="l", col="red")
points(febr0102.tbl$dateTime, febr0102.tbl$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

# Create plot 1
# Create empty plot
# Fill plot with data points connected via lines
# Close PNG graphics device

plot(febr0102.tbl$dateTime, febr0102.tbl$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
points(febr0102.tbl$dateTime, febr0102.tbl$Global_reactive_power, type="l")
dev.off()
