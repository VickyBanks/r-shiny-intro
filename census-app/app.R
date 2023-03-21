## reactive widgets need to re-name to app.R to run

library(shiny)
library(UScensus2010)
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("data/counties.rds")

### You can add output objects as well as the input objects like the drop downs or value sliders
# Output function 	Creates
# dataTableOutput 	DataTable
# htmlOutput 	raw HTML
# imageOutput 	image
# plotOutput 	plot
# tableOutput 	table
# textOutput 	text
# uiOutput 	raw HTML
# verbatimTextOutput 	text


ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic map with
                 information from the 2010 US Census"),
      selectInput(
        "var",
        label = ("Choose a variable to display"),
        choices = list(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
        selected = "Percent White"
      )
      ,
      
      sliderInput(
        "range",
        "Range of Interest",
        min = 0,
        max = 100,
        value = c(0, 100)
      )
    ), 
    mainPanel(
      plotOutput("map")
    )
  )
)




# Define server logic ----
server <- function(input, output) {

  ## the UI names "var" and "range" are automatically assigned to "input"
  ## input$var will be one value
  ## input$range will be a vector of both the min value and max value

  output$selected_var <- renderText({
    paste0("You have selected the range ",input$range[1], " to ", input$range[2] )
    
  })
  
  # output$map <- renderPlot({
  #   data <- switch(input$var, 
  #                  "Percent White" = counties$white,
  #                  "Percent Black" = counties$black,
  #                  "Percent Hispanic" = counties$hispanic,
  #                  "Percent Asian" = counties$asian)
  #   colour <- switch(input$var, 
  #                   "Percent White" = "darkgreen",
  #                   "Percent Black" = "black",
  #                   "Percent Hispanic" = "darkorange",
  #                   "Percent Asian" = "darkviolet")
  #   
  #   legend <- switch(input$var, 
  #                    "Percent White" = "% White",
  #                    "Percent Black" = "% Black",
  #                    "Percent Hispanic" = "% Hispanic",
  #                    "Percent Asian" = "% Asian")
  #   
  #   percent_map(var = data, color = colour, legend.title = legend, max = input$range[1], min = input$range[2])
  # })
  
  
  ## to be more concise as countries 
  output$map <- renderPlot({
    args <- switch(input$var,
                   ##label = list(ethnicity, colour pallet, label )
                   "Percent White" = list(counties$white, "darkgreen", "% White"),
                   "Percent Black" = list(counties$black, "black", "% Black"),
                   "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
                   "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))
    
    ## add extra argements from the widget values
    args$min <- input$range[1]
    args$max <- input$range[2]
    
    do.call(percent_map, args)
  })
  
  
}
## You render the object using these functions
## The object should be your desired output, e.g a graph
# render function 	creates
# renderDataTable 	DataTable
# renderImage 	images (saved as a link to a source file)
# renderPlot 	plots
# renderPrint 	any printed output
# renderTable 	data frame, matrix, other table like structures
# renderText 	character strings
# renderUI 	a Shiny tag object or HTML


# Run the app ----
shinyApp(ui = ui, server = server,
         options=c(launch.browser = .rs.invokeShinyPaneViewer))


