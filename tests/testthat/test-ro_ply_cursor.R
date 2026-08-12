test_that("ro_ply_cursor adds cursor JavaScript to plotly object", {
  library(plotly)

  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_cursor <- ro_ply_cursor(fig)

  #Test preRenderHook exists and is a function
  expect_false(is.null(fig_cursor$preRenderHook))
  expect_type(fig_cursor$preRenderHook, "closure")

  # Test jsHooks$render exists and contains code as character
  expect_true("render" %in% names(fig_cursor$jsHooks))
  expect_type(fig_cursor$jsHooks$render, "list")
  expect_type(fig_cursor$jsHooks$render[[1]]$code, "character")

  # Test that the JavaScript code contains the right cursor code
  js_code <- fig_cursor$jsHooks$render[[1]]$code
  expect_true(grepl('el.style.cursor = "default";', js_code, fixed = TRUE))
  expect_true(grepl('layer.style.cursor = "default";', js_code, fixed = TRUE))
})
