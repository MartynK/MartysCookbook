#' Move Recent Files from One Directory to Another
#'
#' This function moves files from one directory to another that were modified within the last hour.
#' It is specifically designed to work within a project directory structure, taking files (figures) from a source
#' directory and moving them to a "vignettes" directory within the project.
#'
#' @param old_dir_name A character string specifying the root directory of the project.
#' @param new_dir_name A character string specifying the name of the source directory (without path), from which files are to be moved. 
#' For example: "<new_dir_name>_files/figure-latex".
#' @param delay_hs Amount of time in which the files are considered 'recent' in hours. Defaults to '1'.
#' 
#' @return This function does not return a value. It is called for its side effect of moving files.
#' If no files are found in the source directory, the function will stop and return an error message.
#' Unfortunately it deletes only the last folder.
#' 
#' @examples
#' \dontrun{
#' move_recent_files("path/to/project", "myfolder")
#' }
#' 
#' @note This function requires the 'lubridate' package to determine which files are less than an hour old.
#' @export
move_recent_files <- function(old_dir_name, new_dir_name, delay_hs = 1) {
  
  # Directory paths
  from_dir <- file.path(old_dir_name)
  to_dir   <- file.path(new_dir_name)
  
  # Check if destination directory exists, if not create it
  if (!dir.exists(to_dir)) {
    dir.create(to_dir, recursive = TRUE)
  }
  
  # Get files in the directory
  files <- list.files(from_dir, full.names = TRUE)
  
  # Check if there are no files
  if (length(files) == 0) {
    stop("No files in the source directory.")
  }
  
  # Check which files are less than an hour old
  recent_files <- files[file.info(files)$mtime > 
                          Sys.time() - lubridate::hours(delay_hs)]
  
  # Move the recent files
  file.rename(recent_files, file.path(to_dir, basename(recent_files)))
  
  # Delete the source directory
  unlink(from_dir, recursive = TRUE)
}


#move_recent_files(here::here("figures"),here::here("vignettes"))