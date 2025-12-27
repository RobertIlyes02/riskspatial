# Function to Print the Exposure Class

print.exposure <- function(x, ...) {
  cat("<exposure>\n")
  cat("  Locations:", nrow(x), "\n")
  cat("  Value col:", attr(x, "value_col"), "\n")
  cat("  CRS:", sf::st_crs(x)$epsg, "\n")
}
