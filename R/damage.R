#' Apply a simple damage function
#'
#' @param exposure An exposure object
#' @param intensity Numeric vector of hazard intensity (same length)
#' @param curve A function mapping intensity → damage ratio
#'
#' @export
apply_damage <- function(exposure, intensity, curve) {
  validate_exposure(exposure)

  if (length(intensity) != nrow(exposure)) {
    rlang::abort("Intensity vector must match exposure rows.")
  }

  damage_ratio <- curve(intensity)
  damage_ratio <- pmin(pmax(damage_ratio, 0), 1)

  value_col <- attr(exposure, "value_col")

  exposure$damage_ratio <- damage_ratio
  exposure$loss_proxy  <- exposure[[value_col]] * damage_ratio

  exposure
}
