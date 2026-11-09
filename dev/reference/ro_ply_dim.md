# Set RIVM theme dimensions for a plotly Figure

Applies custom width and height to a Plotly figure, ensuring the plot
displays at the specified dimensions. The function also sets the plot to
autosize for responsive layouts.

## Usage

``` r
ro_ply_dim(fig, width = 776, height = 400)
```

## Arguments

- fig:

  A Plotly figure object created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  similar.

- width:

  Desired plot width in pixels. Default is 776.

- height:

  Desired plot height in pixels. Default is 400.

## Value

A Plotly figure object with updated sizing policy and layout.

## See also

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
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
fig <- plotly::plot_ly(data = mtcars, x = ~mpg, y = ~hp, type = 'scatter', mode = 'markers')
fig_dimmed <- ro_ply_dim(fig, width = 800, height = 500)
fig_dimmed
} # }
```
