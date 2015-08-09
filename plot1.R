# EDA Project 1

require(sqldf)
require(lubridate)

hpc_data <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", sql = 'select * from file where Date="1/2/2007" or Date="2/2/2007"')

my_pattern <- "([[:digit:]])/([[:digit:]])/"
hpc_data2 <- as.data.frame(lapply(hpc_data, function(x) if(is.character(x)|is.factor(x)) gsub(my_pattern,"0\\1/0\\2/", x) else x))

hpc_data2$Date <- dmy(hpc_data2$Date)
hpc_data2$Time <- hms(hpc_data2$Time)

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(hpc_data2$Global_active_power, breaks=12, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
