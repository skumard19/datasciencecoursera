
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

# construct plot2.png
datetime <- strptime(paste(data_proj$Date, data_proj$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(data_proj$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
