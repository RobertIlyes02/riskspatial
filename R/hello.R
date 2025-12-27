# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

usethis::use_package("sf")
usethis::use_package("rlang")
usethis::use_package("vctrs")
usethis::use_package("dplyr")

hello <- function() {
  print("Hello, world!")
}
