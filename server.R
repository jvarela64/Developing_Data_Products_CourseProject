#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# This shiny application takes the mtCars dataset and makes a linear model
# between the selected variables
# On the output side, it will print and plot the model

data("mtcars")

shinyServer(
    function(input, output) {
        # Calculate the model in a function, making the values into text 
        # and converting to a formula
        reactiveCalc = reactive({
                y = input$outcome
                x = paste(input$predictors, collapse = "+")
                form=paste(y,"~", x)
                model=(lm(as.formula(form), data = mtcars))
                list(model, form)
        })
        output$printedOutput = renderPrint({
            modelAndForm = reactiveCalc()
            print(paste("Formula = ", modelAndForm[2]))
            print(summary(modelAndForm[[1]]))
        })
        output$ModelPlot = renderPlot({
            modelAndForm = reactiveCalc()
            model = modelAndForm[[1]]
            plot(model$residuals ~ model$fitted.values, xlab = paste("Fitted Values -", 
                                                                     input$outcome), 
                 ylab = "Residuals", main = "Plot of Calculations")
            lines(c(0,max(model$fitted.values)), c(0,0))
        })
        }
)