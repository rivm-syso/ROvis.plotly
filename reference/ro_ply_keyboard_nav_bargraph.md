# Improve keyboard accessibility for (stacked) bar graphs in plotly/ggplotly

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_keyboard_nav_bargraph(fig)
```

## Arguments

- fig:

  A `plotly` object (from
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html)).

## Value

A `plotly` object with improved keyboard accessibility.

## Details

Enhances the accessibility of interactive horizontal bar charts created
with `plotly` or `ggplotly`. This function injects custom JavaScript to
make bar elements focusable and navigable via keyboard, displays
accessible tooltips, and ensures screen readers can interpret the chart.
The function is intended for use on `plotly` bar graphs (including those
created with `ggplotly`).

Keyboard navigation: users can use Tab to focus the first bar, and arrow
keys (Up/Down/Left/Right) to move between bars. Pressing Esc removes
focus from the chart and returns focus to the next logical element.

This function works for:

- Standard (vertical) bar graphs

- Stacked bar graphs

- Grouped/dodged bar graphs

- Proportional stacked bar graphs (bars with proportions)

Not suitable for:

- Horizontal barcharts

## See also

[`ro_ply_keyboard_nav_barchart`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md)

Other ggplotly:
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_cursor.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_disable_toolbar.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_trendline.md)

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)
library(plotly)
data <- tidyr::tibble(
  Sex = factor(c("Vrouw", "Man"), levels = c("Vrouw", "Man")),
  n = sample(1e6:5e6, 2)
)
p <- ggplot(data, aes(x = Sex, y = n, fill = Sex,
                      text = paste0(
                        "Geslacht: <b>", Sex, "</b>",
                        "</b><br>Aantal cases: <b>",
                        format(round(n, 0),
                        big.mark = ".", decimal.mark = ",",
                        scientific = FALSE), "</b>"
                      ))) +
  geom_col(width = 0.6) +
  labs(x = "Geslacht", y = "Aantal cases") +
  theme_minimal()
fig <- ggplotly(p, tooltip = "text")
fig <- ro_ply_keyboard_nav_bargraph(fig)
fig
} # }
```
