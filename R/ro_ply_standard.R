
#' Apply styling and accesibility features to plotly figures
#'
#' This function applies a standardized RIVM theme and accessibility features to a given plotly figure object.
#' It wraps several (internal) ROvis functions.
#'
#' @param fig A plotly figure object created by \code{plotly::plot_ly()} to which the styling and accesibility features will be added.
#' @param type Type of chart for which to apply keyboard navigation. Options are "none", "barchart", "bargraph", "linechart", or "trendline". Default is "none".
#' @param barmode Bar mode for bar charts/graphs. Options are "vgroup" (default), "stack", or "overlay".
#' @param base_family Font family for all text (default = "RijksoverheidSansWebText").
#' @param title_color Color for the main title text.
#' @param title_size Font size for the main title.
#' @param axis_tick_size Font size for axis tick labels.
#' @param axis_title_color Color for axis titles.
#' @param axis_tick_color Color for axis tick labels and axis lines.
#' @param grid_color Color for grid lines.
#' @param grid_width Width of grid lines.
#' @param x_line_color Color for the x-axis line.
#' @param x_line_width Width of the x-axis line.
#' @param y_line_color Color for the y-axis line.
#' @param y_line_width Width of the y-axis line.
#' @param colorway Colors for data series.
#' @param legend_font_size Font size for the legend.
#' @param legend_color Color for the legend text.
#' @param plot_bgcolor Plot background color.
#' @param paper_bgcolor Figure (paper) background color.
#' @param barmode Bar mode for bar charts. "vgroup" by default.
#' @param y_axis_title_size Font size for y-axis title.
#' @param x_axis_title_size Font size for x-axis title.
#' @param y_axis_showgrid Show grid lines for y-axis.
#' @param x_axis_showgrid Show grid lines for x-axis.
#' @param y_axis_showline Show y-axis line.
#' @param x_axis_showline Show x-axis line.
#' @param y_axis_spike Show crosshair/spike on y-axis.
#' @param x_axis_spike Show crosshair/spike on x-axis.
#' @param cross_hair_color Color for the crosshair/spike lines.
#' @param cross_hair_style Line style for crosshair (e.g., "dash", "solid").
#' @param cross_hair_width Width of the crosshair lines.
#' @param x_axis_tick_format Format string for x-axis tick labels (e.g., ".2f" for 2 decimal places).
#' @param y_axis_tick_format Format string for y-axis tick labels (e.g., ",.0f" for thousands separator).
#' @param tooltip_color Color for tooltip text.
#' @param tooltip_border_color Border color for tooltips.
#' @param tooltip_background_color Background color for tooltips.
#' @param tooltip_font_size Font size for tooltip text.
#' @param y_data Used to determine the longest y-axis label for margin calculation.
#' @param y_label Y-axis label to display.
#' @param x_label X-axis label to display.
#' @param title Main title to display at the top left.
#' @param canvas_width Width of the plotting area in pixels.
#' @param left_margin_base Base left margin in pixels.
#' @param char_width Estimated width per character in pixels.
#' @param axis_title_size Font size for axis titles.
#' @param title_color Color for all titles/labels.
#' @param thousand_seperator Separator for thousands in y-axis labels.
#' @param decimal_seperator Separator for decimals in y-axis labels.
#' @param width Desired plot width in pixels. Default is 776.
#' @param height Desired plot height in pixels. Default is 400.
#'
#' @returns The Plotly figure object with the custom styling applied and accesibility features applied.
#' @export
#'
#' @examples
#' \dontrun{
#'   library(plotly)
#'   library(ROvis.plotly)
#'
#'   # Create sample data for a grouped bar chart
#'   data <- data.frame(
#'     AgeGroup = rep(c("0-19", "20-39", "40-59", "60-79", "80+"), 2),
#'     Sex = rep(c("Male", "Female"), each = 5),
#'     Cases = c(145, 203, 287, 156, 89, 132, 198, 276, 143, 95)
#'   )
#'
#'   # Create the base Plotly figure with custom colors
#'   fig <- plotly::plot_ly(
#'     data = data,
#'     x = ~AgeGroup,
#'     y = ~Cases,
#'     color = ~Sex,
#'     colors = c(
#'       "Male" = ro_color("hemelblauw"),
#'       "Female" = ro_color("robijnrood")
#'     ),
#'     type = "bar",
#'     text = ~paste0(
#'       "Leeftijdsgroep: <b>", AgeGroup, "</b>",
#'       "<br>Geslacht: <b>", Sex, "</b>",
#'       "<br>Aantal cases: <b>",
#'       format(round(Cases, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
#'     ),
#'     hovertext = ~paste0(
#'       "Leeftijdsgroep: <b>", Agegroup, "</b>",
#'       "<br>Geslacht: <b>", Sex, "</b>",
#'       "<br>Aantal cases: <b>",
#'       format(round(n, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
#'     )
#'   )
#'
#'   # Apply Rijksoverheid / RIVM styling with accessibility features for a bar graph
#'   fig <- ro_ply_standard(
#'     fig,
#'     type = "bargraph",           # Adds keyboard navigation
#'     barmode = "group",           # Group bars by age group
#'     title = "COVID-19 Cases by Age Group and Sex",
#'     y_label = "Number of Cases",
#'     x_label = "Age Group",
#'   )
#'
#'   fig
#' }
ro_ply_standard <- function(fig, type = c("none", "barchart", "bargraph", "linechart", "trendline"),

                           # parameters for ro_ply_theme
                           barmode = "vgroup",
                           #Font
                           base_family = "RijksoverheidSansWebText",
                           # Titles
                           title_color = ro_color(color_name = "lintblauw"), # "#154273"
                           title_size = 17,
                           y_axis_title_size = 13,
                           x_axis_title_size = 13,
                           # Ticks and grids
                           axis_tick_size = 12,
                           axis_title_color = ro_color(color_name = "lintblauw"), # "#154273"
                           axis_tick_color = ro_color(color_name = "grijs_7"), # "#535353"
                           grid_color = ro_color(color_name = "grijs_3"), # "#cccccc"
                           grid_width = 0.25,
                           y_axis_showgrid = TRUE,
                           x_axis_showgrid = FALSE,
                           x_axis_tick_format = NULL, # For most barplots etc. no ticks
                           y_axis_tick_format = ",.0f", #for thousand seperator as ,
                           # Axis lines
                           y_axis_showline = FALSE,
                           x_axis_showline = TRUE,
                           x_line_color = ro_color(color_name = "grijs_7"), # "#535353"
                           y_line_color = ro_color(color_name = "lintblauw"), # "#154273"
                           x_line_width = 1.5,
                           y_line_width = 0,
                           # Crosshair / Spikes
                           y_axis_spike = FALSE,
                           x_axis_spike = TRUE,
                           cross_hair_color = "#535353",
                           cross_hair_style = "dash",
                           cross_hair_width = 1,
                           # General color theming
                           colorway = c(
                             ro_color(color_name = "hemelblauw"),
                             ro_color(color_name = "donkergeel"),
                             ro_color(color_name = "robijnrood"),
                             ro_color(color_name = "paars_tint90"),
                             ro_color(color_name = "mintgroen_tint110"),
                             ro_color(color_name = "oranje"),
                             ro_color(color_name = "groen"),
                             ro_color(color_name = "donkerbruin")
                           ), #c("#007bc7", "#ffb612", "#ca005d", "#552c6f", "#6abda4", "#e17000", "#39870c", "#673327")
                           # Legend
                           legend_font_size = 13,
                           legend_color = ro_color(color_name = "grijs_7"), # "#535353"
                           # General theming
                           plot_bgcolor = "#ffffff", #"#ffffff"
                           paper_bgcolor = "#ffffff", #"#ffffff"
                           # Tooltip
                           tooltip_color = "#000000",
                           tooltip_border_color = "#000000",
                           tooltip_background_color = "#ffffff",
                           tooltip_font_size = 13,


                           # parameters for ro_ply_title
                           y_data = NULL, y_label = NULL, x_label = NULL, title = NULL,
                           canvas_width = 776,
                           left_margin_base = 10,  char_width = 7, # Average size of characters for Ariasl
                           #title_size = 17, # RIVM theming
                           axis_title_size = 13, # RIVM theming
                           #title_color = ro_color(color_name = "lintblauw"), # "#154273" = RIVM theming
                           thousand_seperator = ".", # Dutch way of seperators
                           decimal_seperator = ",", # Dutch way of seperators

                           # parameters for ro_ply_dim
                           width = 776, height = 400
                           ){

  # Theming functions
  theme <- ro_ply_theme(barmode, base_family, title_color, title_size, y_axis_title_size, x_axis_title_size,
                        axis_tick_size, axis_title_color, axis_tick_color, grid_color, grid_width,
                        y_axis_showgrid, x_axis_showgrid, x_axis_tick_format, y_axis_tick_format,
                        y_axis_showline, x_axis_showline, x_line_color, y_line_color, x_line_width,
                        y_line_width, y_axis_spike, x_axis_spike, cross_hair_color, cross_hair_style,
                        cross_hair_width, colorway, legend_font_size, legend_color,
                        plot_bgcolor, paper_bgcolor,
                        tooltip_color, tooltip_border_color, tooltip_background_color,
                        tooltip_font_size)
  fig <- ro_ply_add_theme(fig = fig, theme = theme)
  fig <- ro_ply_title(fig, y_data = y_data, y_label = y_label, x_label = x_label, title = title,
                      canvas_width = canvas_width, left_margin_base = left_margin_base, char_width = char_width,
                      title_size = title_size, axis_title_size = axis_title_size, title_color = title_color,
                      thousand_seperator = thousand_seperator, decimal_seperator = decimal_seperator)
  fig <- ro_ply_cursor(fig)
  fig <- ro_ply_legend_theme(fig)
  fig <- ro_ply_dim(fig, width = width, height = height)


  # Accessibility functions
  if (type == "barchart") {
    fig <- ro_ply_keyboard_nav_barchart(fig)
  }
  if (type == "bargraph") {
    fig <- ro_ply_keyboard_nav_bargraph(fig)
  }
  if (type == "linechart") {
    fig <- ro_ply_keyboard_nav_linechart(fig)
  }
  if (type == "trendline") {
    fig <- ro_ply_keyboard_nav_trendline(fig)
  }
  fig <- ro_ply_keyboard_nav_legend(fig)

  fig <- ro_ply_disable_toolbar(fig)

  return(fig)
}
