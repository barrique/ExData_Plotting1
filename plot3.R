# set working directory to source location and print it out
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
print(getwd())

# set the local date format (among other things) to English
Sys.setlocale("LC_TIME", "C")

# read data
data_location <- "./household_power_consumption.txt"
colTypes <- c(rep("character",2),rep("numeric",7))

system.time(dataset <- read.table(data_location, header = T, sep = ";", na.strings="?", colClasses = colTypes))

# filter based on Date
dataset <- dataset[dataset$Date %in% c("1/2/2007","2/2/2007"),]

# convert the two Date and Time columns to a single one named DateTime
dataset <- cbind("DateTime" = as.POSIXct(paste(dataset$Date, dataset$Time), format="%d/%m/%Y %H:%M:%S"), dataset[-c(1,2)])

# create plot and save it to file
png(file = "plot3.png",width = 480, height = 480)

plot(dataset$DateTime,dataset$Sub_metering_1, type="n",main = "", xlab="", ylab="Energy sub metering")
lines(dataset$DateTime,dataset$Sub_metering_1)
lines(dataset$DateTime,dataset$Sub_metering_2, col = "red")
lines(dataset$DateTime,dataset$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
box()

dev.off() 

