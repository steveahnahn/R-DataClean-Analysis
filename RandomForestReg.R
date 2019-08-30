dataset <- read.csv('Position_Salaries.csv')
dataset <- dataset[,2:3]

#Do not need to do feature scaling as decision tree regressor is not based on Euclidian Distance but rather conditions
library(rpart)
regressor <- rpart(formula = Salary ~., data = dataset, control =rpart.control(minsplit = 1))
y_pred = predict(regressor, data.frame(Level = 6.5))
y_pred

#Visualize
library(ggplot2)
#Make x-lim sequenced to make it discrete and portrays a clearer visualization for decision tree intervals
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)

ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary), color = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))), color = 'blue')+
  ggtitle("Decision Tree Regressor")
  

#If a new value were to fall into our separated decision tree interval, we would use the average of the interval group
#New prediction after adjustment
y_pred1 = predict(regressor, data.frame(Level = 6.5))
y_pred1


####
#Random Forest Regression

#Fitting Random Forest to our Regression
install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor_rf <- randomForest(x = dataset[1], y = dataset$Salary, ntree = 500) #500 trees

y_pred_rf <- predict(regressor_rf, data.frame(Level = 6.5))
y_pred_rf

x_grid1 = seq(min(dataset$Level), max(dataset$Level), 0.01)

#Visualize
ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary), color = 'red') + 
  geom_line(aes(x = x_grid1, y = predict(regressor_rf, newdata = data.frame(Level = x_grid1))), color = 'blue') +
  ggtitle("Random Forest Regression Ensemble-L")
