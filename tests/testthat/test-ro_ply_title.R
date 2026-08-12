test_that("ro_ply_title adds main title as annotation", {
  library(plotly)
  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_titled <- ro_ply_title(fig, title = "My Title", base_family = "Arial", title_color = "#000000")

  layout_annots <- lapply(fig_titled$x$layoutAttrs, function(x) x$annotations)
  layout_annots <- Filter(Negate(is.null), layout_annots)
  annots <- unlist(layout_annots, recursive = FALSE)

  expect_length(annots, 1)
  expect_true(grepl("My Title", annots[[1]]$text))
  expect_identical(annots[[1]]$xanchor, "left")
  expect_identical(annots[[1]]$font$family, "Arial")
  expect_identical(annots[[1]]$font$color, "#000000")
})

test_that("ro_ply_title adds y_label as annotation", {
  library(plotly)
  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_titled <- ro_ply_title(fig, y_label = "Aantal gevallen", base_family = "Arial", title_color = "#000000")

  layout_annots <- lapply(fig_titled$x$layoutAttrs, function(x) x$annotations)
  layout_annots <- Filter(Negate(is.null), layout_annots)
  annots <- unlist(layout_annots, recursive = FALSE)

  expect_length(annots, 1)
  expect_identical(annots[[1]]$text, "Aantal gevallen")
  expect_identical(annots[[1]]$x, 0)
  expect_identical(annots[[1]]$y, 1)
  expect_identical(annots[[1]]$font$family, "Arial")
})

test_that("ro_ply_title adds all three annotations", {
  library(plotly)
  fig <- plot_ly(x = 1:3, y = 1:3)
  fig_titled <- ro_ply_title(
    fig,
    title = "Hoofdtitel",
    y_label = "Aantal gevallen",
    x_label = "Groepen",
    base_family = "Arial",
    title_color = "#112233"
  )

  layout_annots <- lapply(fig_titled$x$layoutAttrs, function(x) x$annotations)
  layout_annots <- Filter(Negate(is.null), layout_annots)
  annots <- unlist(layout_annots, recursive = FALSE)

  expect_length(annots, 3)
  expect_true(any(grepl("Hoofdtitel", sapply(annots, function(a) a$text))))
  expect_true(any(sapply(annots, function(a) a$text == "Aantal gevallen")))
  expect_true(any(sapply(annots, function(a) a$text == "Groepen")))

  for (a in annots) {
    expect_identical(a$font$family, "Arial")
    expect_identical(a$font$color, "#112233")
  }
})
