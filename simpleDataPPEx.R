#Data Preprocessing

#Import the Data
dataset <- read.csv("Data.csv")

#Dealing with NA's
dataset$Age = ifelse(is.na(dataset$Age), ave(dataset$Age, 
                                             FUN = function(x) mean(x, na.rm = TRUE)), dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary), ave(dataset$Salary, 
                                                   FUN = function(x) mean(x, na.rm = TRUE)), dataset$Salary)
#Encoding categorical variables
dataset$Country = factor(dataset$Country, levels = c('France', 'Spain', 'Germany'), labels = c(1,2,3))
dataset$Purchased = factor(dataset$Purchased, levels = c('No', 'Yes'), labels = c(0,1))

#Splitting the training and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
split
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
training_set
test_set

#Feature scaling for numeric variables, exclude categorically encoded factors
training_set[,2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])












