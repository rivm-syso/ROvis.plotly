#' Set default cursor for a plotly figure
#'
#'  Changes the mouse cursor style for a Plotly figure from the default crosshair to the standard arrow cursor.
#'
#' @param fig A Plotly figure object created by \code{plotly::plot_ly()} or similar.
#'
#' @return A Plotly figure object with the cursor style set to "default" (arrow).
#' @export
#' @family plotly
#' @family ggplotly
#' @examples
#' \dontrun{
#' fig <- plotly::plot_ly(data = mtcars, x = ~mpg, y = ~hp, type = 'scatter', mode = 'markers')
#' fig_cursor <- ro_ply_cursor(fig)
#' fig_cursor
#' }
ro_ply_cursor <- function(fig) {
  #The default of plotly is a cross, but a cursor is better
  fig <- onRender(
    fig,
    '
    function(el, x) {
      el.style.cursor = "default";
      var layers = el.querySelectorAll(".plotly .cursor-crosshair, .plotly .scatterlayer, .plotly .cartesianlayer, .plotly .hoverlayer");
      layers.forEach(function(layer) {
        layer.style.cursor = "default";
      });
    }
'
  )
  return(fig)
}
