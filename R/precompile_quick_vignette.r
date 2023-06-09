#' Precompiles a quick vignette from a computationally expensive report
#'
#' This function takes an R Markdown file that generates a computationally expensive report
#' and turns it into a quicker markdown document. This markdown document is intended to be 
#' turned into a vignette. This is achieved by copying the .Rmd file, renaming it to .Rmd.orig,
#' and knitting it with the output sent to a "vignettes/" directory. The function will also 
#' move any figures generated in the project directory to the "vignettes/" directory.
#' If a PDF of the report is available, it will also be copied to the "docs/articles/" directory.
#'
#' @param file_name The name of the .Rmd file to be precompiled (must include the ".rmd" extension)
#'
#' @return Invisible NULL
#' 
#' @references https://ropensci.org/blog/2019/12/08/precompute-vignettes/
#'
#' @export
#' @examples
#' \dontrun{
#' precompile_quick_vignette("example_report.rmd")
#' }
precompile_quick_vignette <- function(file_name) {

  project_dir <- here::here()
  
  # Check extension
  if (!grepl("\\.rmd$", paste0(project_dir,"/inst/",file_name))) {
    stop("Error: 'file_name' should end with .rmd")
  }
  
  # Define the paths
  file_path   <- paste0(project_dir, "/inst/", file_name)
  orig_file_path   <- paste0(project_dir, "/inst/", file_name, ".orig")
  output_file_path <- paste0(project_dir, "/vignettes/simple_", file_name)
  
  # Check if file exists
  if ( !file.exists(file_path)) {
    stop("Error: File does not exist")
  }
  
  # Copy and rename
  file.copy(file_path, orig_file_path, overwrite = TRUE)
  
  # knit the original file and send the output to "vignettes/..."
  message("Attempting to knit the .Rmd file")
  tryCatch({
    knitr::knit(orig_file_path, output = output_file_path)
    message("Knitting done without errors!")
  }, error = function(e) {
    stop("The file ran into some problems")
  })
  
  # The figures will be put in the project dir, have to clean it up
  plain_file_name <- substr(file_name,1,(nchar(file_name)-4))
  common_dir_name <- paste0(plain_file_name,"_files")
  old_dir_name    <- paste0(project_dir,"/",common_dir_name,"/figure-latex") 
  new_dir_name    <- paste0(project_dir,"/docs/articles/figure")
  
  # # DEBUG output
  # print( c( old_dir_name, 
  #           new_dir_name
  #           ))
  
  move_recent_files(old_dir_name, new_dir_name)
  
  old_dir_name2    <- paste0(project_dir,"/figure") 
  move_recent_files(old_dir_name2, new_dir_name)
  
  
  # If the .pdf available, grab that too
  pdf_name      <- paste0(project_dir,"/inst/",plain_file_name, ".pdf")
  pdf_dest_name <- paste0(project_dir,"/docs/articles/",plain_file_name, ".pdf")
  if( file.exists(pdf_name)) {
    file.copy(pdf_name, 
              pdf_dest_name,
              overwrite = TRUE)
  }
  
  
}


#precompile_quick_vignette("cookbook.rmd")

