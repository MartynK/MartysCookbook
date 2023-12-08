# Data wrangling goes here

# # Dependson:
# #Not strictly necessary, but adding here for standalone executability
# source(here::here("inst","functions","load_stuff.r")) 

descriptor <- file.path(data_directory,"description.xlsx") %>% readxl::read_excel(skip = 0)

# make a list to be used as labels for 'labelled::'
labs <- 
  # take a 1xN matrix
  matrix( descriptor$description,
          ncol = length(descriptor$description)
  ) %>% 
  as.list() %>%
  # add column names as 'names'
  `names<-`(descriptor$name_new)

# Making the actual dataset
data <- file.path(data_directory,"Iris.xls") %>%
  readxl::read_excel( ., skip = 0) %>%
  mutate( across( .cols = which( descriptor$trf == "factor"),
                  .fns = as.factor
  ),
  across( .cols = which( descriptor$trf == "numeric"),
          .fns = as.numeric # removing potential '?', 'NA', '.' etc.
  ),
  across( .cols = which( descriptor$trf == "date"),
          .fns = as_date # works only if excel recognizes the date..(?)
  )
  ) %>%
  `colnames<-`( descriptor$name_new) %>%
  labelled::`var_label<-`(   labs  ) %>%
  mutate( 
    # making up a new variable as an example
    newvar = petal_width + sepal_width
  ) %>%
  # This is how to set up the labels for new variables
  `var_label<-`( list(newvar = "This is my new example variable, adding up the lengths")) %>%
  # One of these days I'm gonna learn when to use this
  rowwise() %>%
  mutate(
    mock_ID = runif(1, .1, 20) %>% round
  )

#' Modified Iris Dataset
#'
#' This is the famous Iris dataset, often used for teaching and demonstrating
#' machine learning algorithms. The dataset consists of measurements of 
#' 150 iris flowers from three different species.
#' 
#' I've modified it to demonstrate basic dplyr style wrangling
#'
#' @format A data frame with 150 rows and 9 variables:
#' \describe{
#'   \item{species_no}{Numeric representation of species. It is a numeric vector of length 150 with no missing values and 3 distinct values.}
#'   \item{petal_width}{These are the width of the petals. It is a numeric vector of length 150 with no missing values and 22 distinct values.}
#'   \item{petal_length}{These are the length of the petals. It is a numeric vector of length 150 with no missing values and 43 distinct values.}
#'   \item{sepal_width}{These are the width of the sepals. It is a numeric vector of length 150 with no missing values and 23 distinct values.}
#'   \item{sepal_length}{These are the length of the sepals. It is a numeric vector of length 150 with no missing values and 35 distinct values.}
#'   \item{species_char}{Character representation of the species. It is a factor with 150 levels and 3 distinct values.}
#'   \item{date}{This is a date column to illustrate transformations. It is a Date vector of length 150 with no missing values and 150 distinct values.}
#'   \item{newvar}{This is a new example variable, adding up the lengths. It is a numeric vector of length 150 with no missing values and 42 distinct values.}
#'   \item{mock_ID}{It is a numeric vector of length 150 with no missing values and 21 distinct values.}
#' }
"data"