# Remove Focus Outline from Linechart in Plotly (Shiny)

![\[toegankelijkheid\]](figures/group-toegankelijkheid.svg)  
  

## Usage

``` r
ro_ply_focus_linechart()
```

## Value

HTML code (using `tags$head` and `tags$style`) to be included in a Shiny
UI.

## Details

Adds custom CSS to your Shiny app to remove the outline and box-shadow
that appear when lines in a Plotly linechart receive focus (via keyboard
navigation). This improves the visual appearance for certain use-cases,
but be aware that it may affect accessibility for keyboard users.

## See also

Other plotly:
[`ro_ply_add_theme()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_add_theme.md),
[`ro_ply_cursor()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_cursor.md),
[`ro_ply_dim()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_dim.md),
[`ro_ply_disable_toolbar()`](https://rivm-syso.github.io/ROvis.plotly/dev/reference/ro_ply_disable_toolbar.md),
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
if (interactive()) {
  ui <- fluidPage(
    ro_ply_focus_linechart(),
    plotlyOutput("myplot")
  )

  server <- function(input, output, session) {
    output$myplot <- renderPlotly({
      plot_ly(x = 1:10, y = rnorm(10), type = "scatter", mode = "lines")
    })
  }
}
```
