

theme_marty <- 
  function(x, bold_header = FALSE, odd_header = "grey80", odd_body = "grey95",
           even_header = "transparent", even_body = "transparent") {
    require(flextable)
    
    if (!inherits(x, "flextable")) {
      stop(sprintf("Function `%s` supports only flextable objects.", "theme_booktabs()"))
    }
    
    big_border <- officer::fp_border(width = 1.5,
                                     color = "black")
    std_border <- update(big_border, width = 0.75)
    
    h_nrow <- nrow_part(x, "header")
    f_nrow <- nrow_part(x, "footer")
    b_nrow <- nrow_part(x, "body")
    
    x <- border_remove(x)
    x <- align(x = x, align = "center", part = "header")
    
    if (h_nrow > 0) {
      x <- hline_top(x, border = big_border, part = "header")
      x <- hline(x, border = std_border, part = "header")
      x <- hline_bottom(x, border = big_border, part = "header")
      x <- bold(x, bold = bold_header, part = "header")
      
      even <- seq_len(h_nrow) %% 2 == 0
      odd <- !even
      
      x <- bg(x = x, i = odd, bg = odd_header, part = "header")
      x <- bg(x = x, i = even, bg = even_header, part = "header")
      x <- bold(x = x, bold = TRUE, part = "header")
    } else if (b_nrow > 0) {
      x <- hline_top(x, border = big_border, part = "body")
    } else if (f_nrow > 0) {
      x <- hline_top(x, border = big_border, part = "body")
    }
    
    if (f_nrow > 0) {
      x <- hline_bottom(x, border = big_border, part = "footer")
      
      even <- seq_len(f_nrow) %% 2 == 0
      odd <- !even
      
      x <- bg(x = x, i = odd, bg = odd_header, part = "footer")
      x <- bg(x = x, i = even, bg = even_header, part = "footer")
      x <- bold(x = x, bold = TRUE, part = "footer")
    }
    if (b_nrow > 0) {
      x <- hline_bottom(x, border = big_border, part = "body")
      
      even <- seq_len(b_nrow) %% 2 == 0
      odd <- !even
      
      x <- bg(x = x, i = odd, bg = odd_body, part = "body")
      x <- bg(x = x, i = even, bg = even_body, part = "body")
    }
    
    x <- font(x, part = "all", fontname = "Times New Roman")
    x <- fontsize(x, part = "all", size = 9)
    x <- valign(x, valign = "center", part = "all")
    x <- align(x, align = "center", part = "all")
    x <- align_text_col(x, align = "left", header = TRUE)
    x <- colformat_double(x, digits = 2)
    fix_border_issues(x)
  }