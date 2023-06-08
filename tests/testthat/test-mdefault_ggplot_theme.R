library(testthat)
#context("Test theme_default_ggplot")

test_that("theme_default_ggplot properties are correct", {
  theme <- theme_default_ggplot
  
  # Check that theme is a ggplot2 theme object
  expect_true(inherits(theme, "theme"))
  
  # Check that legend.position is set to "none"
  expect_identical(theme$legend.position, "none")
  
  # Check that text family is set to "serif"
  expect_identical(theme$text$family, "serif")
  
  # Check that plot.caption vjust is set to .0
  expect_identical(theme$plot.caption$vjust, .0)
  
  # Check that plot.caption hjust is set to .0
  expect_identical(theme$plot.caption$hjust, .0)
  
  # Check that plot.caption margin is set correctly
  expect_identical(theme$plot.caption$margin, ggplot2::margin( t = 15))
})