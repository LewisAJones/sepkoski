test_that("sepkoski_curve() works", {
  vdiffr::expect_doppelganger("sepkoski_curve()", function() {
    sepkoski_curve()
  })
})

test_that("sepkoski_curve() works with custom arguments", {
  vdiffr::expect_doppelganger("sepkoski_curve() with custom arguments", function() {
    sepkoski_curve(title = "Sepkoski's Compendium",
                   height = 0.1,
                   cols = "black",
                   int_lab = FALSE,
                   int_size = 0.5,
                   fill = TRUE,
                   legend = FALSE)
  })
})

test_that("sepkoski_curve() error handling", {
  expect_error(sepkoski_curve(title = 1))
  expect_error(sepkoski_curve(height = "2"))
  expect_error(sepkoski_curve(cols = 1))
  expect_error(sepkoski_curve(cols = TRUE))
  expect_error(sepkoski_curve(int_lab = 1))
  expect_error(sepkoski_curve(int_size = "1"))
  expect_error(sepkoski_curve(fill = 1))
  expect_error(sepkoski_curve(legend = 1))
  expect_error(sepkoski_curve(legend_size = "1"))
})

