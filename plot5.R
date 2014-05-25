### Question 5: ###############################################################################
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
###############################################################################################
library(plyr)
library(ggplot2)

filepath <- getwd() #filepath
## Read Data Files

NEI <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "summarySCC_PM25.rds")) 
SCC <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "Source_Classification_Code.rds"))

## Search and subset motor vehicle source related emissions
vehicleSource <- subset(NEI, fips==24510 & type =="ON-ROAD") 

#head(vehicleSource, n=2); table(NEI$type); table(vehicleSource$type)
vehicleEmissionTtl <- aggregate(Emissions ~ year, data=vehicleSource, sum)

png(file="plot5.png", width=600, height=600, bg="white") 
par(mfrow=c(1,1))
barplot(vehicleEmissionTtl$Emissions, names.arg=vehicleEmissionTtl$year, 
        xlab="Year", ylab="PM 2.5 Emissions in Tons", 
        main="Total Motor Vehicle-Related PM 2.5 Emissions in Baltimore, MD")  
dev.off()