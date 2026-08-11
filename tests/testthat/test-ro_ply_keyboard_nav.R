# Some basic tests for the functions and ui for the plotly_keyboard_accessibility.R
library(plotly)

test_that("ro_ply_keyboard_nav_barchart returns a plotly object", {
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_barchart(p)
  expect_s3_class(fig2, "plotly")
})

test_that("ro_ply_keyboard_nav_barchart uses onRender", {
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_barchart(p)
  # Check that jsHooks exists and has a render entry
  expect_false(is.null(fig2$jsHooks))
  expect_true("render" %in% names(fig2$jsHooks))
  expect_false(is.null(fig2$jsHooks$render))
  expect_gt(length(fig2$jsHooks$render), 0)
  # By htmlwidget
  expect_s3_class(fig2, "htmlwidget")

})


test_that("ro_ply_keyboard_nav_bargraph returns a plotly object", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_bargraph(p)
  expect_s3_class(fig2, "plotly")
})

test_that("ro_ply_keyboard_nav_bargraph uses onRender", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_bargraph(p)
  # Check that jsHooks exists and has a render entry
  expect_false(is.null(fig2$jsHooks))
  expect_true("render" %in% names(fig2$jsHooks))
  expect_false(is.null(fig2$jsHooks$render))
  expect_gt(length(fig2$jsHooks$render), 0)
  # By htmlwidget
  expect_s3_class(fig2, "htmlwidget")

})


test_that("ro_ply_keyboard_nav_trendline returns a plotly object", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_trendline(p)
  expect_s3_class(fig2, "plotly")
})

test_that("ro_ply_keyboard_nav_trendline uses onRender", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_trendline(p)
  # Check that jsHooks exists and has a render entry
  expect_false(is.null(fig2$jsHooks))
  expect_true("render" %in% names(fig2$jsHooks))
  expect_false(is.null(fig2$jsHooks$render))
  expect_gt(length(fig2$jsHooks$render), 0)
  # By htmlwidget
  expect_s3_class(fig2, "htmlwidget")

})


test_that("ro_ply_keyboard_nav_linechart returns a plotly object", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_linechart(p)
  expect_s3_class(fig2, "plotly")
})

test_that("ro_ply_keyboard_nav_linechart uses onRender", {
  #Note, this is a barchart. So the content of the function is not checked
  p <- plot_ly(x = 1:3, y = 3:1, type = "bar", orientation = "h")
  fig2 <- ro_ply_keyboard_nav_linechart(p)
  # Check that jsHooks exists and has a render entry
  expect_false(is.null(fig2$jsHooks))
  expect_true("render" %in% names(fig2$jsHooks))
  expect_false(is.null(fig2$jsHooks$render))
  expect_gt(length(fig2$jsHooks$render), 0)
  # By htmlwidget
  expect_s3_class(fig2, "htmlwidget")

})
