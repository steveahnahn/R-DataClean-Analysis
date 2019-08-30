dataset <- read.csv("50_Startups.csv")


dataset$State <- factor(dataset$State, levels = c('New York', 'California', 'Florida'), labels = c(1,2,3))

library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
split
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
training_set
test_set

#Fitting Multiple Linear Regression to the Training Set
regressor = lm(formula = Profit ~ ., data = training_set)
summary(regressor)

#Predicting the Test set Results
y_pred = predict(regressor, newdataset = test_set)
y_pred

#Building our model using Backward Elimination
regressor2 <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State, data = dataset) 
summary(regressor2)

regressor3 <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend, data = dataset) 
summary(regressor3)

regressor4 <- lm(formula = Profit ~ R.D.Spend+ Marketing.Spend, data = dataset) 
summary(regressor4)

#The model that contain all significant variables
regressor5 <- lm(formula = Profit ~ R.D.Spend,  data = dataset) 
summary(regressor5)
