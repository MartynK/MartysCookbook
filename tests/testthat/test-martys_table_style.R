library(testthat)
#context("Test martys_table_style")

test_that("martys_table_style works with data.frame", {
  # generate a simple data frame
  df <- data.frame(
    A = 1:5,
    B = letters[1:5]
  )
  
  # apply function
  result <- martys_table_style(df)
  
  # Test that the result is of the correct class
  expect_is(result, "huxtable")
})

test_that("martys_table_style works with gtsummary", {
  # assuming that you have gtsummary installed and tbl_summary function is available
  library(gtsummary)
  data(mtcars)
  
  # Creating a simple gtsummary table
  gt_tbl <- gtsummary::tbl_summary(mtcars)
  
  # Apply function
  result <- martys_table_style(gt_tbl)
  
  # Test that the result is of the correct class
  expect_is(result, "huxtable")
})

test_that("martys_table_style works with knitr_kable", {
  # assuming that you have knitr installed
  library(knitr)
  
  df <- data.frame(
    A = 1:5,
    B = letters[1:5]
  )
  
  # Creating a simple kable
  knitr_tbl <- kable(df)
  
  # Apply function
  result <- martys_table_style(knitr_tbl)
  
  # Test that the result is of the correct class
  expect_is(result, "kableExtra")
})