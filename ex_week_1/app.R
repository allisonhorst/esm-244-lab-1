library(shiny)
library(tidyverse)

wine <- read_csv("wine_data.csv")

wine_new <- wine %>% 
  select(country, province, winery, region_1, points, price) %>% 
  rename(state = province) %>% 
  filter(state == "California" | state == "Oregon" | state == "Washington") %>% 
  mutate(ppd = round(points/price,2)) %>% # points per dollar!
  arrange(-ppd)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Pinot Noir Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        radioButtons("radio", 
                     label = "Choose State:",
                     choices = list("California", "Oregon", "Washington")),
        radioButtons("color", 
                     label = "Choose Color:", 
                     choices = list("blue","purple","orange")),
        sliderInput("point_size", 
                    label = "Choose Point Size:", 
                    min = 1, max = 8, value = 2)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("priceplot") # THIS needs to contain output$NAME you create in server
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # Make sure this output$name matches what is called in ui
   output$priceplot <- renderPlot({

      #NOT WORKING: plot subset based on input$radio from ui.R
      ggplot(subset(wine_new, state == input$radio), 
             aes(x = price, y = points)) +
       geom_point(color = input$color, size = input$point_size) +
       theme_classic()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

