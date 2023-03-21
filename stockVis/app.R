# Load packages ----
library(shiny)
library(quantmod)

# Source helpers ----
source("helpers.R")

## Look up stock symbols here
#https://finance.yahoo.com/lookup/?guccounter=1&guce_referrer=aHR0cHM6Ly9zaGlueS5yc3R1ZGlvLmNvbS8&guce_referrer_sig=AQAAADWbK86kF2LncNOf10TcUDnpvKwrOJqU9W-eg4-6gO9kU2JmcHYomOwMy1MS7ulbYu7pYzckprmbYN4bCR4z_DmZGMaKk8y7xp5ATSklfvqQqWFPgSknnNV2lNgxwMuFWQbWCqFD1lb_TOQ9hm_tV3-Fi7Vg_K2OuOcUbJ64NtNK

# User interface ----
ui <- fluidPage(
  titlePanel("stockVis"),

  sidebarLayout(
    sidebarPanel(
      helpText("Select a stock to examine.

        Information will be collected from Yahoo finance."),
      textInput("symb", "Symbol", "SPY"),

      dateRangeInput("dates",
                     "Date range",
                     start = "2013-01-01",
                     end = as.character(Sys.Date())),

      br(),
      br(),

      checkboxInput("log", "Plot y axis on log scale",
                    value = FALSE),

      checkboxInput("adjust",
                    "Adjust prices for inflation", value = FALSE)
    ),

    mainPanel(plotOutput("plot"))
  )
)

# Server logic
server <- function(input, output) {

  #Reactive is an expression that saves the result the first time it runs
  #when renderPlot called, it will call dataInput from above
  #but if the data hasn't changed you don't want to have to load it all from scratch
  #reactive expressions will just return the cashed version. 
  dataInput <- reactive({
    ## getSymbols is a function to download the finance data
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
 # Note: a re-active expression can only be called from within another reactive or render function
  
  finalInput<-reactive({

    ## if adjust for inflation is ticked, then adjust and return that
    if (input$adjust) return (adjust(dataInput()))
    else {dataInput()} #else just give normal data
  })
  
  output$plot <- renderPlot({
    #chartSeries is the function to plot data in a nice manner
    chartSeries(finalInput(), 
                theme = chartTheme("white"),
                type = "line", 
                log.scale = input$log, 
                TA = NULL)
  })

}

# Run the app
shinyApp(ui, server,options=c(launch.browser = .rs.invokeShinyPaneViewer))
