#Samuel Tuhkanen, 10.11.2020
#Week 3: Data Wrangling
### Data src: https://archive.ics.uci.edu/ml/datasets/Student+Performance

#load dplyr for later use
library(dplyr)

por <- read.csv("./data/student-por.csv", sep = ";" , header=TRUE)
mat <- read.csv("./data/student-mat.csv", sep = ";" , header=TRUE)

#let's check the structure
str(por)
str(mat)
#and the dimensions
dim(por)
dim(mat)

#join datasets
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
joined <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

#check structure and dimensions
str(joined)
dim(joined)


# combine duplicated answers. copied from datacamp (slightly different variable names)
alc <- select(joined, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(joined, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]

  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#average of weekday and weekend alcohol use (going by the datacamp logic - feel like you should weight the use by number of days though)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
#define high use
alc <- mutate(alc, high_use = alc_use > 2)

#taking a glimpse
glimpse(alc)

#save file
write.csv(alc, "./data/alc.csv", row.names=FALSE)
