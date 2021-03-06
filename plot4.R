####
# calculate a rough estimate of how much memory the dataset will require in memory
#
# 2075259 rows
#       9 columns
#       8 bytes (numeric)
# ------------
# 149418648 bytes / 2^20 (convert to MB)
# ------------
# 142.496 MB approximate memory * 3 for r workspace
#
####

## read data from source file in a ./data subdirectory to the current working directory -- empty entries are using "?"
sourceData <- read.table("./data/household_power_consumption.txt", header = TRUE, na.string = '?', sep=";")

## read data from 2007-02-01 to 2007-02-02 (dates as 1/2/2007 - 2/2/2007 in source file)
powerData <- sourceData[sourceData$Date == '1/2/2007' | sourceData$Date == '2/2/2007', ]

## combine date and time
powerData$dateTime <- strptime(paste(powerData$Date, powerData$Time,sep=' '), "%d/%m/%Y %H:%M:%S")


## set plot layout to 2 charts high by 2 charts wide
## reduce plot text size to regular size to match example
par(mfrow=c(2,2),cex=.625 )


## first plot - Global Active Power
plot(powerData$dateTime,as.numeric(powerData$Global_active_power), type='l', ylab="Global Active Power", xlab="")

## second plot - voltage
plot(powerData$dateTime,as.numeric(powerData$Voltage), type='l', ylab="Voltage", xlab="datetime")


## third plot - Energy sub metering
plot(powerData$dateTime,as.numeric(powerData$Sub_metering_1), type="l", ylab="Energy sub metering", xlab="")

  ## add plot lines
  lines(powerData$dateTime,as.numeric(powerData$Sub_metering_2), col='red')
  lines(powerData$dateTime,as.numeric(powerData$Sub_metering_3), col='blue')

  ## add legend
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c('black','red','blue'), bty = "n", cex=1, lty=1,lwd=1.5)

## forth plot - Global_reactive_power
plot(powerData$dateTime,as.numeric(powerData$Global_reactive_power), type='l', ylab="Global_reactive_power", xlab="datetime")


## copy plot to .png file in current working directory
dev.copy(png,"plot4.png", width=480, height=480)

## close plot device
dev.off()