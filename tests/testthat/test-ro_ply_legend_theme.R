test_that("ro_ply_legend_theme adds two legend styling onRender hooks", {
  library(plotly)

  fig <- plot_ly(x = 1:3, y = 1:3, color = I("red"))
  fig_styled <- ro_ply_legend_theme(fig)

  # Check jsHooks$render exists and is a list of length 2
  expect_true("render" %in% names(fig_styled$jsHooks))
  expect_type(fig_styled$jsHooks$render, "list")
  expect_length(fig_styled$jsHooks$render, 2)

  # Check code for boxes
  js1 <- fig_styled$jsHooks$render[[1]]$code
  expect_true(grepl("drawBoxes", js1, fixed = TRUE))
  expect_true(grepl("legend-item-bg", js1, fixed = TRUE))

  # Check code for rectangles
  js2 <- fig_styled$jsHooks$render[[2]]$code
  expect_true(grepl("setLegendRectangles", js2, fixed = TRUE))
  expect_true(grepl("M12,6H-10V-6H12Z", js2, fixed = TRUE))
})
