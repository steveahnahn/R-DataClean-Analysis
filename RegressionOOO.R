#### All regressions order of operations
#Steve Ahn

#Load Libraries and data & PP

#library(caTools)
#dataset <- read.csv("Position_Salaries.csv")
#dataset <- dataset[,2:3] - subset for numericals and hot encode categoricals into factors

#Split
# set.seed(123)
# split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# split
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)
# training_set
# test_set


#Fitting the regression based on data points - slr, mlr, plr
#summary

#Visualize through ggplot
#library(ggplot2)
# ggplot() + 
#   geom_point(aes(x = dataset$Level, y = dataset$Salary, color = 'red')) + 
#   geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)), colour = 'blue') +
#   ggtitle('Truth or Bluff (Linear Regression)') + xlab('Level') + ylab('Salary')

#Predictions 





