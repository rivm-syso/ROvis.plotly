
#' Disable the plotly modebar (toolbar) and legend pop-up
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Removes the plotly modebar (toolbar) for a cleaner look and disables the pop-up for the legend,
#' which improves accessibility for keyboard users.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object without the modebar and with improved legend accessibility.
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
#' fig <- ro_ply_disable_toolbar(fig)
#' fig
#' }

ro_ply_disable_toolbar <- function(fig) {
  # Remove the modebar for a clean look, as it is not so accessible
  fig <- plotly::config(fig, displayModeBar = FALSE)

  # Disable the pop-up when the legend is used, as this is not accessible
  fig <- fig |> layout(legend = list(itemdoubleclick = FALSE))

  fig2 <- fig
  return(fig2)
}
