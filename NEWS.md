# MartysCookbook 0.3.0

## Fixes

- 'Cookbook' transformed to Quarto

## Issues

- Should double-check function documentation
- Cookbook 'appendix' missing(?)
- Cyclic call's two plots not side-by-side

## Notes

- Planning on cutting the whole 'precompilation' thing; comp.intensive stuff should be stored in a separate folder

# MartysCookbook 0.2.2

## New features

## Fixes

- Much better 'Cookbook'
- Fixed reference for 'Relevel'

## Issues

- Should double-check function documentation
- Cookbook 'appendix' missing(?)
- Cookbook cyclic figures wont survive recompilation
- Cookbook .pdf version won't compile
- Cyclic call's two plots not side-by-side
- 'Precompiled' figures are at the same place they should be, their manipulation cumbersome & unnecessary

## Notes

# MartysCookbook 0.2.1

## New features

- New easy-to-compile .Rmd *Relevel* added

## Fixes

## Issues

- Compiled vignettes missing some(?) pictures
- 'Cookbook' uses old workflow, sig.pg. ugly
- Should figure out figures
- Should double-check function documentation
- Tables in 'Cookbook' look like sh*t

## Notes


# MartysCookbook 0.2.0

## New features

- Implemented 'renv'

## Fixes

- Updated email

## Issues

- Compiled vignettes missing some(?) pictures
- Vignette won't compile outside *pkgdown::build_site()*
- PDF version should be updated (or automatically generated)
- Should compile a nicer signature page

## Notes

- Stable; *devtools::test()* and *devtools::check(document = FALSE, vignettes = FALSE)* both run.


# MartysCookbook 0.1.1

## New features

- Updated website
- Automated compiling quick-to-compile 'vignettes' (*precompile_quick_vignette()*)
- Missing unit tests for *precompile_quick_vignette()* (hard since involves file manipulation/compilation)

## Issues

- Compiled vignettes missing some(?) pictures
- Should compile a nicer signature page


# MartysCookbook 0.1.0

## New features

- First release of my package.
