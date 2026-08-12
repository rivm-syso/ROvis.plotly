test_that("plotly_dim_theme sets correct width and height", {
  library(plotly)

  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_dimmed <- ro_ply_dim(fig, width = 800, height = 500)

  # Test that the sizingPolicy is updated
  expect_identical(fig_dimmed$sizingPolicy$defaultWidth, 800)
  expect_identical(fig_dimmed$sizingPolicy$defaultHeight, 500)
})
