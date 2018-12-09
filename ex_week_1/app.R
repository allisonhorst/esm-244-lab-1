library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Pinot Noir Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        radioButtons("radio", label = "Choose State",
                     choices = list("California" = 1, "Oregon" = 2, "Washington" = 3), 
                     selected = 1)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("priceplot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$priceplot <- renderPlot({

      #NOT WORKING: plot subset based on input$radio from ui.R
      ggplot(subset(wine_new, state == input$radio), aes(x = price, y = points)) +
       geom_point() 
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

