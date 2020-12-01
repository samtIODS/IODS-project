#Samuel Tuhkanen, 17.11.2020
#Week 6: Data Wrangling

#load libraries for later use
library(dplyr)
library(tidyr)

#load the datasets
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#save the datasets to the data folder
write.csv(bprs, "./data/bprs.csv", row.names = FALSE)
write.csv(rats, "./data/rats.csv", row.names = FALSE)

# Check the column names
names(bprs)
names(rats)

#Check structures
str(bprs)
str(rats)

#summaries
summary(bprs)
summary(rats)


#convert categorial variables to factors
bprs$treatment <- factor(bprs$treatment)
bprs$subject <- factor(bprs$subject)

rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

#convert data sets to longform
bprsL <-  bprs %>% gather(key = weeks, value = bprs, -treatment, -subject)
ratsL <-  rats %>% gather(key = Day, value = Weight, -ID, -Group)

#create week and time variables
bprsL <-  bprsL %>% mutate(week = as.integer(substr(weeks,5,5)))
ratsL <-  ratsL %>% mutate(Time = as.integer(substr(Day,3,4)))


# look at the data
glimpse(bprsL)
glimpse(bprs)
summary(bprsL)

glimpse(ratsL)
glimpse(rats)
summary(ratsL)

#in the original wide-form dataset each row desribes a single participant/rat with columns for each measurement (i.e each participant/rat has only a single row in the data)
#in the long form on the other hand each row describes a single measurement. For example, in the BPRS data each participant now has 9 rows to describe each measurement

#save the data
write.csv(bprsL, "./data/bprsL.csv", row.names = FALSE)
write.csv(ratsL, "./data/ratsL.csv", row.names = FALSE)

