#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get data on Baltimore City only
baltimore <- NEI[NEI$fips=="24510",]

# Aggregate the total emissions by year
baltimoreTE <- aggregate(Emissions ~ year,baltimore, sum)


#Plot and save in PNG format
png(file="plot2.png", width = 480, height = 480, units = "px")
barplot(baltimoreTE$Emissions, names.arg=baltimoreTE$year,
        main="Total PM2.5 Emissions in Baltimore City, Maryland by Year",
        xlab="Year",
        ylab="PM2.5 Emissions (in tons)",
        col="blue")
dev.off()
