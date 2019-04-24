library(class)
library(graphics)
library(caret)
library(InformationValue)

adult <- read.csv("adult_cleaned.csv", header=TRUE)

adult <- adult[-c(1)]
adult <-na.exclude(adult)

n = nrow(adult)

trainIndex = sample(1:n, size = round(0.8*n), replace=FALSE)
train = adult[trainIndex ,]
notTrain = adult[-trainIndex ,]
n = nrow(notTrain)
validationIndex = sample(1:n, size = round(0.5*n), replace=FALSE)
validation = notTrain[validationIndex ,]
test = notTrain[-validationIndex ,]

cl_train<-train$income
train<-train[-c(15)]
cl_test<-test$income
test<-test[-c(15)]
cl_valid<-validation$income
validation<-validation[-c(15)]

missclassificationRate <- c() 

for (k in 1:20) {
  predicted.labels <- knn(train, validation, cl_train, k)
  
  count <- 0
  missRate <- 0
  for (i in 1:nrow(validation)) {
    wrong <- FALSE
    if (predicted.labels[i] != cl_valid[i]) wrong <- TRUE
    count <- count + 1
    if (wrong) missRate <- missRate + 1
  } 
  
  missclassificationRate[k] <- missRate / count
  
}
kValues <- c(1:20)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    min <- input$range[1]
    max <- input$range[2]
    
    switch(input$var,
           "K-NN" = sliderInput("dynamic", "Dynamic",
                                  min = 1, max = 20, value = 20),
           "Logistic Regression" = textInput("dynamic", "Dynamic",
                              value = "starting value"),
           choices = c("K-NN", "Logistic Regression"),
           selected = "K-NN"
    )
    
    if (input$var == "K-NN") {
    #plot accuracy
    plot(1-missclassificationRate[min:max],names.arg=kValues[min:max],xlab="Number of Neighbors",
            ylab="Accuracy",type = "b",col="blue",
            main="Accuracy by Number of Nearest Neighbors")
    }
    
    if (input$var == "Logistic Regression") {
      input_ones <- adult[which(adult$income == 1),]
      input_twos <- adult[which(adult$income == 2),]
      input_ones_training_rows <- sample(1:nrow(input_ones),
                                         0.7*nrow(input_ones))
      input_twos_training_rows <- sample(1:nrow(input_twos),
                                         0.7*nrow(input_twos))
      training_ones <- input_ones[input_ones_training_rows, ]
      training_twos <- input_twos[input_twos_training_rows, ]
      train <- rbind(training_ones, training_twos)

      test_ones <- input_ones[-input_ones_training_rows, ]
      test_twos <- input_twos[-input_ones_training_rows, ]

      test <- rbind(test_ones, test_twos)
      
      train$income <- train$income / 2
      test$income <- test$income / 2
      
      logitMod <- glm(income ~ age + workclass + fnlwgt + education.num + 
                        marital.status + occupation + relationship + race + sex + 
                        capital.gain + capital.loss + hours.per.week + native.country, 
                      data = train, family = binomial(link='logit'))
      
      pred_vals <- predict(logitMod, test, type="response")
      
      optimal <- optimalCutoff(test$income, pred_vals)
      
      plotROC(test$income, pred_vals)
    }
    
  }

  )
  
}
