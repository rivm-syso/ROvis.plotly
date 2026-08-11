#' Add a Custom Theme to a Plotly Figure
#'
#' Applies a specified Plotly theme (as a list) to a Plotly figure object.
#'
#' @param fig A Plotly figure object created by \code{plotly::plot_ly()} or similar.
#' @param theme A named list of layout parameters to apply as a theme (e.g., font, colors, margins).
#' @export
#' @family plotly
#' @return A Plotly figure object with the specified theme applied.
#'
#' @examples
#' \dontrun{
#' fig <- ro_ply_add_theme(fig, theme = theme_rivm)
#' }
ro_ply_add_theme <- function(fig, theme) {
  # Add the theme
  fig <- do.call(plotly::layout, c(list(fig), theme))

  return(fig)
}
