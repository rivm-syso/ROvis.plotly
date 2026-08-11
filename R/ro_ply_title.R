#' Add Custom Titles and Axis Labels to a Plotly Figure
#'
#' This function adds a (custom styled) main title, y-axis label, and/or x-axis label as annotations to a Plotly figure,
#' using RIVM theming and Dutch number formatting.
#' It automatically calculates left margin spacing based on the longest y-axis label.
#'
#' @param fig A plotly figure object created by \code{plotly::plot_ly()} to which the titles and labels will be added.
#' @param y_data Used to determine the longest y-axis label for margin calculation.
#' @param y_label Y-axis label to display.
#' @param x_label X-axis label to display.
#' @param title Main title to display at the top left.
#' @param base_family Font family to use.
#' @param canvas_width Width of the plotting area in pixels.
#' @param left_margin_base Base left margin in pixels.
#' @param char_width Estimated width per character in pixels.
#' @param title_size Font size for the main title.
#' @param axis_title_size Font size for axis titles.
#' @param title_color Color for all titles/labels.
#' @param thousand_seperator Separator for thousands in y-axis labels.
#' @param decimal_seperator Separator for decimals in y-axis labels.
#' @family plotly
#' @return The plotly figure object with added (and styled) title and/or axis labels as annotations.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Title only:
#' ro_ply_title(fig,  y_data = data$'Number of Cases', title = "Fancy title")
#' # Y-axis label only:
#' ro_ply_title(fig, y_label = "Number of cases")
#' # X-axis label only:
#' ro_ply_title(fig, x_label = "Groups")
#' # Title, Y-axis label, and X-axis label in one go:
#' ro_ply_title(fig, y_data = data$'Number of Cases',
#'   y_label = "Number of cases", title = "Fancy title", x_label = "groups")
#' }
ro_ply_title <- function(
  fig,
  y_data = NULL,
  y_label = NULL,
  x_label = NULL,
  title = NULL,
  base_family = "RijksoverheidSansWebText",
  canvas_width = 776,
  left_margin_base = 10,
  char_width = 7, # Average size of characters for Ariasl
  title_size = 17, # RIVM theming
  axis_title_size = 13, # RIVM theming
  title_color = ro_color(color_name = "lintblauw"), # "#154273" = RIVM theming
  thousand_seperator = ".", # Dutch way of seperators
  decimal_seperator = "," # Dutch way of seperators
) {
  check_string(base_family)
  ro_check_if_font_available(base_family = base_family)

  # First, determine the size of the longest y-axis label
  if (!is.null(y_label)) {
    if (is.numeric(y_data)) {
      # if numeric, add the thousand and decimal seperator
      max_label_len <- max(
        nchar(as.character(format(
          round(y_data, 0),
          big.mark = thousand_seperator,
          decimal.mark = decimal_seperator,
          scientific = FALSE
        ))),
        na.rm = TRUE
      )
    } else {
      if (is.character(y_data) || is.factor(y_data)) {
        max_label_len <- max(nchar(as.character(format(y_data))))
      } else {
        max_label_len <- 0
      }
    }
  } else {
    max_label_len <- 0
  }

  left_margin <- left_margin_base + max_label_len * char_width
  x_pos <- left_margin / canvas_width

  # Main title, left aligned, with longest label
  title_annotation <- NULL
  if (!is.null(title)) {
    title_annotation <- list(
      text = paste0("<b>", title, "</b>"),
      x = -x_pos,
      y = 1.13,
      xref = "paper",
      yref = "paper",
      showarrow = FALSE,
      xanchor = "left",
      yanchor = "bottom",
      font = list(family = base_family, size = title_size, color = title_color)
    )
  }

  # Y-axis lable, left aligned
  yaxis_annotation <- NULL
  if (!is.null(y_label)) {
    yaxis_annotation <- list(
      text = y_label,
      x = 0,
      y = 1,
      xref = "paper",
      yref = "paper",
      showarrow = FALSE,
      xanchor = "left",
      yanchor = "bottom",
      font = list(
        family = base_family,
        size = axis_title_size,
        color = title_color
      )
    )
  }

  # X-axis label, right aligned
  xaxis_annotation <- NULL
  if (!is.null(x_label)) {
    xaxis_annotation <- list(
      text = x_label,
      x = 1,
      y = -0.1,
      xref = "paper",
      yref = "paper",
      showarrow = FALSE,
      xanchor = "right",
      yanchor = "top",
      font = list(
        family = base_family,
        size = axis_title_size,
        color = title_color
      )
    )
  }

  # Combine annotations
  annotations <- c(
    if (!is.null(title_annotation)) list(title_annotation) else NULL,
    if (!is.null(yaxis_annotation)) list(yaxis_annotation) else NULL,
    if (!is.null(xaxis_annotation)) list(xaxis_annotation) else NULL
  )

  # Add to the layout
  fig <- fig |>
    plotly::layout(
      title = list(text = ""), # Remove the title, yaxis and xaxis label if present
      yaxis = list(title = ""),
      xaxis = list(title = ""),
      margin = list(t = 101), # Make some space for the title
      annotations = annotations # Add the new titles and lavels as annotations
    )
  return(fig)
}
