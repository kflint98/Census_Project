library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("Census income kNN Accuracy Rate by k"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
    
    	selectInput("var", 
        	label = "Choose a classifier to display",
        	choices = c("K-NN","Logistic Regression"),
        	selected = "K-NN"),

        sliderInput(inputId = "range",
                  label = "Range of number of neighbors:",
                  min = 1,
                  max = 20,
                  value = c(1,20))

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot")

    )
  )
)
