#Samuel Tuhkanen, 17.11.2020
#Week 4: Data Wrangling
#Read the “Human development” and “Gender inequality” datas
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# check structure, dimensions and summaries
str(hd)
str(gii)


dim(hd)
dim(gii)

summary(hd)
summary(gii)

# rename variables 

colnames(hd) <- c('HDI_Rank', 'Country', 'HDI', 'Life.Exp', 'Edu.Exp', 'EduMean', 'GNI', 'GNI-HDI-RANK')
colnames(gii) <- c('GII.Rank', 'Country', 'GII', 'Mat.Mor', 'Ado.Birth', 'Parli.F', 'SecEduF', 'SecEduM','LabourF', 'LabourM')


#new education ratio and labour force participation ratio variables 
library(dplyr)

gii <- gii %>% mutate(Edu2.FM = SecEduF/SecEduM)
gii <- gii %>% mutate(Labo.FM = LabourF/LabourM)


#join the datasets together

human <- inner_join(hd, gii, by = c("Country"))
dim(human) 

write.csv(human, file = "./data/human.csv", row.names=FALSE)

#Week 5 

#change GNI to numeric
library(stringr)

human$GNI <- str_replace(human$GNI, pattern=",", replace ="")
human$GNI <- as.numeric(human$GNI)


#exclude unused variables (keep the ones below)
keep <- c('Country', 'Edu2.FM', 'Labo.FM', 'Edu.Exp', 'Life.Exp', 'GNI', 'Mat.Mor', 'Ado.Birth', 'Parli.F')
human <- select(human, one_of(keep))

#exclude rows with missing values
human <- filter(human, complete.cases(human))


#exclude regions (first 155 rows appear to be countries and the rest are not)
human <- human[1:155,]

#rownames by country and remove country as variable
rownames(human) <- human$Country
human <- select(human, -Country)

#save the data (again)
write.csv(human, file = "./data/human.csv", row.names=TRUE)


