# Reading file
filename = "~/datasciencecoursera/household_power_consumption.txt"
column_names <- names(read.table(filename, header = TRUE,sep = ";", nrow = 1 ))
power_consumption <- read.table(filename,sep = ";",na.strings = "?",
                                stringsAsFactors = FALSE,
                                col.names = column_names,
                                skip = grep("^[1,2]/2/2007", readLines(filename))-1,nrow = 2879)
active_power <- as.numeric(power_consumption$Global_active_power)

# Formatting date and time
power_consumption$Date <- paste(power_consumption$Date, power_consumption$Time, sep =" ")
power_consumption$Date <- strptime(power_consumption$Date, "%d/%m/%Y %H:%M:%S")

# Generating the plot
png("plot2.png", height = 480, width = 480)
plot(power_consumption$Date, active_power, 
     type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
