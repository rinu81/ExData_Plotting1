# Reading the text file
filename = "~/datasciencecoursera/household_power_consumption.txt"
column_names <- names(read.table(filename, header = TRUE,sep = ";", nrow = 1 ))
power_consumption <- read.table(filename,sep = ";",na.strings = "?",
                        stringsAsFactors = FALSE,
                        col.names = column_names,
                        skip = grep("^[1,2]/2/2007", readLines(filename))-1,nrow = 2879)
active_power <- as.numeric(na.omit(power_consumption$Global_active_power))

# Generating the plot and sending it to the file device
png("plot1.png", height = 480, width = 480)
hist(active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
