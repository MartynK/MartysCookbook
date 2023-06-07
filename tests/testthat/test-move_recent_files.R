library(testthat)

test_that("move_recent_files correctly moves recent files", {
  
  # Temporary directory for testing
  temp_dir <- tempdir()
  old_dir <- file.path(temp_dir, "old_files")
  new_dir <- file.path(temp_dir, "vignettes")
  
  # Create directories
  dir.create(old_dir)
  dir.create(new_dir)
  
  # Create some test files
  old_file <- file.path(old_dir, "old.txt")
  new_file <- file.path(old_dir, "new.txt")
  
  # Create an "old" file (2 hours ago)
  writeLines("Old file", old_file)
  Sys.setFileTime(old_file, Sys.time() - lubridate::hours(2))
  
  # Create a "new" file (half an hour ago)
  writeLines("New file", new_file)
  Sys.setFileTime(new_file, Sys.time() - lubridate::minutes(5))
  
  # Test the function
  move_recent_files(temp_dir, "old_files", 1)
  
  # Check that the new file has been moved
  expect_true(file.exists(file.path(new_dir, "new.txt")))
  
  # Check that the old file has been moved
  expect_false(file.exists(file.path(old_dir, "old.txt")))
  
  # Clean up
  unlink(temp_dir, recursive = TRUE)
})