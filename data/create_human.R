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

colnames(hd) <- c('HDI_Rank', 'Country', 'HDI', 'LifeExp', 'EduExp', 'EduMean', 'GNI', 'GNI-HDI-RANK')
colnames(gii) <- c('GII.Rank', 'Country', 'GII', 'MatMor', 'AdoBirthRate', 'ParlRep', 'SecEduF', 'SecEduM','LabourF', 'LabourM')


#new education ratio and labour force participation ratio variables 
gii <- gii %>% mutate(EduRatio = SecEduF/SecEduM)
gii <- gii %>% mutate(LabRatio = LabourF/LabourM)


#join the datasets together
library(dplyr)

human <- inner_join(hd, gii, by = c("Country"))
dim(human) 

write.csv(human, file = "./data/human.csv", row.names=FALSE)
