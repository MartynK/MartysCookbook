#' Precompiles a quick vignette from a computationally expensive report
#'
#' This function takes an R Markdown file that generates a computationally expensive report
#' and turns it into a quicker markdown document. This markdown document is intended to be 
#' turned into a vignette. This is achieved by copying the .Rmd file, renaming it to .Rmd.orig,
#' and knitting it with the output sent to a "vignettes/" directory. The function will also 
#' move any figures generated in the project directory to the "vignettes/" directory.
#' If a PDF of the report is available, it will also be copied to the "docs/articles/" directory.
#'
#' @param input_file The name of the .Rmd file to be precompiled (must include the ".rmd" extension)
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
precompile_quick_vignette <- function(input_file) {

  bname <- basename(input_file)
  file_name <- substr(bname, 1, nchar(bname)-4)
  directory_name <- dirname(input_file)
  
  # Check if file exists
  if ( !file.exists(input_file)) {
    stop("Error: File does not exist")
  } else  if (!(substr(bname, nchar(bname)-3, nchar(bname)) %in% 
                c(".rmd",".Rmd"))) {
    # Check extension
    stop("Error: 'file_name' should end with .rmd")
  }
  
  
  # create a directory for all the output
  dir_name <- paste0(directory_name, "/", file_name)
  dir.create( dir_name, showWarnings = FALSE)
  
  # Define the filenames
  orig_file_name   <- paste0(directory_name, "/", 
                             file_name, "/", file_name, ".rmd")
  output_file_name <- paste0(directory_name, "/", 
                             file_name, "/", file_name, "_quick.rmd")
  
  # Copy and rename
  file.copy(input_file, orig_file_name, overwrite = TRUE)
  
  # knit the original file to de facto .md format
  message("Attempting to knit the .Rmd file")
  tryCatch({
    knitr::knit(orig_file_name, output = output_file_name)
    message("Knitting done without errors!")
  }, error = function(e) {
    stop("The file ran into some problems")
  })
  
  # The figures will be put in the project dir, have to clean it up
  project_dir <- here::here()
  
  old_dir_name    <- paste0(project_dir,"/",file_name,"_files/figure-latex") 
  new_dir_name    <- paste0(dir_name,"/figure")
  
  # # DEBUG output
  # print( c( old_dir_name, 
  #           new_dir_name
  #           ))
  
  move_recent_files(old_dir_name, new_dir_name)
  
  old_dir_name2    <- paste0(project_dir,"/figure") 
  move_recent_files(old_dir_name2, new_dir_name)
  
  
}

# input_file <- here::here("inst","cookbook.rmd")
# precompile_quick_vignette(input_file)

