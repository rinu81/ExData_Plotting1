# Reading file
filename = "~/datasciencecoursera/household_power_consumption.txt"
column_names <- names(read.table(filename, header = TRUE,sep = ";", nrow = 1 ))
power_consumption <- read.table(filename,sep = ";",na.strings = "?",
                                stringsAsFactors = FALSE,
                                col.names = column_names,
                                skip = grep("^[1,2]/2/2007", readLines(filename))-1,nrow = 2879)

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
power_consumption$Voltage <- as.numeric(power_consumption$Voltage)
power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)
power_consumption$Global_reactive_power <- as.numeric(power_consumption$Global_reactive_power)

# Formatting date and time
power_consumption$Date <- paste(power_consumption$Date, power_consumption$Time, sep =" ")
power_consumption$Date <- strptime(power_consumption$Date, "%d/%m/%Y %H:%M:%S")

# Generating the plots and sending to the file device
png("plot4.png", height = 480, width = 480)

par(mfrow = c(2,2))
plot(power_consumption$Date, power_consumption$Global_active_power, type = "l",
     xlab="", 
     ylab="Global Active Power (kilowatts)")

plot(power_consumption$Date, power_consumption$Voltage, type = "l",
     xlab="datetime", 
     ylab="Voltage")

plot(power_consumption$Date, power_consumption$Sub_metering_1, 
     type = "l", xlab="", ylab="Energy sub metering", col = "black")
lines(power_consumption$Date, power_consumption$Sub_metering_2, col = "red")
lines(power_consumption$Date, power_consumption$Sub_metering_3, col = "blue")

# Adding legend
legend("topright", lwd = 2, lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")


plot(power_consumption$Date, power_consumption$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()