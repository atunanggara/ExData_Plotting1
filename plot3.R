# I used the power of sql using sqldf library
# here, I read the .txt file, then have an sql command where I subsetted
# the data for the first and second February of 2007. Since I know it's 
# dd/mm/yyyy format, I put 1/2/2007 and 2/2/2007 as the date that I want.
# I also saw in the .txt that the separation between each column is by a semicolon

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
png("plot3.png",width=480,heigh=480)
# Since I want to have multiple datapoints in one plot, I used the function with, 
# First, I created the frame of the graph, where the key here is to put type = "n" 
# to initialize the plot, without plotting the data
with(dataset,plot(changetoTime,Sub_metering_1,type="n"))
# Here I created the sub_metering_1 line, with black color
with(dataset,points(changetoTime,Sub_metering_1,col="black",type="l"))
# Same with above, but created the sub_metering_2 line, with red color
with(dataset,points(changetoTime,Sub_metering_2,col="red",type="l"))
# Finally, I created the sub_metering_3 lines, with blue color
with(dataset,points(changetoTime,Sub_metering_3,col="blue",type="l"))
# I then specify the legend. Put the position into top right hand corner of 
# the plot, I used line type (lty) to be 1, as in straight line
# I specified the color of each lines and I specify what the color correspond to
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
