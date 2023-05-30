# Defining custom functions

#####
# Defining my favorite ggplot theme with 'correct' caption placement
theme_default_ggplot <- theme_bw() +
  theme( legend.position = "none",
         plot.caption = element_text( vjust = .0,
                                      hjust = .0,
                                      margin = margin( t = 15)),
         text = element_text( family = "serif"))

#####
# Defining my favorite format for tables
#####
# Defining my favorite format for tables

martys_table_style <- function( tabl, 
                                alig. = c("c"),
                                caption. = generate_tab_title(),
                                scale_down. = FALSE,
                                fontsize. = 7,
                                landscape. = TRUE) {
  # Trying to handle both dataframes & gtsummaries (? tbl_summary type?)
  # Basically a wrapper functon 
  
  if ("data.frame" %in% class(tabl)) {
    # it is a 'simple' data.frame  
    tabl_kext <-
      tabl %>%
      as_hux()
    
    
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
      as_hux_table()
    
  } else if ("knitr_kable" %in% class(tabl)) {
    # NO BACK CONVERSION ALLOWED
    # Using a kableExtra call instead
    
    tabl_kext <- tabl
    
    tabl_kext %>%
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
    return(table_out)
  }
  
  tabl_out <- tabl_kext %>%
    #theme_article() %>%
    theme_grey() %>%       # a more 'corporate' look :(
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


