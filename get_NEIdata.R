## =============================================================================
## Function:	getNEI_data.R function()
## -----------------------------------------------------------------------------
## Assignment Requirements:

getNEIdata <- function() {
	# Set working directory
	setwd("~/ExData_Plotting2")

	# Test to see if zip file is already present
	
	if !"NEI_data.zip" %in% dir()
	# Download and unzip data file
	download.file("https://d396qusza40orc.cloudfront.net/exdata/data/NEI_data.zip?",
		  "NEI_data.zip", method="curl", quiet=TRUE)

	unzip("NEI_data.zip")
}
