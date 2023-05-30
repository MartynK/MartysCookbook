# script for fooing around with chatGPT
# NOTE: I have my secret API key in there

Sys.setenv(OPENAI_API_KEY = "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")


martyfun <- function( inp = 4) {
  out <- 0
  for (i in 1:inp) {
    out <- out + i
  }
  return(out)
}

library(chatgpt)

#cat(create_variable_name(capture.output(martyfun)))

cat(document_code("square_numbers <- function(numbers) numbers ** 2"))

# https://platform.openai.com/docs/api-reference/completions/create
Sys.setenv(OPENAI_TEMPERATURE = .9) # more 'creative' behaviour, max = 1
cat(document_code("square_numbers <- function(numbers) numbers ** 2"))

Sys.setenv(OPENAI_TEMPERATURE = .7, 
           OPENAI_TOP_P = .02) # alternative behaviour (p is a probability)
cat(document_code("square_numbers <- function(numbers) numbers ** 2"))


