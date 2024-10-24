library(shiny)
library(tidyverse)

datos <- read_csv("www/data/datos_rpe_act2_c3.csv", show_col_types = FALSE)
all_playes <- datos$Name |> unique()
ui <- bslib::page_sidebar(
  sidebar = bslib::sidebar(
    selectInput("name", "Nombre", all_playes, selected = "Matt"),
  ),
  titlePanel(title = span(img(src = "logo.jpeg", height = 35), "")),
  DT::DTOutput("dynamic"),
  plotOutput("plot", brush = "plot_brush")

)
server <- function(input, output, session) {
  output$plot <- renderPlot({
    datos |>
      filter(Name == input$name) |>
      ggplot(aes(x=Date, Value)) + geom_point()
  }, res = 96)
  output$dynamic <- DT::renderDT(datos, options = list(pageLength = 5))
}
shinyApp(ui, server)
