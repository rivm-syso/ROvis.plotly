# Improve keyboard accessibility for line charts in plotly/ggplotly

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_keyboard_nav_linechart(fig)
```

## Arguments

- fig:

  A `plotly` object (from
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html)).

## Value

A `plotly` object with improved keyboard accessibility for line charts.

## Details

Enhances the accessibility of interactive line charts created with
`plotly` or `ggplotly`. This function injects custom JavaScript to make
bar elements focusable and navigable via keyboard, displays accessible
tooltips, and ensures screen readers can interpret the chart. The
function is intended for use on `plotly` line charts (including those
created with `ggplotly`).

Keyboard navigation: users can use Tab to focus the first bar, and arrow
keys (Left/Right/Up/Down) to move between points on the line Pressing
Esc removes focus from the chart and returns focus to the next logical
element.

## See also

Other ggplotly:
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_cursor.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_disable_toolbar.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_trendline.md)

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data <- tidyr::tibble(expand.grid(Jaar = 2001:2020, Geslacht = c("Man", "Vrouw")),
               value = sample(1:50, 40, TRUE)) |>
  dplyr::bind_rows(., dplyr::summarize(., value = sum(value), .by = "Jaar") |>
                     dplyr::mutate(Geslacht = "Totaal")) |>
  dplyr::mutate(Geslacht = factor(Geslacht, levels = c("Man", "Vrouw", "Totaal")))
library(ggplot2)
library(plotly)
p <- ggplot(data, aes(x = Jaar, y = value, color = Geslacht, group = Geslacht,
                      text = paste0(
                          "Geslacht: <b>", Geslacht,
                          "</b><br>Jaar: <b>", Jaar,
                          "</b><br>Aantal cases: <b>", value
                      ))) +
    geom_line()
fig <- ggplotly(p, tooltip = "text")
fig <- ro_ply_keyboard_nav_linechart(fig)
fig
} # }
```
