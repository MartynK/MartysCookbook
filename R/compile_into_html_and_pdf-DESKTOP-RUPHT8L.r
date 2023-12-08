# setting up workflow for generating .html **and** .pdf outputs for a file

# Load necessary libraries
require(rmarkdown)
require(pagedown)


#' Compile an R Markdown file to multiple outputs
#'
#' This function takes an R Markdown file as input and generates three outputs:
#' an HTML document, a PDF-like HTML document using the pagedown package, and
#' a PDF document. If generating the PDF document fails (e.g., if Chrome is not 
#' installed), the function will still generate the PDF-like HTML document.
#'
#' @param input_file The path to the R Markdown file to be compiled.
#' @param max_wait Max. waittime (minutes) until the pdf finishes printing. 
#' Default = 10
#'
#' @return Invisibly returns NULL. The side effect of this function is that 
#' it writes the compiled documents to disk (same folder as source).
#' 
#' @importFrom rmarkdown render
#' @importFrom pagedown chrome_print
#' @importFrom here here
#'
#' @examples
#' \dontrun{
#' compile_rmd_multiple_outputs("path/to/your_file.Rmd")
#' }
#'
#' @export
compile_rmd_multiple_outputs <- function( input_file, max_wait = 10) {
  
  bname <- basename(input_file)
  file_name <- substr(bname, 1, nchar(bname)-4)
  directory_name <- dirname(input_file)
  
  # Define the output files
  output_file_html     <- paste0(directory_name, "/", file_name, ".html")
  output_file_pdf_like <- paste0(directory_name, "/", file_name,"_pdflike.html")
  output_file_pdf      <- paste0(directory_name, "/", file_name,".pdf")
  

  # Generate a PDF output using pagedown 
  tryCatch({
    # This also leaves the pdflike .html 
    pagedown::chrome_print(input_file, output = output_file_pdf)
  
    # Renaming output, this will be the pdflike .html version
    # Create a progress bar
    pb <- progress::progress_bar$new(
      format = "Waiting for file: [:bar] :elapsed s",
      total = max_wait * 60,  # convert minutes to seconds
      width = 60
    )
    
    # Start waiting for the file
    for(i in 1:(max_wait * 60)) {
      if(file.exists(output_file_pdf)) {
        message("File found!")
        break
      }
      
      # If file doesn't exist, wait for 1 second then update the progress bar
      Sys.sleep(1)
      pb$tick()
    }
    
    pb$terminate()
    
    # If the file still doesn't exist after the maximum wait time, print a message
    if(!file.exists(output_file_pdf)) {
      error("PDF not found after waiting for ", max_wait, " minutes.")
      render(input_file, "pagedown::thesis_paged", output_file = output_file_pdf_like)
    }
  },
  error = function(e) {
      if(!file.exists(output_file_pdf)) {
      print("There was an error!")
      render(input_file, "pagedown::thesis_paged", output_file = output_file_pdf_like)
      }
  })
  
  # renaming output to denote that its the pdf-like one
  file.rename( output_file_html, output_file_pdf_like)

  
  # Generate the 'vanilla' HTML output
  render(input_file, "html_document", output_file = output_file_html)

}

# input_file <- here::here("inst", "example_thesis", "example-thesis.Rmd")
# compile_rmd_multiple_outputs(input_file)