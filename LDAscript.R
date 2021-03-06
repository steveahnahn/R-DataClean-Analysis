#LDA - Supervised learning - based on the DV's classes
dataset <- read.csv("Wine.csv")


#Split data into training and test
library(caTools)
set.seed(123)
split <- sample.split(dataset$Customer_Segment, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

#Feature scaling
training_set[-14] = scale(training_set[-14])
test_set[-14] = scale(test_set[-14])


#There will be k-1 linear discriminants where k = classes in the dependent var
#Applying LDA
library(MASS)
lda <- lda(formula = Customer_Segment ~ .,
           data = training_set)
#PCA predict returns a df but LDA predict returns a matrix
#Convert as svm expects a dataframe
training_set <- as.data.frame(predict(lda, training_set))
training_set <- training_set[c(5,6,1)] #LDA1,LDA2,DV
test_set <- as.data.frame(predict(lda, test_set))
test_set <- test_set[c(5,6,1)] #LDA1,LDA2,DV

library(e1071)
classifier = svm(formula = class ~.,
                 data = training_set,
                 type = 'C-classification',
                 kernal = 'linear')

#Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-3])
y_pred

#Making the Confusion Matrix
cm = table(test_set[,3], y_pred)
cm
accuracy <- (cm[1,1] + cm[2,2] + cm[3,3]) / sum(cm)
accuracy

#Visualizing the Training set results
#install.packages('ElemStatLearn')
library(ElemStatLearn)
set = training_set
X1 =  seq(min(set[,1]) - 1, max(set[,1]) +1, by = 0.01)
X2 =  seq(min(set[,2]) - 1, max(set[,2]) +1, by = 0.01)
grid_set = expand.grid(X1,X2)
colnames(grid_set) = c('x.LD1', 'x.LD2')
y_grid = predict(classifier, newdata = grid_set)
plot(set[,3],
     main = 'SVM (Training Set)',
     xlab = 'LDA1', ylab = 'LDA2',
     xlim = range(X1), ylim = range(X2))
contour(X1,X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid ==2, 'deepskyblue', 
                                         ifelse(y_grid == 1, 'springgreen3', 'tomato')))
points(set, pch = 21, bg = ifelse(set[,3] ==2, 'blue3', ifelse(set[,3] == 1, 'green4', 'red3')))



