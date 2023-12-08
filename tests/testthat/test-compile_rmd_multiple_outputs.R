# load necessary package
library(testthat)

# define the path to your test file
input_file <- here::here("tests","testthat","testfiles","example-thesis.Rmd")

# define the names of the expected output files
output_file_html     <- sub(".Rmd", ".html", input_file)
output_file_pdf_like <- sub(".Rmd", "_pdflike.html", input_file)
output_file_pdf      <- sub(".Rmd", ".pdf", input_file)

# wrap the tests in a test_that function
test_that("compile_rmd_multiple_outputs works as expected", {
  
  # test if the function runs without errors
  expect_error(compile_rmd_multiple_outputs(input_file), NA)
  
  # test if the HTML file is created
  expect_true(file.exists(output_file_html))
  
  # test if the PDF-like HTML file is created
  expect_true(file.exists(output_file_pdf_like))
  
  # test if the PDF file is created
  expect_true(file.exists(output_file_pdf))
  
})

# don't forget to delete the output files after the test
unlink(output_file_html)
unlink(output_file_pdf_like)
unlink(output_file_pdf)