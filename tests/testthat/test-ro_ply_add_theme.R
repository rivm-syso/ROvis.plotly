test_that("ro_ply_add_theme applies a layout", {
  library(plotly)

  fig <- plot_ly(x = 1:3, y = 1:3) |> plotly::layout()

  minimal_theme <- list(
    title = list(
      text = "Test title",
      font = list(
        family = "Arial",
        size = 20,
        color = "red"
      )
    )
  )

  fig_themed <- ro_ply_add_theme(fig, minimal_theme)

  # Get the title
  title <- fig_themed$x$layoutAttrs[[2]]$title
  # Get the title styling
  expect_identical(title$text, "Test title")
  expect_identical(title$font$family, "Arial")
  expect_identical(title$font$size, 20)
  expect_identical(title$font$color, "red")
})
