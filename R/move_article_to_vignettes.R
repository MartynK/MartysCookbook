

move_article_to_vignettes <- function( source_file, only_this_step = FALSE) {
  # Moves the article from the article's folder
  # and updates the relative paths info for the figures
  
  article_filename <- basename(source_file)
  source_dir       <- dirname(source_file)
  article_dirname  <- basename(source_dir)
  
  # Set target path
  target_dirname  <- file.path(here::here(),
                               "vignettes",
                               article_dirname)
  
  
  # Replacing the location in the location_global.r file
  location_filename <- here::here(source_dir,
                                  "functions","location_global.r")
  # Read the file into a character vector.
  lines <- readLines(location_filename)
  
  # Backup to be replaced later
  orig_lines <- lines

  # Replace the first line.
  lines[1] <- paste0('relpath <- here::here("vignettes","',
                      article_dirname,
                      '")'
              )

  # Write the character vector back to the file.
  writeLines(lines, location_filename)
  
  # Copies the dir
  R.utils::copyDirectory(source_dir, 
                         target_dirname)
  
  # # If it doesn't exist, this will create it
  # writeLines(target_dirname, file.path(target_dirname, "_location.txt"))
  
  if (only_this_step == FALSE) {
    
    #wrong filename?
    file.path(target_dirname, article_filename) %>%
      precompile_quick_vignette() # Precompilation step
    
    quick_filename <- 
      article_filename %>% 
      sub("^_", "", .) %>% # removes first "_" if has any from filename
                           # (precompile...() does it also)
      file.path(target_dirname, .) %>%
        sub("\\.Rmd$", "_quick.Rmd", .)
    
    print(quick_filename)

    compile_rmd_multiple_outputs(quick_filename)  # get pdflike & pdf outputs
    
    sub(".*vignettes/(.*).Rmd", "\\1", quick_filename) %>%
      pkgdown::build_article(.) # builds the articles
    
    # Copies the dir with figures, *DOES NOT OVERWRITE NEW HTML*
    R.utils::copyDirectory(target_dirname, # origin, eg. Vignettes 
                           file.path(here::here(),
                                     "docs",
                                     "articles",
                                     article_dirname),
                           overwrite = FALSE)
    
    # Returning the location_global.r to its former state
    writeLines(orig_lines, location_filename)
    
  } else {
    
    # Cleanup
    # Returning the location_global.r to its former state
    writeLines(orig_lines, location_filename)
  }
  
}


# here::here("inst","example_data_import","_data_import.Rmd") %>%
#   move_article_to_vignettes()
