
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
        knnFit<-train(as.factor(income)~., data=train, method='knn', trControl=trctrl, tuneLength=10)
        #extract the k value
        temp<-knnFit$bestTune
        result[i,1]<-temp$k
        #run the knn
        #train<-train[-c(15)]
        knn<-knn(train, validation, cl=train$income)
        #table(knn, validation$party)
        #combine the train and validation
        train<-rbind(train, validation)
        #obtain future metric
        knn<-knn(train, test, cl=train$income)
        temp<-table(knn, test$income)
        #calculate accuracy
        acc<-(temp[1,1]+temp[2,2])/sum(temp)
        result[i,2]<-acc
    }
    return(result)
}

> result<-knnResult(na.exclude(adult), 10)
> result
      [,1]      [,2]
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
```

We then ran kNN with the data partitioned to account for class bias. We did this by preserving the ratio of income brackets across train, test, and validation.

```

function(data, num)
{   #Partition the data
    result<-matrix(nrow=num, ncol=2)
    for(i in 1:num){
        input_ones <- data[which(data$income == 1),]
        input_twos <- data[which(data$income == 2),]
        input_ones_training_rows <- sample(1:nrow(input_ones), 0.6*nrow(input_ones))
        input_twos_training_rows <- sample(1:nrow(input_twos), 0.6*nrow(input_twos))
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
        knnFit<-train(as.factor(income)~., data=train, method='knn', trControl=trctrl, tuneLength=10)
        #extract the k value
        temp<-knnFit$bestTune
        result[i,1]<-temp$k
        #run the knn
        #train<-train[-c(15)]
        knn<-knn(train, validation, cl=train$income)
        #table(knn, validation$party)
        #combine the train and validation
        train<-rbind(train, validation)
        #obtain future metric
        knn<-knn(train, test, cl=train$income)
        temp<-table(knn, test$income)
        #calculate accuracy
        acc<-(temp[1,1]+temp[2,2])/sum(temp)
        result[i,2]<-acc
    }
    return(result)
}

This is the kNN with the data partitioned to account for class bias.
> incomeKnn(na.exclude(income), 10)
      [,1]      [,2]
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
```

![K-NN Accuracy Graph](https://austinatchley1.github.io/Data-Science-Team-Project/Visualization/AccuracyOfKNN.png)
