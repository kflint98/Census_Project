
```function(data, num)
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
}```
