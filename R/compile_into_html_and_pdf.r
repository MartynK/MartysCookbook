# setting up workflow for generating .html **and** .pdf outputs for a file

# Load necessary libraries
require(rmarkdown)
require(pagedown)


compile_rmd_multiple_outputs <- function( input_file) {

  bname <- basename(input_file)
  file_name <- substr(bname, 1, nchar(bname)-4)
  
  
  # Define the output files
  output_file_html     <- here::here("inst", paste0(file_name,".html"))
  output_file_pdf_like <- here::here("inst", paste0(file_name,"_pdflike.html"))
  output_file_pdf      <- here::here("inst", paste0(file_name,".pdf"))
  

  # Generate a PDF output using pagedown
  tryCatch({
    # This also leaves the pdflike .html 
    pagedown::chrome_print(input_file, output = output_file_pdf)
    # Renaming output, this will be the pdflike .html version
    rename( output_file_html, output_file_pdf_like)
  },
  error = function(e) {
    # If above failes (due to no chrome for ex.), at least generate the .html
    render(input_file, "pagedown::thesis_paged", output_file = output_file_pdf_like)
  })
  
  # Generate an HTML output
  render(input_file, "html_document", output_file = output_file_html)

}

input_file <- here::here("inst", "example-thesis.Rmd")
compile_rmd_multiple_outputs(input_file)