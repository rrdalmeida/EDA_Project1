# EDA Project 1

require(sqldf)
require(lubridate)

hpc_data <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", sql = 'select * from file where Date="1/2/2007" or Date="2/2/2007"')

my_pattern <- "([[:digit:]])/([[:digit:]])/"
hpc_data2 <- as.data.frame(lapply(hpc_data, function(x) if(is.character(x)|is.factor(x)) gsub(my_pattern,"0\\1/0\\2/", x) else x))
hpc_data2$datetime = dmy_hms(paste(hpc_data2$Date, hpc_data2$Time))

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))
plot(hpc_data2$datetime, hpc_data2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab ="")

plot(hpc_data2$datetime, hpc_data2$Sub_metering_1, type="l", ylab="Energy sub metering", xlab ="")
lines(x=hpc_data2$datetime, y=hpc_data2$Sub_metering_2, col="red")
lines(x=hpc_data2$datetime, y=hpc_data2$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(hpc_data2$datetime, hpc_data2$Voltage, type="l", ylab="Voltage", xlab ="datetime")
plot(hpc_data2$datetime, hpc_data2$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab ="datetime")

dev.off()
