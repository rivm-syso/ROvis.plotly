test_that("ro_ply_cursor adds cursor JavaScript to plotly object", {
  library(plotly)
  library(htmlwidgets)

  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_cursor <- ro_ply_cursor(fig)

  #Test preRenderHook exists and is a function
  expect_true(!is.null(fig_cursor$preRenderHook))
  expect_true(is.function(fig_cursor$preRenderHook))

  # Test jsHooks$render exists and contains code as character
  expect_true("render" %in% names(fig_cursor$jsHooks))
  expect_true(is.list(fig_cursor$jsHooks$render))
  expect_true(is.character(fig_cursor$jsHooks$render[[1]]$code))

  # Test that the JavaScript code contains the right cursor code
  js_code <- fig_cursor$jsHooks$render[[1]]$code
  expect_true(grepl('el.style.cursor = "default";', js_code, fixed = TRUE))
  expect_true(grepl('layer.style.cursor = "default";', js_code, fixed = TRUE))
})
