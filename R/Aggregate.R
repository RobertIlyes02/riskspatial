aggregate_exposure <- function(exposure, by, type = c("spatial", "attribute"), fun = sum) {
  type <- match.arg(type)

  df <- as.data.frame(exposure)
  geom <- st_geometry(exposure)

  if (type == "attribute") {
    # Aggregate only attributes, keep geometry as is
    agg <- df %>%
      group_by(across(all_of(by))) %>%
      summarise(across(where(is.numeric), fun, .names = "{.col}_agg"))

    st_geometry(agg) <- geom[df[[by]] %in% agg[[by]],] # keep geometries optionally

  } else if (type == "spatial") {
    # Aggregate both attributes and geometry
    agg <- df %>%
      group_by(across(all_of(by))) %>%
      summarise(across(where(is.numeric), fun, .names = "{.col}_agg"),
                geometry = st_union(geometry)) %>%
      st_as_sf()
  }

  structure(agg, class = "exposure")
}
