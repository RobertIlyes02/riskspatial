library(sf)

# Script for testing
set.seed(123)  # for reproducibility

# Romania bounding box
lat_min <- 43.5
lat_max <- 48.3
lon_min <- 20.3
lon_max <- 29.7

# Generate 1000 random points
n_points <- 10000
insurance_data <- data.frame(
  id = 1:n_points,
  latitude = runif(n_points, min = lat_min, max = lat_max),
  longitude = runif(n_points, min = lon_min, max = lon_max),
  earned_exposure = round(runif(n_points, min = 0.0001, max = 1), 3),
  building_class = sample(c("RES1", "RES2", "COM1", "COM2", "IND1", "IND2"), n_points, replace = TRUE),
  occupancy = sample(c("Residential", "Office", "Retail", "Warehouse", "Factory"), n_points, replace = TRUE),
  construction_year = sample(1950:2023, n_points, replace = TRUE),
  total_insurable_value = round(runif(n_points, 50000, 5e6), 0),
  earthquake_AAL = round(runif(n_points, 100, 50000), 2),
  premium_rate = round(runif(n_points, 0.001, 0.01), 4),  # e.g., 0.1% to 1% of TIV
  deductible_type = sample(c("Absolute", "Percentage"), n_points, replace = TRUE),
  deductible = NA_real_  # will fill below
)

# Calculate deductible based on type
insurance_data$deductible <- mapply(function(type, tiv) {
  if(type == "Absolute") {
    round(runif(1, 1000, 50000), 0)
  } else {
    round(runif(1, 0.01, 0.05) * tiv, 0)
  }
}, insurance_data$deductible_type, insurance_data$total_insurable_value)

# Calculate premium based on TIV and rate
insurance_data$premium <- round(insurance_data$total_insurable_value * insurance_data$premium_rate, 2)

head(insurance_data)

insurance_data_sf = sf::st_as_sf(insurance_data, coords=c("longitude", "latitude"), crs=4326)

te = exposure(insurance_data_sf, "id", "total_insurable_value")
