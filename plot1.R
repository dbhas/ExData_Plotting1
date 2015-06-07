# plot1.R
# includes function for loading data

if(!exists("data")) (data <- loaddata())

hist(data$Global_active_power, col="red", breaks=12, 
     main="Global Active Power", xlab="Global Active Power (kilowatts)",
     ylab="Frequency", mar=c(0,4,4,0))
dev.copy(png, "plot1.png")
dev.off()




##Loading Data 
loaddata <- function(){
  sourceUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  if(!file.exists("dataset.zip")){
    download.file(sourceUrl,destfile="dataset.zip")
    #    unz("dataset.zip","household_power_consumption.txt")
    #   couldn't figure out how to programmatically unzip 
    #   without loading entire file at this point I did a manual extract
    #   of household_power_consumption.txt into the working directory
    
  }
  
  fileUrl <- "household_power_consumption.txt"
  ## get observations for relevant dates
  library(data.table)
  data <- fread(fileUrl,sep=";",header=TRUE,na.strings="?")
  data[,Date:=as.Date(Date,"%d/%m/%Y")] # convert date column
  data<-data[Date>="2007-02-01" & Date<="2007-02-02"] #subset
  
  ## convert character formats to strings
  data[,Global_active_power:=as.numeric(Global_active_power)]
  data[,Global_reactive_power:=as.numeric(Global_reactive_power)]
  data[,Voltage:=as.numeric(Voltage)]
  data[,Global_intensity:=as.numeric(Global_intensity)]
  data[,Sub_metering_1:=as.numeric(Sub_metering_1)]
  data[,Sub_metering_2:=as.numeric(Sub_metering_2)]
  data[,Sub_metering_3:=as.numeric(Sub_metering_3)]

  return (data)
}