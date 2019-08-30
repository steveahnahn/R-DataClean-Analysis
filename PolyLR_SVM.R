dataset <- read.csv("Position_Salaries.csv")

dataset <- dataset[,2:3]


# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# split
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)
# training_set
# test_set

#follows a exponential function, lin_reg will not fit the model
plot(dataset$Level, dataset$Salary)

lin_reg <- lm(formula = Salary ~., data = dataset)

#Visualizing the regressions
library(ggplot2)

ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary, color = 'red')) + 
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)), colour = 'blue') +
  ggtitle('Truth or Bluff (Linear Regression)') + xlab('Level') + ylab('Salary')


#polynoimal linear regression
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
dataset$Level4 <- dataset$Level^4
poly_reg <- lm(formula = Salary ~., data = dataset)
summary(poly_reg)

#Visualizing the polynomial regression 4th degree
ggplot(dataset, aes(x = Level, y = Salary)) + geom_point(color = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset) )) + 
  ggtitle('Truth or Bluff (Polynomial Regression') + xlab('Level') + ylab('Salary')


#Prediction a new result for each LR
y_pred = predict(lin_reg, data.frame(Level = 6.5))
y_pred
#Pred a new result for PLR
ypoly_pred = predict(poly_reg, data.frame(Level = 6.5, Level2 = 6.5^2, Level3 = 6.5^3, Level4 = 6.5^4))
ypoly_pred


######
#Support Vector Regression
#Goal is to minimize the epilson error for our support vectors

library(e1071) #SVR
regressor_SVM <- svm(formula = Salary ~., 
                 data = dataset, 
                 type = 'eps-regression')

y_pred = predict(regressor_SVM, data.frame(Level = 6.5))
y_pred

#Visualize
ggplot(dataset, aes(x = Level, y = Salary)) + geom_point(color = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor_SVM, newdata = dataset)), color = 'blue') + 
  ggtitle('Truth or Bluff (SVM)') + xlab("Level") + ylab("Salary")




