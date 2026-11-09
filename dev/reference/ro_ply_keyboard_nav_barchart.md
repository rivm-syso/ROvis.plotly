# Improve keyboard accessibility for ggplotly and plotly horizontal barcharts

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_keyboard_nav_barchart(fig)
```

## Arguments

- fig:

  A `plotly` object representing a horizontal bar chart, such as one
  created by
  [`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html).

## Value

A `plotly` object with improved accessibility features for keyboard and
screen reader users.

## Details

Enhances the accessibility of interactive horizontal bar charts created
with `plotly` or `ggplotly`. This function injects custom JavaScript to
make bar elements focusable and navigable via keyboard, displays
accessible tooltips, and ensures screen readers can interpret the chart.
The function is intended for use on `plotly` horizontal bar charts
(including those created with `ggplotly`).

Keyboard navigation: users can use Tab to focus the first bar, and arrow
keys (Up/Down) to move between bars. Pressing Esc removes focus from the
chart and returns focus to the next logical element.

## See also

[`ro_ply_keyboard_nav_bargraph`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md)

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_focus_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_focus_linechart.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_trendline.md),
[`ro_ply_legend_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_legend_theme.md),
[`ro_ply_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_theme.md),
[`ro_ply_title()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_title.md)

Other ggplotly:
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
[`ro_ply_keyboard_nav_bargraph()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_bargraph.md),
[`ro_ply_keyboard_nav_legend()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_legend.md),
[`ro_ply_keyboard_nav_linechart()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_linechart.md),
[`ro_ply_keyboard_nav_trendline()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_keyboard_nav_trendline.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Example data
data <- tidyr::tibble(
  expand.grid(`Age group` = c("A", "B", "C", "D", "E"),
           `Sex` = c("Man", "Vrouw")
           ),
  `Number of Cases` = sample(1:50, 10, TRUE)
)

# Basic ggplotly example
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
  ) +
  theme_minimal()

# Convert to plotly and add accessibility
fig <- ggplotly(p, tooltip = "text")
fig <- ro_ply_keyboard_nav_barchart(fig)
fig

# Basic plotly example
library(plotly)
fig <- plot_ly() |>
  add_trace(
    data = data,
    x = ~`Number of Cases`,
    y = ~`Age group`,
    color = ~`Sex`,
    type = "bar",
    orientation = "h",
    hovertext  = ~paste0(
      "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
      "Geslacht: <b>", `Sex`, "</b><br>",
      "Aantal cases: <b>", `Number of Cases`, "</b>"
    ),
    text  = ~paste0(
      "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
      "Geslacht: <b>", `Sex`, "</b><br>",
      "Aantal cases: <b>", `Number of Cases`, "</b>"
    ),
    textposition = "none",
    hoverinfo = "text"
  )
fig <- ro_ply_keyboard_nav_barchart(fig)
fig
} # }
```
