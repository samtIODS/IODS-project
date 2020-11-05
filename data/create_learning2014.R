#Samuel Tuhkanen, 4.11.2020
#Week 2: Data Wrangling

library(dplyr)

raw_data <- read.table("./data/JYTOPKYS3-data.txt", sep="\t", header = TRUE)

#structure of data
str(raw_data)
#dimensions
dim(raw_data)

#the dataset contains 163 rows/observations for 60 variables 
#Each row encodes a single student, their age, gender, points, answers to specific questions on the questionaire and attitude (toward statistics?)
#Looking at the data, I'm guessing that the questionnaire was on likert-scale (all values appear to range from 1-5)

#exlude rows where points == 0
analysis_data <- raw_data[!raw_data$Points==0,]


deep_columns <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep <- select(analysis_data, one_of(deep_columns))
deep <- rowMeans(deep)

surf_columns <- c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21","SU29",  "SU08", "SU16", "SU24", "SU32")
surf <- select(analysis_data, one_of(surf_columns))
surf <- rowMeans(surf) 

stra_columns <-  c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")
stra <- select(analysis_data, one_of(stra_columns))
stra <- rowMeans(stra) 

analysis_data$deep <- deep
analysis_data$stra <- stra
analysis_data$surf <- surf
#change capitalization (don't like the inconsistancy), will copy the variables but we'll get rid of the old ones below
#also scale attitude
analysis_data$attitude <- analysis_data$Attitude / 10
analysis_data$points <- analysis_data$Points
analysis_data$gender <- analysis_data$gender
analysis_data$age <- analysis_data$Age

#getting rid of the other variables
vars <- c("age", "gender", "points", "attitude", "deep", "surf", "stra")
analysis_data <- select(analysis_data, one_of(vars))

write.csv(analysis_data, file = "./data/learning2014.csv", row.names=FALSE)

#read data again
data <- read.csv("./data/learning2014.csv",  header = TRUE)

#looks correct
head(data)
str(data)


