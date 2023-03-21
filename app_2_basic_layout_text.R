## build your own app

library(shiny)

# Define UI ----
ui <- fluidPage( ## fluid automatically adjusts to fit the size of the window
  titlePanel("My Shiny App"),
  
  ## this always takes the sidebar and main panel arguments
  sidebarLayout(
    #position = "right", #to alter the position from default left
    sidebarPanel(
      h2("Installation"),
      p("Shiny is avaibale from CRAN so you can install it in the usual way from your R console:"),
      code('install.packages("shiny")'),
      br(),
      p("Shiny is a product of", span("RStudio", style = "color:blue"))
      
    ),    
    mainPanel(      h1("First level title", align = "center"),
                    h2("Second level title"),
                    h3("Third level title"),
                    h4("Fourth level title", align = "right"),

                    ## add in an image
                    ## image MUST be within the www folder
                    img(src = "maru.png", height = 140, width = 300),
                    
                    p("p creates a paragraph of text."),
                    p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
                    strong("strong() makes bold text."),
                    em("em() creates italicized (i.e, emphasized) text."),
                    br(),
                    code("code displays your text similar to computer code"),
                    div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
                    br(),
                    p("span does the same thing as div, but it works with",
                      span("groups of words", style = "color:blue"),
                      "that appear inside a paragraph.")
              
              ) 
    ## you can use html to make nicer titles such as h2 for header level 2
  )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server,
         options=c(launch.browser = .rs.invokeShinyPaneViewer))





# Useful things:
#   For more layout options in sidebarLayout() https://shiny.rstudio.com/articles/layout-guide.html
#   For looking up html tags http://www.w3schools.com/tags/tag_hn.asp


