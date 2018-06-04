
# view current working directory
getwd()

# download the project dataset into current working directory
# read dataset into R filtering for dates 2007-02-01 and 2007-02-02 
library(sqldf)
data_proj <- read.csv.sql("household_power_consumption.txt", 
                          "select * from file where Date in ('1/2/2007','2/2/2007')", 
                          header=TRUE,sep=";",stringsAsFactors=FALSE
)
dim(data_proj) # 2880    9
str(data_proj)
head(data_proj)

# construct plot4.png
datetime            <- strptime(paste(data_proj$Date, data_proj$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower   <- as.numeric(data_proj$Global_active_power)
globalReactivePower <- as.numeric(data_proj$Global_reactive_power)
voltage             <- as.numeric(data_proj$Voltage)
subMetering1        <- as.numeric(data_proj$Sub_metering_1)
subMetering2        <- as.numeric(data_proj$Sub_metering_2)
subMetering3        <- as.numeric(data_proj$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
