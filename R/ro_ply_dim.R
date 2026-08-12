#' Set RIVM theme dimensions for a plotly Figure
#'
#' Applies custom width and height to a Plotly figure, ensuring the plot displays at the specified dimensions.
#' The function also sets the plot to autosize for responsive layouts.
#'
#' @param fig A Plotly figure object created by \code{plotly::plot_ly()} or similar.
#' @param width Desired plot width in pixels. Default is 776.
#' @param height Desired plot height in pixels. Default is 400.
#'
#' @return A Plotly figure object with updated sizing policy and layout.
#' @export
#' @family plotly
#' @examples
#' \dontrun{
#' fig <- plotly::plot_ly(data = mtcars, x = ~mpg, y = ~hp, type = 'scatter', mode = 'markers')
#' fig_dimmed <- ro_ply_dim(fig, width = 800, height = 500)
#' fig_dimmed
#' }
ro_ply_dim <- function(fig, width = 776, height = 400) {
  # Make sure the plot is the correct dimensions and ratio
  fig5 <- fig |>
    layout(
      autosize = TRUE
    )
  fig5$sizingPolicy$defaultWidth <- width
  fig5$sizingPolicy$defaultHeight <- height

  return(fig5)
}
