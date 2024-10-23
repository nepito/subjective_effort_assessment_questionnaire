library(shiny)
library(tidyverse)

datos <- read_csv("www/data/datos_rpe_act2_c3.csv")
ui <- bslib::page_sidebar(
  sidebar = bslib::sidebar(),
  titlePanel(title = span(img(src = "logo.jpeg", height = 35), "")),
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(datos))
  output$dynamic <- renderDataTable(datos, options = list(pageLength = 5))
}
shinyApp(ui, server)
