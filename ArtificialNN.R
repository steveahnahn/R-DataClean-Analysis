#Artificial Neural Network
#Classification problem

#Import the dataset
dataset <- read.csv("Churn_modelling.csv")
dataset <- dataset[,4:14]

#Encoding the target feature as factor
#The target variable is already a categorical variable with a binary outcome
#Take care of other categorical variables as factors
#ANN requires a numeric factor
dataset$Geography = as.numeric(factor(dataset$Geography, 
                                      levels = c("France", "Spain", "Germany"), 
                                      labels = c(1,2,3)))
dataset$Gender = as.numeric(factor(dataset$Gender, 
                                   level = c("Male", "Female"), 
                                   labels = c(1,2)))

#splitting the dataset into Training & Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


#Feature Scaling - a must have for computational efficiency
training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])


#Fitting ANN to the Training Set
#H20 package is an open source software platform that allows you to connect
#to an instance of a computer system for higher efficient computing 
#install.packages("h2o")
library(h2o)
h2o.init(nthreads = -1)
classifier = h2o.deeplearning(y = "Exited", 
                              training_frame = as.h2o(training_set),
                              activation = "Rectifier",
                              hidden = c(6,6),
                              epochs = 100,
                              train_samples_per_iteration = -2)

#Predicting the test set results
prob_pred = h2o.predict(classifier, newdata = as.h2o(test_set[-11]))
y_pred = (prob_pred>0.5)
y_pred = as.vector(y_pred)

#Making the Confusion Matrix
cm = table(test_set[,11], y_pred)
accuracy <- (cm[1,1] + cm[2,2]) / sum(cm)
accuracy


h2o.shutdown()
