#https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/
#install.packages("shiny")
library(shiny)
#runExample("01_hello") ## this is an example file that comes with R

# All shiny apps follow the basic three steps:
#
# * Definition of user interface (UI)
# * Define the server logic that will build the plot in the UI
# * The call to render the app
#
# The app code is normally saved in a file called `app.R`

####### Step 1 #######
# Define UI for app that draws a histogram ----
ui <- fluidPage(# App title ----
                titlePanel("Hello World!"),
                
                # Sidebar layout with input and output definitions ----
                sidebarLayout(# Sidebar panel for inputs ----
                              sidebarPanel(
                                # Input: Slider for the number of bins ----
                                sliderInput(
                                  inputId = "bins",
                                  label = "Number of bins:",
                                  min = 5,
                                  max = 50,
                                  value = 30
                                )
                                
                              ),
                              
                              # Main panel for displaying outputs ----
                              mainPanel(# Output: Histogram ----
                                        plotOutput(outputId = "distPlot"))))

####### Step 2 #######
# Define server logic required to draw a histogram ----
server <- function(input, output) {
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(
      x,
      breaks = bins,
      col = "#007bc2",
      border = "orange",
      xlab = "Waiting time to next eruption (in mins)",
      main = "Histogram of waiting times"
    )
    
  })
  
}

####### Step 3 #######
## Call to build the app
#shinyApp(ui = ui, server = server)
shinyApp(ui = ui, server = server,options=c(launch.browser = .rs.invokeShinyPaneViewer))
# the options part fores it to render in the R window




## You can run your shiny app using a command similar to `read.csv()`
## called runApp("app.R") where you need the file to be in your wd or give it's full path
# runApp("App-1") runs the whole folder
# runApp("App-1",display.mode = "showcase") runs and gives the code below


# ###useful example apps
# runExample("01_hello")      # a histogram
# runExample("02_text")       # tables and data frames
# runExample("03_reactivity") # a reactive expression
# runExample("04_mpg")        # global variables
# runExample("05_sliders")    # slider bars
# runExample("06_tabsets")    # tabbed panels
# runExample("07_widgets")    # help text and submit buttons
# runExample("08_html")       # Shiny app built from HTML
# runExample("09_upload")     # file upload wizard
# runExample("10_download")   # file download wizard
# runExample("11_timer")      # an automated timer




