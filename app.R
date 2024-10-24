library(shiny)
library(crosstalk)
library(tidyverse)
library(plotly)

datos <- read_csv("www/data/datos_rpe_act2_c3.csv", show_col_types = FALSE)
dat <- SharedData$new(datos)
barplot <- SharedData$new(datos)

sidebar_diamonds <- bslib::layout_sidebar(
  sidebar = filter_select("name", "Nombre", dat, ~Name, allLevels = TRUE, multiple = FALSE),
  plot_ly(dat, x = ~Date, y = ~Value, type = 'scatter') |>
    layout(title = 'Valoración subjetiva del esfuerzo por jugador',
         xaxis = list(title = ''),
         yaxis = list(title = 'Esfuerzo'))
)

sidebar_bar <- bslib::layout_sidebar(
  sidebar = filter_select("date", "Fecha", barplot, ~Date, allLevels = FALSE, multiple = FALSE),
  plot_ly(barplot) |>
    add_histogram(x = ~Value) |>
    layout(title = 'Valoración subjetiva del esfuerzo por día',
         xaxis = list(title = 'Esfuerzo'),
         yaxis = list(title = 'Frecuencia'))
)


ui <- bslib::page_fillable(
  bslib::card(
    full_screen = TRUE,
    bslib::card_header("Respuesta por jugador"),
    sidebar_diamonds
  ),
  bslib::card(
    full_screen = TRUE,
    bslib::card_header("Respuesta por día"),
    sidebar_bar
  )
)

server <- function(input, output) {
}
shinyApp(ui, server)
