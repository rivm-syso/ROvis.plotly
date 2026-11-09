# Improve keyboard accessibility for scatter-trendline plots in plotly/ggplotly

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_keyboard_nav_trendline(fig)
```

## Arguments

- fig:

  A `plotly` object (from
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html)).

## Value

A `plotly` object with improved keyboard accessibility.

## Details

Enhances the accessibility of interactive scatter-trendline plots
created with `plotly` or `ggplotly`. This function injects custom
JavaScript to make bar elements focusable and navigable via keyboard,
displays accessible tooltips, and ensures screen readers can interpret
the chart. The function is intended for use on `plotly`
scatter-trendline plots (including those created with `ggplotly`). The
focusable element are the points.

Keyboard navigation: users can use Tab to focus the first point, and
arrow keys (Left/Right/Up/Down) to move between points. Pressing Esc
removes focus from the chart and returns focus to the next logical
element.

## See also

Other ggplotly:
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md)

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
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dates <- seq(as.Date("2021-10-04"), by = "day", length.out = 100)
n <- round(2500 + 700 * sin(seq_along(dates) / 25) + seq_along(dates) *
3 + rnorm(length(dates), 0, 150))

moving_average <- stats::filter(n, rep(1 / 7, 7), sides = 2)
text <- paste0(
  "Dag: <b>", format(dates, "%d-%m-%Y"), "</b><br>",
  "Aantal cases: <b>", format(n,
  big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b><br>",
  "7-daags gemiddelde: <b>",
  format(round(moving_average, 0),
   big.mark = ".",
   decimal.mark = ",", scientific = FALSE), "</b>"
)
data <- tibble::tibble(
  Date_statistics = dates,
  n = n,
  moving_average = as.numeric(moving_average),
  text = text
)
library(ggplot2)
library(plotly)
p <- ggplot(data, aes(x = Date_statistics, y = n, text = text, group = 1)) +
  geom_line() +
  geom_point()
fig <- ggplotly(p, tooltip = "text")
fig <- ro_ply_keyboard_nav_trendline(fig)
fig
} # }
```
