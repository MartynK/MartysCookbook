#' Get Current File Location
#'
#' This function returns the directory path of the current file in execution.
#' The function first checks if it is ran by another process 
#' (if there's a command argument '--file' and retrieves its value).
#' If not, the function then attempts to get the path 
#' from the active document in the RStudio source editor.
#' If this is also unsuccessful (for instance, if the function is being run
#' from a new, unsaved R script), 
#' the function prints a message indicating that the filename is blank.
#'
#' @return A character string with the directory path of the current file. 
#' If no file path is found, a message is printed and NULL is returned.
#' @export
#' @examples
#' \dontrun{
#' print(get_current_file_location())
#' }
#' @importFrom dplyr filter pull
#' @importFrom tibble enframe
#' @importFrom tidyr separate
#' @importFrom rstudioapi getSourceEditorContext
get_current_file_location <-  function()
{
  require(dplyr)
  this_file <- 
    #Pulls the different flags associated with the execution of the current file
    commandArgs() |> 
    # Turn it into a tibble
    tibble::enframe(name = NULL) |>
    # Separate keys and values (eg. this_key = 2 will b: this_key and 2)
    tidyr::separate(col=value, into=c("key", "value"), sep="=", fill='right') |>
    # See if there is a flag indicating a filename
    dplyr::filter(key == "--file") |>
    # And extract this
    dplyr::pull(value)

  if (length(this_file)==0)
  {
    # If there was no filename this was most likely ran from RStudio
    this_file <- rstudioapi::getSourceEditorContext()$path
  } 
  
  if( this_file=="") {
    # Handling the case where it was an unsaved script
    message("You are running code in RStudio in a new R script window, so the filename is blank.")
  }
  return(dirname(this_file))
}

#print(getCurrentFileLocation())