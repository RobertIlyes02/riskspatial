#' Create an exposure (in-force) object
#'
#' @param x An sf object with POINT geometry
#' @param id Column name for exposure ID
#' @param value Column name for exposure value (e.g. TIV)
#'
#' @return An object of class `exposure`
#' @export
exposure <- function(x, id, value) {
  stopifnot(inherits(x, "sf"))

  id    <- rlang::ensym(id)
  value <- rlang::ensym(value)

  if (!all(sf::st_is(insurance_data_sf, "POINT"))) {
    rlang::abort("Exposure geometry must be POINT.")
  }

  if (!(rlang::as_string(id) %in% names(x))){
    rlang::abort("Id column not in column names.")
  }

  if (!(rlang::as_string(value) %in% names(x))){
    rlang::abort("Value column not in column names.")
  }

  if (anyDuplicated(x[[rlang::as_string(id)]])) {
    rlang::abort("Exposure IDs must be unique.")
  }

  if (any(x[[rlang::as_string(value)]] < 0, na.rm = TRUE)) {
    rlang::abort("Exposure values must be non-negative.")
  }


  attr(x, "id_col")    <- rlang::as_string(id)
  attr(x, "value_col") <- rlang::as_string(value)

  class(x) <- c("exposure", class(x))
  x
}


CalculateEarnedExposure <- function(x, Start_Date, End_Date){


}
