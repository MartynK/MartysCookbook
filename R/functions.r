
require(roxygen2)
require(ggplot2)
require(gtsummary)
# Defining custom functions


#####
# Defining my favorite ggplot theme with 'correct' caption placement


#' Default Theme for ggplot
#'
#' This function applies a pre-specified theme to a ggplot object. The theme 
#' is based on the 'theme_bw' function from the 'ggplot2' package and adds 
#' some modifications. Specifically, it removes the legend, adjusts the plot 
#' caption, and changes the font family to "serif".
#' 
#' @return A ggplot theme object that can be added to a ggplot.
#' @export
#' @examples
#' \dontrun{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(mpg, cyl)) + geom_point()
#' p + theme_default_ggplot()
#' }
theme_default_ggplot <- theme_bw() +
  theme( legend.position = "none",
         plot.caption = element_text( vjust = .0,
                                      hjust = .0,
                                      margin = margin( t = 15)),
         text = element_text( family = "serif"))




