#' validate_exposure
#'
#' @param x Of Class Exposure
#'
#' @returns A True/False value
#' @export
#'
#' @examples
validate_exposure <- function(x) {
  if (!inherits(x, "exposure")) {
    rlang::abort("Object must be of class <exposure>.")
  }

  if (is.null(attr(x, "value_col"))) {
    stop("Exposure metadata is missing 'id_col'.")
  }
  if (is.null(attr(x, "id_col"))) {
    stop("Exposure metadata is missing 'value_col'.")
  }

  id_col    <- attr(x, "id_col")
  value_col <- attr(x, "value_col")

  if (anyDuplicated(x[[id_col]])) {
    rlang::abort("Duplicate exposure IDs detected.")
  }
  neg_count <- sum(x[[attr(x, "value_col")]] < 0, na.rm = TRUE)
  if (neg_count > 0) {
    rlang::warn(sprintf("%s negative exposure values detected.", neg_count))
  }

  invisible(TRUE)
}

