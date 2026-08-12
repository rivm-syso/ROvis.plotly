#' Remove Focus Outline from Linechart in Plotly (Shiny)
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Adds custom CSS to your Shiny app to remove the outline and box-shadow
#' that appear when lines in a Plotly linechart receive focus (via keyboard navigation).
#' This improves the visual appearance for certain use-cases, but be aware
#' that it may affect accessibility for keyboard users.
#'
#' @return HTML code (using `tags$head` and `tags$style`) to be included in a Shiny UI.
#' @family plotly
#' @export
#' @examples
#' if (interactive()) {
#'   ui <- fluidPage(
#'     ro_ply_focus_linechart(),
#'     plotlyOutput("myplot")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$myplot <- renderPlotly({
#'       plot_ly(x = 1:10, y = rnorm(10), type = "scatter", mode = "lines")
#'     })
#'   }
#' }
ro_ply_focus_linechart <- function() {
  tags$head(
    tags$style(
      HTML(
        "
      .scatterlayer .lines:focus, .scatterlayer .lines:focus-visible {
      outline: none !important;
      box-shadow: none !important;
        }"
      )
    )
  )
}
