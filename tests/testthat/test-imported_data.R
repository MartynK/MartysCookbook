library(testthat)
#context("Test imported data in conjunction with the data import snippet - TURNING OFF")



# test_that("Data frame has dimensions which make sense", {
#   load(here::here("data","data.rda"))
#   expect_equal(is.numeric(nrow(data)), TRUE)
#   expect_equal(ncol(data)>= nrow(descriptor), TRUE)
# })
# 
# # Test to check the class of each variable in the data frame based on descriptor
# 
# test_that("Data frame variables have correct class", {
#   for (i in seq_len(nrow(descriptor))) {
#     col_class <- class(data[[descriptor$name_new[i]]])
#     expected_class <- switch(descriptor$trf[i],
#                              "factor" = "factor",
#                              "numeric" = "numeric",
#                              "date" = "Date",
#                              "default")
#     expect_equal(col_class, expected_class, 
#                  info = paste0("Mismatch in column: ", descriptor$name_new[i]))
#   }
# })
# 
# # Test to check if there are any missing values in the data frame
# 
# test_that("Data frame has no missing values", {
#   expect_equal(sum(is.na(data)), 0,
#                info = "There are missing values in the data frame.")
# })
# 
# # Test to check the labels of each variable in the data frame
# 
# test_that("Data frame variables have correct labels", {
#   for (i in seq_len(nrow(descriptor))) {
#     label <- attr(data[[descriptor$name_new[i]]], "label")
#     expect_equal(label, descriptor$description[i],
#                  info = paste0("Mismatch in label for column: ", descriptor$name_new[i]))
#   }
# })