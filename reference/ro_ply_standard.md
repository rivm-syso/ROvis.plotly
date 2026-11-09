# Apply styling and accesibility features to plotly figures

This function applies a standardized RIVM theme and accessibility
features to a given plotly figure object. It wraps several (internal)
ROvis functions.

## Usage

``` r
ro_ply_standard(
  fig,
  type = c("none", "barchart", "bargraph", "linechart", "trendline"),
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
  tooltip_font_size = 13,
  y_data = NULL,
  y_label = NULL,
  x_label = NULL,
  title = NULL,
  canvas_width = 776,
  left_margin_base = 10,
  char_width = 7,
  axis_title_size = 13,
  thousand_seperator = ".",
  decimal_seperator = ",",
  width = 776,
  height = 400
)
```

## Arguments

- fig:

  A plotly figure object created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) to
  which the styling and accesibility features will be added.

- type:

  Type of chart for which to apply keyboard navigation. Options are
  "none", "barchart", "bargraph", "linechart", or "trendline". Default
  is "none".

- barmode:

  Bar mode for bar charts. "vgroup" by default.

- base_family:

  Font family for all text (default = "RijksoverheidSansWebText").

- title_color:

  Color for all titles/labels.

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

  Format string for x-axis tick labels (e.g., ".2f" for 2 decimal
  places).

- y_axis_tick_format:

  Format string for y-axis tick labels (e.g., ",.0f" for thousands
  separator).

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

  Color for the crosshair/spike lines.

- cross_hair_style:

  Line style for crosshair (e.g., "dash", "solid").

- cross_hair_width:

  Width of the crosshair lines.

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

  Color for tooltip text.

- tooltip_border_color:

  Border color for tooltips.

- tooltip_background_color:

  Background color for tooltips.

- tooltip_font_size:

  Font size for tooltip text.

- y_data:

  Used to determine the longest y-axis label for margin calculation.

- y_label:

  Y-axis label to display.

- x_label:

  X-axis label to display.

- title:

  Main title to display at the top left.

- canvas_width:

  Width of the plotting area in pixels.

- left_margin_base:

  Base left margin in pixels.

- char_width:

  Estimated width per character in pixels.

- axis_title_size:

  Font size for axis titles.

- thousand_seperator:

  Separator for thousands in y-axis labels.

- decimal_seperator:

  Separator for decimals in y-axis labels.

- width:

  Desired plot width in pixels. Default is 776.

- height:

  Desired plot height in pixels. Default is 400.

## Value

The Plotly figure object with the custom styling applied and
accesibility features applied.

## Examples

``` r
if (FALSE) { # \dontrun{
  library(plotly)
  library(ROvis.plotly)

  # Create sample data for a grouped bar chart
  data <- data.frame(
    AgeGroup = rep(c("0-19", "20-39", "40-59", "60-79", "80+"), 2),
    Sex = rep(c("Male", "Female"), each = 5),
    Cases = c(145, 203, 287, 156, 89, 132, 198, 276, 143, 95)
  )

  # Create the base Plotly figure with custom colors
  fig <- plotly::plot_ly(
    data = data,
    x = ~AgeGroup,
    y = ~Cases,
    color = ~Sex,
    colors = c(
      "Male" = ro_color("hemelblauw"),
      "Female" = ro_color("robijnrood")
    ),
    type = "bar",
    text = ~paste0(
      "Leeftijdsgroep: <b>", AgeGroup, "</b>",
      "<br>Geslacht: <b>", Sex, "</b>",
      "<br>Aantal cases: <b>",
      format(round(Cases, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
    ),
    hovertext = ~paste0(
      "Leeftijdsgroep: <b>", Agegroup, "</b>",
      "<br>Geslacht: <b>", Sex, "</b>",
      "<br>Aantal cases: <b>",
      format(round(n, 0), big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b>"
    )
  )

  # Apply Rijksoverheid / RIVM styling with accessibility features for a bar graph
  fig <- ro_ply_standard(
    fig,
    type = "bargraph",           # Adds keyboard navigation
    barmode = "group",           # Group bars by age group
    title = "COVID-19 Cases by Age Group and Sex",
    y_label = "Number of Cases",
    x_label = "Age Group",
  )

  fig
} # }
```
