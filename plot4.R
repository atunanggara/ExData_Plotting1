# I used the power of sql using sqldf library
# here, I read the .txt file, then have an sql command where I subsetted
# the data for the first and second February of 2007. Since I know it's 
# dd/mm/yyyy format, I put 1/2/2007 and 2/2/2007 as the date that I want.
# I also saw in the .txt that the separation between each column is by a semicolon

library(sqldf)
dataset<-read.csv.sql("household_power_consumption.txt",sql="select * from file WHERE Date IN ('1/2/2007','2/2/2007')",sep=";")

# change the date column from character class into date class
# I put day, month, and year with Y capitalized, since that symbolizes
# Y being specified with 4 digits (e.g. 2005) rather than 2 digit (e.g. 05)

changetoDate<-as.Date(dataset$Date,"%d/%m/%Y")
# In order to create the effect as shown in the desired figure, I have to 
# combine the two component: "changetoDate" and the time subset of dataset
# and I specified the format and save it into "changetoTime" variable 
changetoTime<-strptime(paste(changetoDate,dataset$Time),format="%Y-%m-%d %H:%M:%S")
# Now, I open up a png as my graphic devices with 480x480 pixels as specified
# in the assignment. I realized that 480x480 is the default, but it is good 
# practice to specify them, regardless. 
png("plot4.png",width=480,heigh=480)
# here I specify that there will be 2 columns and 2 rows of plot in this particular
# plot  
par(mfrow=c(2,2))
# I subsetted each one
with(dataset,{ 
# I copied this one from plot2.R, modified the y label a little bit though 
  plot(changetoTime,dataset$Global_active_power,type="l",ylab="Global Active Power",xlab="")
# This is a new plot. I specified the time as the x axis and Voltage as the y axis
  plot(changetoTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
# This is taken from plot3.R 
  with(dataset,plot(changetoTime,Sub_metering_1,type="n",ylab = "Energy sub metering"))
  with(dataset,points(changetoTime,Sub_metering_1,col="black",type="l"))
  with(dataset,points(changetoTime,Sub_metering_2,col="red",type="l"))
  with(dataset,points(changetoTime,Sub_metering_3,col="blue",type="l"))
# Here the only difference is that I put bty="n" so that there is no boxes in the legend 
# as required by the sample plot
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
# This is a new plot. I specified the time as the x axis and Global_reactive_power
# as the y axis. Put this as a line type. 
    plot(changetoTime,Global_reactive_power,type="l",xlab="datetime")
  })
dev.off()

