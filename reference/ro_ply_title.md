# Add Custom Titles and Axis Labels to a Plotly Figure

This function adds a (custom styled) main title, y-axis label, and/or
x-axis label as annotations to a Plotly figure, using RIVM theming and
Dutch number formatting. It automatically calculates left margin spacing
based on the longest y-axis label.

## Usage

``` r
ro_ply_title(
  fig,
  y_data = NULL,
  y_label = NULL,
  x_label = NULL,
  title = NULL,
  base_family = "RijksoverheidSansWebText",
  canvas_width = 776,
  left_margin_base = 10,
  char_width = 7,
  title_size = 17,
  axis_title_size = 13,
  title_color = ro_color(color_name = "lintblauw"),
  thousand_seperator = ".",
  decimal_seperator = ","
)
```

## Arguments

- fig:

  A plotly figure object created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) to
  which the titles and labels will be added.

- y_data:

  Used to determine the longest y-axis label for margin calculation.

- y_label:

  Y-axis label to display.

- x_label:

  X-axis label to display.

- title:

  Main title to display at the top left.

- base_family:

  Font family to use.

- canvas_width:

  Width of the plotting area in pixels.

- left_margin_base:

  Base left margin in pixels.

- char_width:

  Estimated width per character in pixels.

- title_size:

  Font size for the main title.

- axis_title_size:

  Font size for axis titles.

- title_color:

  Color for all titles/labels.

- thousand_seperator:

  Separator for thousands in y-axis labels.

- decimal_seperator:

  Separator for decimals in y-axis labels.

## Value

The plotly figure object with added (and styled) title and/or axis
labels as annotations.

## See also

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_theme.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Title only:
ro_ply_title(fig,  y_data = data$'Number of Cases', title = "Fancy title")
# Y-axis label only:
ro_ply_title(fig, y_label = "Number of cases")
# X-axis label only:
ro_ply_title(fig, x_label = "Groups")
# Title, Y-axis label, and X-axis label in one go:
ro_ply_title(fig, y_data = data$'Number of Cases',
  y_label = "Number of cases", title = "Fancy title", x_label = "groups")
} # }
```
