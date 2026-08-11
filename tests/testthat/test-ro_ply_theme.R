test_that("ro_ply_theme returns a correct theme list", {
  # Minimal dummy color function if not loaded
  if (!exists("color")) color <- function(color_name) "#123456"

  theme <- ro_ply_theme(
    base_family = "Arial",
    title_color = "#ff0000",
    title_size = 20,
    axis_tick_size = 15,
    grid_color = "#abcdef",
    legend_color = "#0000ff",
    legend_font_size = 17,
    plot_bgcolor = "#e0e0e0",
    paper_bgcolor = "#f0f0f0"
  )

  expect_true(is.list(theme))
  expect_true(all(c("title", "yaxis", "xaxis", "legend", "font", "plot_bgcolor", "paper_bgcolor", "colorway") %in% names(theme)))

  # Check correct types and values for some elements
  expect_equal(theme$title$font$family, "Arial")
  expect_equal(theme$title$font$size, 20)
  expect_equal(theme$title$font$color, "#ff0000")
  expect_equal(theme$yaxis$tickfont$size, 15)
  expect_equal(theme$yaxis$gridcolor, "#abcdef")
  expect_equal(theme$legend$font$color, "#0000ff")
  expect_equal(theme$legend$font$size, 17)
  expect_equal(theme$plot_bgcolor, "#e0e0e0")
  expect_equal(theme$paper_bgcolor, "#f0f0f0")

  # Check that colorway is a character vector of colors
  expect_true(is.character(theme$colorway))
  expect_true(length(theme$colorway) > 1)
})
