To run the knn, we created a function that partitions the data and optimizes the k value automatically. It then repeats this process a number of times the user specified, and returns the result in the form of a matrix.
```
function(data, num)
{   #Partition the data
    result<-matrix(nrow=num, ncol=2)
    for(i in 1:num){
        n=nrow(data)
        trainIndex=sample(1:n, size=round(0.6*n),replace=FALSE)
        train=data[trainIndex,]
        notTrain=data[-trainIndex,]
        n=nrow(notTrain)
        validationIndex=sample(1:n, size=round(0.5*n),replace=FALSE)
        validation=notTrain[validationIndex,]
        test=notTrain[-validationIndex,]
        
        trctrl<-trainControl(method='repeatedcv', number=10, repeats=3)
        knnFit<-train(as.factor(income)~., data=train, method='knn', 
        trControl=trctrl, tuneLength=10)
        #extract the k value
        temp<-knnFit$bestTune
        result[i,1]<-temp$k
        #combine the train and validation
        train<-rbind(train, validation)
        #obtain future metric
        knn<-knn(train, test, cl=train$income, k=temp$k)
        temp<-table(knn, test$income)
        #calculate accuracy
        acc<-(temp[1,1]+temp[2,2])/sum(temp)
        result[i,2]<-acc
    }
    return(result)
}
```
Here are the results of that function.
```
> result<-knnResult(na.exclude(adult), 10)
> result
         k       Acc
 [1,]   19 0.7889939
 [2,]   21 0.7826952
 [3,]   17 0.7903199
 [4,]   19 0.7966186
 [5,]   23 0.7802089
 [6,]   19 0.7976131
 [7,]   23 0.7894911
 [8,]   23 0.8060666
 [9,]   19 0.7966186
[10,]   23 0.7845185

> mean(result[,2])
[1] 0.7913144
> sd(result[,2])
[1] 0.007937802
```
Here is a sample confusion matrix obtained using this method.
```
knn             Pred: <50k Pred: >=50k
  Actual: <50k        4450        1131
  Actual: >=50k         98         354
```

We then ran kNN with the data partitioned to account for class bias. We did this by preserving the ratio of income brackets across train, test, and validation.

```

function(data, num)
{   #Partition the data
    result<-matrix(nrow=num, ncol=2)
    for(i in 1:num){
        input_ones <- data[which(data$income == 1),]
        input_twos <- data[which(data$income == 2),]
        input_ones_training_rows <- sample(1:nrow(input_ones), 
        0.6*nrow(input_ones))
        input_twos_training_rows <- sample(1:nrow(input_twos), 
        0.6*nrow(input_twos))
        training_ones <- input_ones[input_ones_training_rows, ]
        training_twos <- input_twos[input_twos_training_rows, ]
        train <- rbind(training_ones, training_twos)
        
        temp_ones <- input_ones[-input_ones_training_rows, ]
        temp_twos <- input_twos[-input_ones_training_rows, ]
        test_ones_rows <- sample(1:nrow(temp_ones), 0.5*nrow(temp_ones))
        test_twos_rows <- sample(1:nrow(temp_twos), 0.5*nrow(temp_twos))
        test_ones <- temp_ones[test_ones_rows, ]
        test_twos <- temp_twos[test_twos_rows, ]
        
        valid_ones <- temp_ones[-test_ones_rows, ]
        valid_twos <- temp_twos[-test_twos_rows, ]
        
        test <- rbind(test_ones, test_twos)
        validation <- rbind(valid_ones, valid_twos)
        
        trctrl<-trainControl(method='repeatedcv', number=10, repeats=3)
        knnFit<-train(as.factor(income)~., data=train, method='knn', 
        trControl=trctrl, tuneLength=10)
        #extract the k value
        temp<-knnFit$bestTune
        result[i,1]<-temp$k
        #combine the train and validation
        train<-rbind(train, validation)
        #obtain future metric
        knn<-knn(train, test, cl=train$income, k=temp$k)
        temp<-table(knn, test$income)
        #calculate accuracy
        acc<-(temp[1,1]+temp[2,2])/sum(temp)
        result[i,2]<-acc
    }
    return(result)
}
```
This is the kNN with the data partitioned to account for class bias.
```
> resultClass <- knnFixClass(adultna, 10)
> resultClass
         k       Acc
 [1,]   19 0.7892727
 [2,]   21 0.7958541
 [3,]   21 0.7928003
 [4,]   19 0.7895871
 [5,]   21 0.7942687
 [6,]   21 0.7906899
 [7,]   19 0.7923743
 [8,]   19 0.7967033
 [9,]   21 0.7930749
[10,]   17 0.7805120
> mean(resultClass[,2])
[1] 0.7915137
> sd(resultClass[,2])
[1] 0.00457826
```
Here is a sample confusion matrix obtained using this method.
```
knn             Pred: <50k Pred: >=50k
  Actual: <50k        4449        1137
  Actual: >=50k         82         372
```
As you can see, the accuracy of the model was unaffected by the data partitioning method, but the standard deviation of the accuracies across multiple iterations was lower with the class bias partitioning method. This suggests that the model will be more consistently close to the average accuracy.
