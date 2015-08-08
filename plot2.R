library(utils)
library(dplyr)
library(lubridate)

unzip("exdata-data-household_power_consumption.zip")
powerdf<-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = TRUE) %>%
  tbl_df %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  mutate(datetime = as.POSIXct(Time, origin = Date, tz = "GMT"))

png("plot2.png")
with(powerdf, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()