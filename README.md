# MartysCookbook
Examples n' things for my R work

The output is under the 'articles' menu [here](https://martynk.github.io/MartysCookbook/).

# Notes

Ran *usethis::use_mit_license("Márton Kiss")* to set up the licence.  

Ran *devtools::document()* to make the NAMESPACE document.  

Use *devtools::test()* to run the unit test(s).  

Website made by *pkgdown::build_site()*.

Use *devtools::check(document = FALSE, vignettes = FALSE)* to check the panckage's integrity.

Use *devtools::install()* to compile the package.

This is *the* goldmine for setting up your pkgdown site:
https://pkgdown.r-lib.org/articles/customise.html 

This is how we should approach long reports & vignette formats:
https://ropensci.org/blog/2019/12/08/precompute-vignettes/ 

Using 'renv' for package for version control.
Need to specify *Sys.setenv(RENV_DOWNLOAD_METHOD = "libcurl")* in order to work.

For pdf outputs, use the *ELSEVIER* *rticles* template (new *R markdown* and *from template*). Its awesome. Most other formats have some shtick which didn't appeal to me.






