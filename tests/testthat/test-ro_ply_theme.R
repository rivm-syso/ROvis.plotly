test_that("ro_ply_theme returns a correct theme list", {
  # Minimal dummy color function if not loaded
  if (!exists("color")) {
    color <- function(color_name) "#123456"
  }

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

  expect_type(theme, "list")
  expect_true(all(
    c("title", "yaxis", "xaxis", "legend", "font", "plot_bgcolor", "paper_bgcolor", "colorway") %in% names(theme)
  ))

  # Check correct types and values for some elements
  expect_identical(theme$title$font$family, "Arial")
  expect_identical(theme$title$font$size, 20)
  expect_identical(theme$title$font$color, "#ff0000")
  expect_identical(theme$yaxis$tickfont$size, 15)
  expect_identical(theme$yaxis$gridcolor, "#abcdef")
  expect_identical(theme$legend$font$color, "#0000ff")
  expect_identical(theme$legend$font$size, 17)
  expect_identical(theme$plot_bgcolor, "#e0e0e0")
  expect_identical(theme$paper_bgcolor, "#f0f0f0")

  # Check that colorway is a character vector of colors
  expect_type(theme$colorway, "character")
  expect_gt(length(theme$colorway), 1)
})

test_that("ro_ply_theme applies the font resolved by ro_check_if_font_available, not the requested one", {
  local_mocked_bindings(
    ro_check_if_font_available = function(target_font_family) "Verdana"
  )
  theme <- ro_ply_theme(base_family = "RijksoverheidSansWebText")
  expect_identical(theme$title$font$family, "Verdana")
  expect_identical(theme$font$family, "Verdana")
})
