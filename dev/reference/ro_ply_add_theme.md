# Add a Custom Theme to a Plotly Figure

Applies a specified Plotly theme (as a list) to a Plotly figure object.

## Usage

``` r
ro_ply_add_theme(fig, theme)
```

## Arguments

- fig:

  A Plotly figure object created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  similar.

- theme:

  A named list of layout parameters to apply as a theme (e.g., font,
  colors, margins).

## Value

A Plotly figure object with the specified theme applied.

## See also

Other plotly:
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
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
fig <- ro_ply_add_theme(fig, theme = theme_rivm)
} # }
```
