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
png(file = "plot1.png",width = 480, height = 480,)

hist(dataset$Global_active_power, col="Red", main = "Global Active Power", xlab="Global Active Power (kilowatts)", axes = F)
axis(side = 1, at = c(0,2,4,6))
axis(side = 2, at = seq(0,1200,200))

dev.off() 

