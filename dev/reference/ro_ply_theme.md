# RIVM Plotly Theme List

Returns a standardized RIVM theme as a list for use with plotly charts,
allowing customization of fonts, colors, grid, axis, legend, and tooltip
styling.

## Usage

``` r
ro_ply_theme(
  barmode = "vgroup",
  base_family = "RijksoverheidSansWebText",
  title_color = ro_color(color_name = "lintblauw"),
  title_size = 17,
  y_axis_title_size = 13,
  x_axis_title_size = 13,
  axis_tick_size = 12,
  axis_title_color = ro_color(color_name = "lintblauw"),
  axis_tick_color = ro_color(color_name = "grijs_7"),
  grid_color = ro_color(color_name = "grijs_3"),
  grid_width = 0.25,
  y_axis_showgrid = TRUE,
  x_axis_showgrid = FALSE,
  x_axis_tick_format = NULL,
  y_axis_tick_format = ",.0f",
  y_axis_showline = FALSE,
  x_axis_showline = TRUE,
  x_line_color = ro_color(color_name = "grijs_7"),
  y_line_color = ro_color(color_name = "lintblauw"),
  x_line_width = 1.5,
  y_line_width = 0,
  y_axis_spike = FALSE,
  x_axis_spike = TRUE,
  cross_hair_color = "#535353",
  cross_hair_style = "dash",
  cross_hair_width = 1,
  colorway = c(ro_color(color_name = "hemelblauw"), ro_color(color_name = "donkergeel"),
    ro_color(color_name = "robijnrood"), ro_color(color_name = "paars_tint90"),
    ro_color(color_name = "mintgroen_tint110"), ro_color(color_name = "oranje"),
    ro_color(color_name = "groen"), ro_color(color_name = "donkerbruin")),
  legend_font_size = 13,
  legend_color = ro_color(color_name = "grijs_7"),
  plot_bgcolor = "#ffffff",
  paper_bgcolor = "#ffffff",
  tooltip_color = "#000000",
  tooltip_border_color = "#000000",
  tooltip_background_color = "#ffffff",
  tooltip_font_size = 13
)
```

## Arguments

- barmode:

  Bar mode for bar charts. "vgroup" by default.

- base_family:

  Font family for all text (default = "RijksoverheidSansWebText").

- title_color:

  Color for the main title text.

- title_size:

  Font size for the main title.

- y_axis_title_size:

  Font size for y-axis title.

- x_axis_title_size:

  Font size for x-axis title.

- axis_tick_size:

  Font size for axis tick labels.

- axis_title_color:

  Color for axis titles.

- axis_tick_color:

  Color for axis tick labels and axis lines.

- grid_color:

  Color for grid lines.

- grid_width:

  Width of grid lines.

- y_axis_showgrid:

  Show grid lines for y-axis.

- x_axis_showgrid:

  Show grid lines for x-axis.

- x_axis_tick_format:

  Format string for x-axis tick labels (e.g., ",.0f" for thousands
  separator as comma, ".0%" for percent, ".0f" for no thousand
  seperator, for more information on time-formats see
  https://d3js.org/d3-time-format)

- y_axis_tick_format:

  Format string for x-axis tick labels (e.g., ",.0f" for thousands
  separator as comma, ".0%" for percent, ".0f" for no thousand
  seperator, for more information on time-formats see
  https://d3js.org/d3-time-format)

- y_axis_showline:

  Show y-axis line.

- x_axis_showline:

  Show x-axis line.

- x_line_color:

  Color for the x-axis line.

- y_line_color:

  Color for the y-axis line.

- x_line_width:

  Width of the x-axis line.

- y_line_width:

  Width of the y-axis line.

- y_axis_spike:

  Show crosshair/spike on y-axis.

- x_axis_spike:

  Show crosshair/spike on x-axis.

- cross_hair_color:

  Color for crosshair/spike lines.

- cross_hair_style:

  Style for crosshair/spike lines.

- cross_hair_width:

  Width for crosshair/spike lines.

- colorway:

  Colors for data series.

- legend_font_size:

  Font size for the legend.

- legend_color:

  Color for the legend text.

- plot_bgcolor:

  Plot background color.

- paper_bgcolor:

  Figure (paper) background color.

- tooltip_color:

  Font color for tooltips.

- tooltip_border_color:

  Border color for tooltips.

- tooltip_background_color:

  Background color for tooltips.

- tooltip_font_size:

  Font size for tooltips.

## Value

A named list with plotly theming options, suitable for passing to
`plotly::layout()` or as a theme in a plotly chart.

## See also

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_legend_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Example data: number of cases per age group and sex
stacked_data <- tibble::tibble(
  Agegroup = rep(c("0-9", "10-19", "20-29", "30-39"), each = 3),
  Sex = rep(c("Man", "Vrouw", "Onbekend"), times = 4),
  n = c(10, 14, 2, 15, 17, 1, 23, 18, 0, 9, 11, 3)
)

# Define color palette using your color function
sex_colors <- c(
  "Man" = ro_color("hemelblauw"),
  "Vrouw" = ro_color("robijnrood"),
  "Onbekend" = ro_color("donkergeel")
)

# Use ro_ply_theme with barmode = "stack"
theme_rivm <- ro_ply_theme(barmode = "stack")

# Create the plotly stacked bar chart
fig <- plotly::plot_ly(
  data = stacked_data,
  x = ~Agegroup,
  y = ~n,
  type = "bar",
  color = ~Sex,
  colors = sex_colors,
  text = ~paste0(
    "Leeftijdsgroep: <b>", Agegroup, "</b>",
    "<br>Geslacht: <b>", Sex, "</b>",
    "<br>Aantal cases: <b>",
    format(round(n, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
  ),
  hoverinfo = "text"
)

fig <- ro_ply_add_theme(fig, theme_rivm)
fig
} # }
```
