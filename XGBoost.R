#XGBoost predicit if customer leaves the bank in the next 6 months based on customer features
#High Performance
#Fast Execution Speed
#Keep all interpretations due to feature scaling being unnecessary
dataset <- read.csv("Churn_Modelling.csv")
dataset = dataset[4:14]


#Encoding the categorical variables as factors
dataset$Geography = as.numeric(factor(dataset$Geography, 
                                      levels = c('France', 'Spain', 'Germany'),
                                      labels = c(1,2,3)))
dataset$Gender = as.numeric(factor(dataset$Gender, 
                                      levels = c('Male', 'Female'),
                                      labels = c(1,2)))

#Split data into training and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


#Fitting XGBoost to the Training Set
#install.packages('xgboost')
library(xgboost)
classifier = xgboost(data = as.matrix(training_set[-11]),
                     label = training_set$Exited,
                     nrounds = 1000)

#K-Fold Cross Validation
folds <- createFolds(training_set$Exited, k = 10)
cv <- lapply(folds, function(x) {
  training_fold <- training_set[-x, ]
  test_fold = training_set[x, ]
  classifier = xgboost(data = as.matrix(training_set[-11]),
                       label = training_set$Exited,
                       nrounds = 30)
  y_pred = predict(classifier, newdata = as.matrix(test_fold[-11]))
  y_pred = (y_pred >= 0.5) #changing prob into binary outcome
  cm = table(test_fold[,11], y_pred)
  accuracy <- (cm[1,1] + cm[2,2]) / sum(cm)
  return(accuracy)
})


mean(as.numeric(cv))