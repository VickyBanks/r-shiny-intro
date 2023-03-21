# ## adding widgets
# The standard Shiny widgets are:
#   function 	widget
# actionButton 	Action Button
# checkboxGroupInput 	A group of check boxes
# checkboxInput 	A single check box
# dateInput 	A calendar to aid date selection
# dateRangeInput 	A pair of calendars for selecting a date range
# fileInput 	A file upload control wizard
# helpText 	Help text that can be added to an input form
# numericInput 	A field to enter numbers
# radioButtons 	A set of radio buttons
# selectInput 	A box with choices to select from
# sliderInput 	A slider bar
# submitButton 	A submit button
# textInput 	A field to enter text
# Some of these widgets are built using the Twitter Bootstrap project, a popular open source framework for building user interfaces.


### to quickly see how to build some widgets 
#https://shiny.rstudio.com/gallery/widget-gallery.html


# NOTES:
#   all widgets take a name and then an label. The name is not seen by the user but the label is.


library(shiny)

# # Define UI ---- this gives every possible option
# ui <- fluidPage(
#   titlePanel("My Shiny App"),
#   fluidRow(
#     column(
#       3,
#       h3("Buttons"),
#       actionButton("action", "Action"),
#       br(),
#       br(),
#       submitButton("Submit")
#     ),
#     
#     column(
#       3,
#       h3("Single checkbox"),
#       checkboxInput("checkbox", "Choice A", value = TRUE)
#     ),
#     
#     column(
#       3,
#       checkboxGroupInput(
#         "checkGroup",
#         h3("Checkbox group"),
#         choices = list(
#           "Choice 1" = 1,
#           "Choice 2" = 2,
#           "Choice 3" = 3
#         ),
#         selected = 1
#       )
#     ),
#     
#     column(3,
#            dateInput("date",
#                      h3("Date input"),
#                      value = "2014-01-01"))
#     
#   ),
#   fluidRow(
#     column(3,
#            dateRangeInput("dates", h3("Date range"))),
#     
#     column(3,
#            fileInput("file", h3("File input"))),
#     
#     column(
#       3,
#       h3("Help text"),
#       helpText(
#         "Note: help text isn't a true widget,",
#         "but it provides an easy way to add text to",
#         "accompany other widgets."
#       )
#     ),
#     
#     column(3,
#            numericInput("num",
#                         h3("Numeric input"),
#                         value = 1))
#   ),
#   fluidRow(
#     column(3,
#            radioButtons(
#              "radio",
#              h3("Radio buttons"),
#              choices = list(
#                "Choice 1" = 1,
#                "Choice 2" = 2,
#                "Choice 3" = 3
#              ),
#              selected = 1
#            )),
#     
#     column(3,
#            selectInput(
#              "select",
#              h3("Select box"),
#              choices = list(
#                "Choice 1" = 1,
#                "Choice 2" = 2,
#                "Choice 3" = 3
#              ),
#              selected = 1
#            )),
#     
#     column(
#       3,
#       sliderInput(
#         "slider1",
#         h3("Sliders"),
#         min = 0,
#         max = 100,
#         value = 50
#       ),
#       sliderInput(
#         "slider2",
#         "",
#         min = 0,
#         max = 100,
#         value = c(25, 75)
#       )
#     ),
#     
#     column(3,
#            textInput("text", h3("Text input"),
#                      value = "Enter text..."))
#   )
#   
# )

ui <- fluidPage(
  titlePanel("censusVis"),
  
   sidebarLayout(
     sidebarPanel(
     helpText("Create demographic map with
                 information from the 2010 US Census"),
     selectInput(
       "option_box",
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
       "slider",
       "Range of Interest",
       min = 0,
       max = 100,
       value = c(0, 100)
     )
     ), 
  mainPanel()
  )
)

    


# Define server logic ----
server <- function(input, output) {

}

# Run the app ----
shinyApp(ui = ui, server = server,
         options=c(launch.browser = .rs.invokeShinyPaneViewer))


