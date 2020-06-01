#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Diabetes Forecast"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("pregnancies", "Pregnancies", 0, min=0, max=20, step=1),
            numericInput("bmi", "BMI", 0, min=0, max=20, step=1),
            numericInput("glucose", "Glucose", 0),
            numericInput("bp", "bloodpressure", 0),
            numericInput("age", "Age", 0)
        ),

        mainPanel(tableOutput("prediction"))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$prediction <- renderTable({
        library(tidyverse) 
        library(class)  
        
        # read in data
        data = read_csv("diabetes.csv")
        
        # remove the two columns with many 0s and filter for non 0s in the others
        data = data %>% select(-c(SkinThickness, Insulin, DiabetesPedigreeFunction)) %>% filter(Glucose != 0 & BMI != 0 & BloodPressure != 0)
        
        # split the data 70/30 into training and testing sets
        train = sample(1:nrow(data), nrow(data)*0.7)
        data.train = data[train,]
        data.test = data[-train,]
        
        # break the training and testing sets into outcome and predictors
        ytrain = data.train$Outcome
        xtrain = data.train %>% select(-Outcome)
        ytest = data.test$Outcome
        xtest = data.test %>% select(-Outcome)
        
        # center and scale predictors
        xtrain_scaled = scale(xtrain, center = TRUE, scale = TRUE)
        meanvec = attr(xtrain_scaled,'scaled:center')
        sdvec = attr(xtrain_scaled,'scaled:scale')
        xtest_scaled = scale(xtest, center = meanvec, scale = sdvec)
        
        # err_vec will be a vector to save validation errors
        err_vec = NULL
        kVals = 1:100
        
        # loop through all k values, using LOOCV to find validation errors
        for (i in kVals){ 
            pred.Yval = knn.cv(train=xtrain_scaled, cl=ytrain, k=i)
            err_vec = c(err_vec, mean(pred.Yval!=ytrain)) 
        }
        
        # best k found that minimizes training error
        bestK = max(kVals[err_vec == min(err_vec)])
        
        # fit knn model using bestK
        input_vars = c(input$pregnancies, input$glucose, input$bp, input$bmi, input$age)
        pred.ytest = knn(train=xtrain_scaled, test=input_vars, cl=ytrain, k=bestK)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
