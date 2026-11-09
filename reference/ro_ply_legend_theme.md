# RIVM Legend Styling for plotly figures

Applies advanced custom styling to the legend of a Plotly figure. This
function adds a box around each individual legend item and changes
legend symbols to rectangles. The modifications are applied using
JavaScript via
[`htmlwidgets::onRender()`](https://rdrr.io/pkg/htmlwidgets/man/onRender.html).

## Usage

``` r
ro_ply_legend_theme(fig)
```

## Arguments

- fig:

  A Plotly figure object created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  similar.

## Value

The Plotly figure object with the custom legend styling applied.

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
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
fig <- plotly::plot_ly(data = mtcars, x = ~mpg, y = ~hp,
  color = ~factor(cyl), type = 'scatter', mode = 'markers')
fig_styled <- ro_ply_legend_theme(fig)
fig_styled
} # }
```
