
#' Improve keyboard accessibility for plotly legends
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Makes the legend of a \code{plotly} or \code{ggplotly} plot accessible via keyboard.
#' Users can use Tab to focus legend items and activate them with Enter or Space.
#' Focus indication is only shown when navigating with the keyboard. ARIA attributes are added for screen readers.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object with improved legend accessibility.
#'
#' @export
#' @family ggplotly
#' @family plotly
#' @examples
#' \dontrun{
#' data <- tidyr::tibble(
#'   expand.grid(`Age group` = c("A", "B", "C", "D", "E"), `Sex` = c("Man", "Vrouw")),
#'   `Number of Cases` = sample(1:50, 10, TRUE)
#' )
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(
#'   x = `Number of Cases`,
#'   y = `Age group`,
#'   fill = Sex,
#'   text = paste0(
#'     "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'     "Geslacht: <b>", Sex, "</b><br>",
#'     "Aantal cases: <b>", `Number of Cases`, "</b>"
#'   )
#' )) +
#'   geom_col(position = "dodge") +
#'   labs(
#'     x = "Aantal cases",
#'     y = "Leeftijdsgroep",
#'     fill = "Geslacht"
#'   )
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_barchart(fig)
#' fig <- ro_ply_keyboard_nav_legend(fig)
#' fig
#' }
ro_ply_keyboard_nav_legend <- function(fig) {
  fig2 <- onRender(
    fig,
    "function(el, x) {

  // Track last input type: keyboard or mouse
  var keyboardMode = false;
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Tab' || e.key === 'Enter' || e.key === ' ') keyboardMode = true;
  }, true);
  document.addEventListener('mousedown', function(e) { keyboardMode = false; }, true);

  const checkLegend = () => {
    const traces = el.querySelectorAll('.traces');
    if (traces.length === 0) {
      setTimeout(checkLegend, 100);
      return;
    }
    traces.forEach(trace => {
      const label = trace.querySelector('.legendtext')?.textContent || 'Legend item';
      trace.setAttribute('tabindex', '0'); // Make the trace tab-able
      trace.setAttribute('role', 'button'); // Make the legend as a button (it is in reality a svg)
      trace.setAttribute('aria-label', label);
      const isVisible = trace.style.opacity !== '0.5'; // If pressed, opacity of 0.5
      trace.setAttribute('aria-pressed', String(isVisible));

      // Focus/outline only for keyboard
      trace.addEventListener('focus', () => {
        if (keyboardMode) {
          trace.style.outline = '2px solid #333';
        } else {
          trace.style.outline = 'none';
        }
      });
      trace.addEventListener('blur', () => { trace.style.outline = 'none'; });

      // Remove focus/outline after mouse click
      trace.addEventListener('mousedown', (e) => {
        setTimeout(() => { trace.blur(); }, 0);
      });
      // Or better, prevent it from being applied at all
      trace.addEventListener('mousedown', (e) => {
        e.preventDefault(); // Prevents focus from being applied at all
      });

      // Keyboard: keep focus after activation
      trace.addEventListener('keydown', e => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          const rect = trace.querySelector('.legendtoggle');
          if (rect) {
            rect.dispatchEvent(new MouseEvent('mousedown', { bubbles: true }));
            rect.dispatchEvent(new MouseEvent('mouseup', { bubbles: true }));
            rect.dispatchEvent(new MouseEvent('click', { bubbles: true }));
            setTimeout(() => {
              const isVisible = trace.style.opacity !== '0.5';
              trace.setAttribute('aria-pressed', String(isVisible));
              // Force focus back to the legend item (for keyboard users)
              trace.focus();
            }, 0);
          }
        }
      });
          });
        };
        checkLegend();
      }
"
  )
  return(fig2)
}
