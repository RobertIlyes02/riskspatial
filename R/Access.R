get_exposure_values <- function(x) {
  value_col <- attr(x, "value_col")
  if (is.null(value_col)) {
    rlang::abort("This object has no value column defined.")
  }
  x[[value_col]]
}


get_id_values <- function(x){
  id_col <- attr(x, "id_col")
  if (is.null(id_col)){
    rland::abort("This object has no id column define")
  }
  x[[id_col]]
}
