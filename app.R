library(shiny)
library(tidyverse)

datos <- read_csv("https://raw.githubusercontent.com/nepito/world_cup_semis/develop/tests/data/morocco_vs_spain.csv")
ui <- fluidPage(
  titlePanel(title = span(img(src = "logo.jpeg", height = 35), "")),
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(datos))
  output$dynamic <- renderDataTable(datos, options = list(pageLength = 5))
}
shinyApp(ui, server)
