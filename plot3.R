## =====================================================================
## Function:	plot3.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Of the four types of sources indicted by the "type" (point, 
#	nonnpoint, onroad, offraod) variable,, which of these four 
#	sources have seen decreases in emissions from 1999 to 2008 for
#	Baltimire City?  Whcih have seen increases in emissions from
#	1999-2008? Use the ggplot2 plotting system to make a plot 
#	answering this question."
#
# Plot is to be saved as png named "plot3.png"
#
## http://www.epa.gov/otaq/standards/basicinfo.htm
## levels(as.factor(SCC$SCC.Level.Three))])

## ---------------------------------------------------------------------
plot3 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from 
	# all sources and I will later subset location to only Baltimore 
	# City, Maryland.
	
	NEI <- readRDS("summarySCC_PM25.rds")

	# subset to just Baltimore City
	baltcity.NEI <- NEI[NEI$fips=="24510",]
	
	# still use tapply() to calculate the sum by year, but this time 
	# I pass a list of indices list(year, type). Rock on!
	
	sumbySource <- tapply(baltcity.NEI$Emissions, 
				    list(baltcity.NEI$year, baltcity.NEI$type), 
				    sum)
	
	
	# open png graphic device
	png(filename = "plot2.png",
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
	paste("File plot3.png created in directory", getwd(), sep=" ")
}