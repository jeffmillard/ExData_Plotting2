## =====================================================================
## Function:	plot4.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Have total emissions from PM2.5 decreased in the Baltimore City, 
#	Maryland (fips=="24510" from 1999 to 2008? Use the base plotting 
#	system to make a plot answering this question."
#
# Plot is to be saved as png named "plot2.png"
#
## ---------------------------------------------------------------------
plot4 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from 
	# all sources and I will later subset location to only Baltimore 
	# City, Maryland.
	
	NEI <- readRDS("summarySCC_PM25.rds")

	# subset to just Baltimore City
	baltcity.NEI <- NEI[NEI$fips=="24510",]
	
	# use tapply to calculate the sum by year
	sumbyYear <- tapply(baltcity.NEI$Emissions, 
				   baltcity.NEI$year, sum)
	
	# open png graphic device
	png(filename = "plot4.png",
	    width = 640, height = 480, units = "px",
	    bg = "white",  type = "quartz")

	# base system xy plot
	plot(names(sumbyYear), sumbyYear, type='b', col="purple",
	     main="Baltimore City, Maryland Annual PM2.5 Emissions",
	     pch=15, xlab="Year", ylab="Emissions (tons)")	
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot4.png created in directory", getwd(), sep=" ")
}