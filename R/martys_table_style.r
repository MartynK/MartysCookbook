#####
# Defining my favorite format for tables

#' Apply style to a given table
#'
#' This function applies a particular style to a table. The table can be a data frame,
#' a gtsummary table, or a knitr kable. Different processing steps are applied based 
#' on the class of the input table. 
#'
#' @param tabl The table to which the style should be applied.
#' @param alig. The alignment to be applied to the table. Default is "c" for center.
#' @param caption. The caption of the table. Default is the result of generate_tab_title().
#' @param scale_down. Logical, if TRUE, scales down the table if it is wider than the text width. Default is FALSE.
#' @param fontsize. The font size to be applied to the table. Default is 7.
#' @param landscape. Logical, if TRUE, the table will be displayed in landscape format. Default is TRUE.
#'
#' @return A table with the specified style applied.
#' 
#' @examples
#' \dontrun{
#' data(mtcars)
#' martys_table_style(mtcars)
#' }
#' @export
martys_table_style <- function( tabl, 
                                alig. = c("c"),
                                caption. = "",#generate_tab_title(),
                                scale_down. = FALSE,
                                fontsize. = 7,
                                landscape. = TRUE) {
  # Trying to handle both dataframes & gtsummaries (? tbl_summary type?)
  # Basically a wrapper functon 
  
  # require(huxtable)
  # require(gtsummary)
  # require(dplyr)
  # require(kableExtra)
  
  if ("data.frame" %in% class(tabl)) {
    # it is a 'simple' data.frame  
    tabl_kext <-
      tabl %>%
      flextable::flextable()
    
    
  } else if ("gtsummary" %in% class(tabl)) {
    # it is a gtsummary table
    tabl_kext <- 
      tabl %>%
      # Remove footnotes, indexed numbers
      modify_footnote(update = everything() ~ NA)  %>%
      # Remove "Characteristic from the top  left corner
      modify_header(label = "") %>%
      ## Group categories are now bold
      bold_labels()  %>%
      # sub-levels are in italic (may be a bit much)
      italicize_levels() %>%
      gtsummary::as_flex_table()
    
  } else if ("knitr_kable" %in% class(tabl)) {
    # NO BACK CONVERSION ALLOWED
    # Using a kableExtra call instead
    
    tabl_out <- tabl %>%
      kable_styling( position = "center",
                     latex_options = c("striped","repeat_header"
                                       ,"hold_position"
                     ),
                     stripe_color = "gray!10",
                     font_size = fontsize.
      ) %>%
      row_spec(0, bold = T, align = 'l')
    
    if (landscape. == TRUE) {
      # table should be rotated 90 deg
      tabl_out <- tabl_out %>%
        landscape() 
    }
    if (scale_down. == TRUE) {
      tabl_out <- tabl_out %>%
        kable_styling( latex_options = "scale_down")
    }
    return(tabl_out)
  }
  
  tabl_out <- tabl_kext %>%
    #theme_article() %>%
    theme_grey() %>%       # a more 'corporate' look :(
    set_font_size(fontsize.) %>%
    set_width(., .95) %>%
    set_number_format(NA) %>%
    set_valign(value="middle") %>%
    set_align(value = 'center') %>%
    set_align(value = 'left',col=1) %>%
    set_left_border( brdr(thickness = .8)) %>%
    set_right_border( brdr(thickness = .8)) %>%
    set_bottom_border( brdr(thickness = .8)) %>%
    set_top_border( brdr(thickness = .8)) %>%
    set_position("center") %>%
    set_caption(caption.) %>%
    set_latex_float("h")
  
  return( tabl_out)
}
