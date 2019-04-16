###section 1 - Runs at start of program
library(class)

adult <- read.csv("adult_cleaned.csv", header=TRUE)

adult <- adult[-c(1)]
adult <-na.exclude(adult)

n = nrow(adult)
###
trainIndex = sample(1:n, size = round(0.8*n), replace=FALSE)
train = adult[trainIndex ,]
validation = adult[-trainIndex ,]

cl_train<-train$income
train<-train[-c(15)]
cl_valid<-validation$income
validation<-validation[-c(15)]

missclassificationRate <- c() 

#for (k in 1:20) {
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

###section 2
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    min <- input$range[1]
    max <- input$range[2]
    
    barplot(missclassificationRate[min:max],names.arg=kValues[min:max],xlab="Number of Neighbors",
            ylab="Misclassification Rate",col="blue",
            main="Misclassification Rate by Number of Nearest Neighbors",border="black")
    
  }
  
  )
  
}
