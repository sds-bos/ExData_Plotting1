library(utils)
library(dplyr)
library(lubridate)

unzip("exdata-data-household_power_consumption.zip")
powerdf<-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = TRUE) %>%
  tbl_df %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  mutate(datetime = as.POSIXct(Time, origin = Date, tz = "GMT"))

png("plot3.png")
with(powerdf, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
with(powerdf, plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(powerdf, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(powerdf, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()