# I used the power of sql using sqldf library
# here, I read the .txt file, then have an sql command where I subsetted
# the data for the first and second February of 2007. Since I know it's 
# dd/mm/yyyy format, I put 1/2/2007 and 2/2/2007 as the date that I want.
# I also saw in the .txt that the separation between each column is by a semicolon
# Therefore, I added the command, sep = ";" 

library(sqldf)
dataset<-read.csv.sql("household_power_consumption.txt",sql="select * from file WHERE Date IN ('1/2/2007','2/2/2007')",sep=";")

# change the date column from character class into date class

changetoDate<-as.Date(dataset$Date,"%d/%m/%Y")
# In order to create the effect as shown in the desired figure, I have to 
# combine the two component: "changetoDate" and the time subset of dataset
# and I specified the format and save it into "changetoTime" variable 
changetoTime<-strptime(paste(changetoDate,dataset$Time),format="%Y-%m-%d %H:%M:%S")
# Now, I open up a png as my graphic devices with 480x480 pixels as specified
# in the assignment. I realized that 480x480 is the default, but it is good 
# practice to specify them, regardless. 
png("plot2.png",width=480,heigh=480)
# Now I used the plot command, where the x axis is changetoTime and the y axis
# is dataset$Global_active_power. I used line type for the plot and I set 
# the y axis label, and keeping the x axis label blank.
plot(changetoTime,dataset$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
# keep in mind I need to close off the graphic device using the command below
dev.off()

