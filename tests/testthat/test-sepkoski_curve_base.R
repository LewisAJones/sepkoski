suppressPackageStartupMessages(library(vdiffr, quietly = TRUE))

test_that("sepkoski_curve_base() works", {
  expect_doppelganger("sepkoski_curve_base()", function() {
    sepkoski_curve_base()
  })
})

test_that("sepkoski_curve_base() works custom arguments", {
  expect_doppelganger("sepkoski_curve_base() custom arguments", function() {
    sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve"),
                        axis_args = list(intervals = list("stages", "periods"),
                                        lab = FALSE),
                        legend_args = list(bty = "o"))
  })
})

test_that("sepkoski_curve_base() no legend/axis", {
  expect_doppelganger("sepkoski_curve_base() no legend/axis", function() {
    sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve"),
                        axis_args = FALSE,
                        legend_args = FALSE)
  })
})

test_that("sepkoski_curve_base() error", {
  expect_error(sepkoski_curve_base(plot_args = FALSE))
  expect_error(sepkoski_curve_base(legend_args = TRUE))
  expect_error(sepkoski_curve_base(axis_args = c("FALSE")))
})

test_that("sepkoski_curve_base() col repeat", {
  expect_doppelganger("sepkoski_curve_base() col repeat", function() {
    sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve",
                                         col = "green"))
  })
})

