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
 [1,]   23 0.6855627
 [2,]   21 0.6961711
 [3,]   21 0.6950108
 [4,]   21 0.7028013
 [5,]   21 0.7044588
 [6,]   23 0.6935190
 [7,]   23 0.6907011
 [8,]   17 0.6963368
 [9,]   23 0.6868888
[10,]   23 0.6951765

> mean(result[,2])
[1] 0.6946627
```
Here is a sample confusion matrix obtained using this method.
```
knn    1    2
  1 4450 1131
  2   98  354
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
> resultClass <- incomeKnn(na.exclude(income), 10)
> resultClass
         k       Acc
 [1,]   21 0.8033904
 [2,]   19 0.7997345
 [3,]   19 0.7978688
 [4,]   23 0.8042398
 [5,]   21 0.8052292
 [6,]   23 0.8054822
 [7,]   21 0.7978706
 [8,]   15 0.8036658
 [9,]   21 0.8003966
[10,]   23 0.8031054

> mean(resultClass[,2])
[1] 0.8020983
```
As you can see, the accuracy of the model increased significantly when the data was partitioned to keep the ratio of income brackets intact across the training, validation, and test sets. We observed an increase of about 10% total accuracy of our knn model due to this change.
