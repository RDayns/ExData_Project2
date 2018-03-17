#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Emissions from motor vehicle sources 
vehicles  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

#Get data on Baltimore City only
baltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
baltimoreNEI$city <- "Baltimore City, MD"

#Get data on Los Angeles only
losAngelesNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
losAngelesNEI$city <- "Los Angeles, CA"

#Merge Baltimore and Los Angeles data
dataNEI <- rbind(baltimoreNEI, losAngelesNEI)

#Plot and save in PNG format
png("plot6.png",width=640,height=480,units="px")

library(ggplot2)

g <- ggplot(dataNEI , aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity", width=0.75) +
    facet_grid( .~city) +
    guides(fill=FALSE) + theme_grey() +
    labs(x="year", y=expression("Total PM2.5 Emission (in tons)")) + 
    labs(title=expression("PM2.5 Emissions from Motor Vehicle Sources in Baltimore City,MD and Los Angeles,CA (1999-2008)"))

print(g)
dev.off()



