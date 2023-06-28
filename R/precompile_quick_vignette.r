#' Precompiles a quick vignette from a computationally expensive report
#'
#' This function takes an R Markdown file that generates a computationally expensive report
#' and turns it into a quicker markdown document. The function will also 
#' move any figures generated in the project directory to the "/figures" directory.
#'
#' @param input_file The name of the .Rmd file to be precompiled (must include the ".rmd" extension)
#' @param pics_dirs The name of the directory in which relevant pictures are to be found after precompilation
#'
#' @return Invisible NULL; the output will be in the same directory as the source named ..._quick.Rmd
#' 
#' @references https://ropensci.org/blog/2019/12/08/precompute-vignettes/
#'
#' @export
#' @examples
#' \dontrun{
#' precompile_quick_vignette("example_report.rmd")
#' }
precompile_quick_vignette <- function(input_file, pics_dirs = c()) {

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
  
  # Rename .Rmd into something thats not recognized as Rmd
  temp_file_name <- paste0(input_file,".orig")
  file.copy( input_file, temp_file_name)

  # Define the filenames
  output_file_name <- paste0(directory_name, "/", 
                             file_name, "_quick.rmd")
  
  # knit the original file to de facto .md format
  message("Attempting to knit the .Rmd file")
  tryCatch({
    knitr::knit(temp_file_name, output = output_file_name)
    message("Knitting done without errors!")
  }, error = function(e) {
    stop("The file ran into some problems")
  })
  
  if (pics_dirs > 0) {
    for (i in 1:length(pics_dirs)) {
      old_dir_name    <- pics_dirs[i]
      new_dir_name    <- paste0(directory_name,"/figure")
      
      move_recent_files(old_dir_name, new_dir_name)
    }
  }

}

# input_file <- here::here("inst","cookbook.rmd")
# precompile_quick_vignette(input_file)

