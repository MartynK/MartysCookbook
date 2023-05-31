# Data wrangling goes here


# Dependson:
#Not strictly necessary, but adding here for standalone executability
source(here::here("inst","functions","load_stuff.r")) 

descriptor <- read_excel(here::here("inst","extdata","description.xlsx"), skip = 0)

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
data <- here::here("inst","extdata","Iris.xls") %>%
                read_excel( ., skip = 0) %>%
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
  `var_label<-`(   labs  ) %>%
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
