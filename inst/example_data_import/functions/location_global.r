relpath <- here::here("inst","example_data_import")

# This is an embarrasing file... have to declare the 'actual'  place of the 
# folder and would update it 'as needed' based on the script below.
# This is to ensure that when 'precompiling' I can effectively control the
# links to the figures with all the relative path nonsense going on in the 
# background with knit()
# If this wasn't bad enough, when copied, the copies 'loose their effect'... :)


# # Read the file into a character vector.
# lines <- readLines(filename)
# 
# # Replace the first line.
# lines[1] <- 'here::here("inst","example_data_import")'
# 
# # Write the character vector back to the file.
# writeLines(lines, filename)
