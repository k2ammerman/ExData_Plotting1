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

## set plot layout to 1 chart high by 1 chart wide
## reduce plot text size to match example
par(mfrow=c(1,1),cex=.75 )

## setup plot
plot(powerData$dateTime,as.numeric(powerData$Sub_metering_1), type="l", ylab="Energy sub metering", xlab="")

## add plot lines
lines(powerData$dateTime,as.numeric(powerData$Sub_metering_2), col='red')
lines(powerData$dateTime,as.numeric(powerData$Sub_metering_3), col='blue')

## add legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c('black','red','blue'),lty=1,lwd=1.5)

## copy plot to .png file in current working directory
dev.copy(png,"plot3.png", width=480, height=480)

## close plot device
dev.off()