#' RIVM Plotly Theme List
#'
#' Returns a standardized RIVM theme as a list for use with plotly charts,
#' allowing customization of fonts, colors, grid, axis, legend, and tooltip styling.
#'
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
#' @param y_axis_tick_format  Format string for x-axis tick labels (e.g.,
#' ",.0f" for thousands separator as comma,
#' ".0%" for percent,
#' ".0f" for no thousand seperator,
#' for more information on time-formats see https://d3js.org/d3-time-format)
#' @param x_axis_tick_format  Format string for x-axis tick labels (e.g.,
#' ",.0f" for thousands separator as comma,
#'  ".0%" for percent,
#' ".0f" for no thousand seperator,
#' for more information on time-formats see https://d3js.org/d3-time-format)
#' @param cross_hair_color Color for crosshair/spike lines.
#' @param cross_hair_style Style for crosshair/spike lines.
#' @param cross_hair_width Width for crosshair/spike lines.
#' @param tooltip_color Font color for tooltips.
#' @param tooltip_border_color Border color for tooltips.
#' @param tooltip_background_color Background color for tooltips.
#' @param tooltip_font_size Font size for tooltips.
#' @family plotly
#'
#' @return A named list with plotly theming options, suitable for passing
#' to \code{plotly::layout()} or as a theme in a plotly chart.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Example data: number of cases per age group and sex
#' stacked_data <- tibble::tibble(
#'   Agegroup = rep(c("0-9", "10-19", "20-29", "30-39"), each = 3),
#'   Sex = rep(c("Man", "Vrouw", "Onbekend"), times = 4),
#'   n = c(10, 14, 2, 15, 17, 1, 23, 18, 0, 9, 11, 3)
#' )
#'
#' # Define color palette using your color function
#' sex_colors <- c(
#'   "Man" = ro_color("hemelblauw"),
#'   "Vrouw" = ro_color("robijnrood"),
#'   "Onbekend" = ro_color("donkergeel")
#' )
#'
#' # Use ro_ply_theme with barmode = "stack"
#' theme_rivm <- ro_ply_theme(barmode = "stack")
#'
#' # Create the plotly stacked bar chart
#' fig <- plotly::plot_ly(
#'   data = stacked_data,
#'   x = ~Agegroup,
#'   y = ~n,
#'   type = "bar",
#'   color = ~Sex,
#'   colors = sex_colors,
#'   text = ~paste0(
#'     "Leeftijdsgroep: <b>", Agegroup, "</b>",
#'     "<br>Geslacht: <b>", Sex, "</b>",
#'     "<br>Aantal cases: <b>",
#'     format(round(n, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
#'   ),
#'   hoverinfo = "text"
#' )
#'
#' fig <- ro_ply_add_theme(fig, theme_rivm)
#' fig
#' }
ro_ply_theme <- function(barmode = "vgroup",

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
  colorway = c(ro_color(color_name = "hemelblauw"),
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
  tooltip_font_size = 13
) {
  check_string(base_family)
  ro_check_if_font_available(base_family = base_family)

  rivm_theme <- list(
    # Title
    title = list(
      font = list(
        family = base_family,
        size = title_size,
        color = title_color,
        weight = 1000
      ),
      x = 0,
      xanchor = "left"
    ),
    # Y-axis settings
    yaxis = list(
      title = list(
        font = list(
          family = base_family,
          size = y_axis_title_size,
          color = axis_title_color
        ),
        standoff = 9 #offset
      ),
      tickfont = list(
        family = base_family,
        size = axis_tick_size,
        color = axis_tick_color
      ),
      tickformat = y_axis_tick_format,
      gridcolor = grid_color, #Officially, the color is #3c3c3c, however, this is more grey than in the plots shown.
      #In ROvis, the grijs3 and 7 are used, which is #cccccc and #535353
      gridwidth = grid_width,
      zeroline = FALSE,
      linecolor = y_line_color,
      linewidth = y_line_width,
      # Crosshair/spike opties - in this case horizontal instead of vertical:
      showspikes = y_axis_spike,
      spikemode = "across",
      spikesnap = "magnet", #cross hair in the middle of the data = magnet
      spikecolor = cross_hair_color,
      spikethickness = cross_hair_width,
      spikedash = cross_hair_style,
      showline = y_axis_showline,
      showgrid = y_axis_showgrid # In this case, a grid line on the y-axis instead of the x-axis
    ),
    # X-axis settings
    xaxis = list(
      title = list(
        font = list(
          family = base_family,
          size = x_axis_title_size,
          color = axis_title_color
        ),
        standoff = 5, #offset
        x = 1, # right-align
        xanchor = "right"
      ),
      gridcolor = grid_color,
      gridwidth = 0.25,
      tickfont = list(
        family = base_family,
        size = axis_tick_size,
        color = axis_tick_color
      ),
      tickformat = x_axis_tick_format,
      linecolor = x_line_color,
      linewidth = y_line_width,
      ticklen = 4,
      tickcolor = axis_tick_color,
      # Crosshair/spike opties - in this case horizontal instead of vertical:
      showspikes = x_axis_spike,
      spikemode = "across",
      spikesnap = "magnet", #cross hair in the middle of the data = magnet
      spikecolor = cross_hair_color,
      spikethickness = cross_hair_width,
      spikedash = cross_hair_style,
      showline = x_axis_showline,
      showgrid = x_axis_showgrid
    ),
    # Tooltip
    hoverlabel = list(
      font = list(
        family = base_family,
        size = tooltip_font_size,
        color = tooltip_color
      ),
      bgcolor = tooltip_background_color,
      bordercolor = tooltip_border_color
    ),
    # Legend
    legend = list(
      orientation = "h",
      x = 0,
      y = -0.15,
      font = list(
        family = base_family,
        size = legend_font_size,
        color = legend_color
      )
    ),
    # General settings
    colorway = colorway, #color pallete
    font = list(
      family = base_family,
      color = "#535353",
      size = 13
    ),
    plot_bgcolor = plot_bgcolor,
    paper_bgcolor = paper_bgcolor,
    margin = list(
      l = 60,
      r = 30,
      t = 60,
      b = 60
    ),
    barmode = barmode,
    bargap = 0.1,
    hovermode = "closest"
  )
  return(rivm_theme)
}
