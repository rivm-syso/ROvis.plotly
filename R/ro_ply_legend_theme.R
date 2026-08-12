#' RIVM Legend Styling for plotly figures
#'
#' Applies advanced custom styling to the legend of a Plotly figure.
#' This function adds a box around each individual legend item and changes legend symbols to rectangles.
#' The modifications are applied using JavaScript via \code{htmlwidgets::onRender()}.
#'
#' @param fig A Plotly figure object created by \code{plotly::plot_ly()} or similar.
#'
#' @return The Plotly figure object with the custom legend styling applied.
#' @export
#' @family plotly
#' @examples
#' \dontrun{
#' fig <- plotly::plot_ly(data = mtcars, x = ~mpg, y = ~hp,
#'   color = ~factor(cyl), type = 'scatter', mode = 'markers')
#' fig_styled <- ro_ply_legend_theme(fig)
#' fig_styled
#' }
ro_ply_legend_theme <- function(fig) {
  # Add boxes around the legend items instead of the legend itself
  fig3 <- onRender(
    fig,
    "
  function(el, x) {
    function drawBoxes() {
      // For every legend item
      var legendItems = el.querySelectorAll('.legend .traces');
      legendItems.forEach(function(trace) {
        // Remove old rectangles
        var oldRects = trace.querySelectorAll('.legend-item-bg');
        oldRects.forEach(function(r) { r.parentNode.removeChild(r); });

        // Get the bounding box of the legend item group
        var bbox = trace.getBBox();

        // Draw a rectangle that fits the legend item
        var rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
        rect.setAttribute('x', bbox.x);
        rect.setAttribute('y', bbox.y);
        rect.setAttribute('width', bbox.width);
        rect.setAttribute('height', bbox.height);
        rect.setAttribute('fill', '#fff');
        rect.setAttribute('stroke', '#aaaaaa');
        rect.setAttribute('stroke-width', '1');
        rect.setAttribute('rx', 0); // no border-radius
        rect.setAttribute('ry', 0);
        rect.setAttribute('class', 'legend-item-bg');
        trace.insertBefore(rect, trace.firstChild);
      });
    }

    // Run after a short delay to allow legend to render
    setTimeout(drawBoxes, 200);

    // Redraw after legend interaction or resizing
    if (typeof(el.on) === 'function') {
      el.on('plotly_relayout', function() { setTimeout(drawBoxes, 200); });
      el.on('plotly_legendclick', function() { setTimeout(drawBoxes, 200); });
      el.on('plotly_legenddoubleclick', function() { setTimeout(drawBoxes, 200); });
    }
    window.addEventListener('resize', function() { setTimeout(drawBoxes, 200); });
  }
  "
  )

  # Make the legend sybols rectangular
  fig4 <- onRender(
    fig3,
    "
  function(el, x) {
    function setLegendRectangles() {
      // Look for all symbols in the legend
      var symbols = el.querySelectorAll('.legendpoints path');
      symbols.forEach(function(sym) {
        // Draw a rectangle 24 wide, 12 high, centered
        sym.setAttribute('d', 'M12,6H-10V-6H12Z');
      });
    }
    setTimeout(setLegendRectangles, 200);
    if (typeof(el.on) === 'function') {
      el.on('plotly_relayout', function() { setTimeout(setLegendRectangles, 200); });
      el.on('plotly_legendclick', function() { setTimeout(setLegendRectangles, 200); });
      el.on('plotly_legenddoubleclick', function() { setTimeout(setLegendRectangles, 200); });
    }
    window.addEventListener('resize', function() { setTimeout(setLegendRectangles, 200); });
  }
  "
  )
  return(fig4)
}
