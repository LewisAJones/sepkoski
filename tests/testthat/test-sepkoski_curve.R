suppressPackageStartupMessages(library(ggplot2, quietly = TRUE))
suppressPackageStartupMessages(library(vdiffr, quietly = TRUE))

test_that("sepkoski_curve() works", {
  p <- sepkoski_curve()
  expect_doppelganger("sepkoski curve", p)
})

test_that("sepkoski_curve() works with customisation", {
  p <- sepkoski_curve() + theme_void()
  expect_doppelganger("sepkoski curve custom", p)
})
