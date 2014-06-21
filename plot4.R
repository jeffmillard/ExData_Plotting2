## =====================================================================
## Function:	plot4.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Across the United States, how have emissions from coal 
#	combustion-related sources changed from 1999–2008?
#	Upload a PNG file containing your plot addressing this question."
#
# Plot is to be saved as png named "plot4.png"
#
## ---------------------------------------------------------------------
plot4 <- function() {
	
	# ----------------------------------------------------------------
	# Read and merge the RDS files
	# ----------------------------------------------------------------
	# Read *_both_* RDS files.
	
	NEI <- readRDS("summarySCC_PM25.rds")
	SCC <- readRDS("Source_Classification_Code.rds")
	
	# Merge the 2 data frames on the SCC code
	merged.DF <- merge(NEI, SCC, by="SCC")
	
	# ----------------------------------------------------------------
	# Select only "coal combustion-related sources"
	# ----------------------------------------------------------------
	#
	# I have chosen to include everything that has "Coal" (with
	# a capital "C") appearing anywhere in the SCC.Level.Three
	# feature, but exclude activities listed as "Coal Mining ..."
	# and "Coal Bed Methane"
	#
	# "Coal Mining" appears to refer to pollutants generated
	# by mining coal, and would include more than coal as fuel
	# sources.
	#
	# "Coal Bed Methane" is a fuel, but it is not coal, so I
	# left that out for that reason.
	#

	coal.DF <- data.frame(merged.DF[grep("Coal", merged.DF$SCC.Level.Three),])

	# I noted that subsetting using grep(... invert=TRUE) was a 
	# more reliable than subsetting using  -grep()
	coal.DF <- coal.DF[(grep("Coal Mining", coal.DF$Short.Name, invert=TRUE)),]
	coal.DF <- coal.DF[(grep("Coal Bed Methane", coal.DF$Short.Name, invert=TRUE)),]
	
	# ----------------------------------------------------------------
	# Summarize data
	# ----------------------------------------------------------------	
	# use melt+tapply to calculate the sum of coal combustion by year
	coalbyYear <- melt(tapply(coal.DF$Emissions, 
				   coal.DF$year, sum))
	names(coalbyYear) <- c("Year", "Emissions")
	
	# ----------------------------------------------------------------
	# Create plot
	# ----------------------------------------------------------------
	# open png graphic device
	png(filename = "plot4.png",
	    width = 640, height = 480, units = "px",
	    type = "quartz")
	
	# ggplot2
	p4 <- ggplot(coalbyYear, aes(Year, Emissions))	
	p4 <- p4 + geom_point(size=4) 
	p4 <- p4 + geom_line()
	p4 <- p4 + labs(title = "Pollutant Emissions from Coal Combustion Related Sources 1999-2008")
	p4 <- p4 + labs(y = "Total Annual Emissions (tons)")
	print(p4)
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot4.png created in directory", getwd(), sep=" ")
}