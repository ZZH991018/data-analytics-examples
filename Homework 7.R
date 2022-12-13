library(shiny)
library(plyr)
library(dplyr)
library(readr)
library(ggplot2)
data(mtcars)
data.table::data.table(mtcars)
ui <- fluidPage(
  titlePanel("Histogram of variables in mtcars dataset "),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "variables",
        label = "Select the variables for analysis",
        choices = c(
          "mpg" = 1,
          "qsec" = 2,
          "disp" = 3,
          "wt" = 4)),
      h5("* Click on the button above to select a variable"),
      sliderInput(
        inputId = "bin",
        label ="Select the size of bins",
        min = 5,
        max = 30,
        value = 5),
      h5("* Scroll the button above to select the bin size"),
      radioButtons(
        inputId ="radio",
        label = "Choose the color",
        choices = c("Red", "Blue", "Cyan"),
        select = "Cyan")),
    mainPanel(plotOutput("distPlot"))),
)

server <- function (input, output) {
  
  output$distPlot <- renderPlot({
    colm = as.numeric(input$variables)
    hist(
      mtcars[, colm],
      freq = FALSE,
      col = input$radio,
      xlab = names(mtcars[colm]),
      main = "Histogram of the variable selected",
      breaks = seq(0, max(mtcars[, colm]), l = input$bin + 1))
  }) 
  
}
shinyApp(ui = ui, server = server)
