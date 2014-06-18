## =============================================================================
## Function:	plot2.R function()
## -----------------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following question
#
#	"Have total emissions from PM2.5 decreased in the Baltimore City, 
#	Maryland (fips=="24510" from 1999 to 2008? Use the base plotting system
#	to make a plot answering this question."
#
# Plot is to be saved as png named "plot1.png"
#
## -----------------------------------------------------------------------------
plot2 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from all
	# sources and at all locations.  Note that every entry is for PM2.5
	
	# Useful note, if file is present "summarySCC_PM25.rds" %in% dir() is TRUE
	
	NEI <- readRDS("summarySCC_PM25.rds")
	# SCC <- readRDS("Source_Classification_Code.rds")

	# subset to just Baltimore City
	baltcity.NEI <- NEI[NEI$fips=="24510",]
	
	# use tapply to calculate the sum by year
	meanbyYear <- tapply(baltcity.NEI$Emissions, baltcity.NEI$year, mean)
	
	png(filename = "plot1.png",
	    width = 640, height = 480, units = "px",
	    bg = "white",  type = "quartz")

	plot(names(meanbyYear), meanbyYear, type='b', col="purple",
	     pch=15, main="Baltimore City, Maryland Annual PM2.5 Emissions",
	     xlab="Year", ylab="Emissions (tons)")	
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot2.png created in directory", getwd(), sep=" ")
}