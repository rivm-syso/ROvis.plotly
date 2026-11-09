# Improve keyboard accessibility for plotly legends

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_keyboard_nav_legend(fig)
```

## Arguments

- fig:

  A `plotly` object (from
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html)).

## Value

A `plotly` object with improved legend accessibility.

## Details

Makes the legend of a `plotly` or `ggplotly` plot accessible via
keyboard. Users can use Tab to focus legend items and activate them with
Enter or Space. Focus indication is only shown when navigating with the
keyboard. ARIA attributes are added for screen readers.

## See also

Other ggplotly:
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_trendline.md)

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_barchart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_barchart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data <- tidyr::tibble(
  expand.grid(`Age group` = c("A", "B", "C", "D", "E"), `Sex` = c("Man", "Vrouw")),
  `Number of Cases` = sample(1:50, 10, TRUE)
)
library(ggplot2)
library(plotly)
p <- ggplot(data, aes(
  x = `Number of Cases`,
  y = `Age group`,
  fill = Sex,
  text = paste0(
    "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
    "Geslacht: <b>", Sex, "</b><br>",
    "Aantal cases: <b>", `Number of Cases`, "</b>"
  )
)) +
  geom_col(position = "dodge") +
  labs(
    x = "Aantal cases",
    y = "Leeftijdsgroep",
    fill = "Geslacht"
  )
fig <- ggplotly(p, tooltip = "text")
fig <- ro_ply_keyboard_nav_barchart(fig)
fig <- ro_ply_keyboard_nav_legend(fig)
fig
} # }
```
