#Read data from current working directory
powerdata <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";")
#Create full datetime field by combining date and time fields
FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#Add fulldatetime field to the table 
powerdata <- cbind(powerdata, FullTimeDate)
#Convert date string to Date object
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
#Convert time string to time Object
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
#Convert all strings to numeric values
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

#subset the data for just required 2 days
data2days <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")

#initiate the png graphic device
png("plot2.png", width=480, height=480)
#plot the lineplot to png
with(data2days, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
#turn of the plotting device to save the plot and exit from plotting
dev.off()
