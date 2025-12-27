test_that("Normal Creation", {
  expect_silent(exposure(insurance_data_sf, id="id", value="total_insurable_value"))
})


test_that("Create with negative value", {
  bad_data <- insurance_data_sf
  bad_data$total_insurable_value[1] <- -1000

  expect_error(
    exposure(bad_data, id="id", value="total_insurable_value"),
    "Exposure values must be non-negative."
  )
})


test_that("Create with 1 row", {
  x = insurance_data_sf[1,]
  expect_silent(exposure(x, id="id", value="total_insurable_value"))
})


test_that("Create with 0 rows", {
  x = insurance_data_sf[0,]
  expect_silent(exposure(x, id="id", value="total_insurable_value"))
})


test_that("Create without id column", {
  expect_error(exposure(insurance_data_sf, id="random", value="total_insurable_value"),
               "Id column not in column names.")
})

test_that("Create without value column", {
  expect_error(exposure(insurance_data_sf, id="id", value="random"),
               "Value column not in column names.")
})

test_that("Create without either columns", {
  expect_error(exposure(insurance_data_sf, id="random", value="random"),
               "Id column not in column names.")
})

test_that("Create with duplicate ids", {
  bad_data <- insurance_data_sf
  bad_data$id[1] <- bad_data$id[2]

  expect_error(
    exposure(bad_data, id="id", value="total_insurable_value"),
    "Exposure IDs must be unique."
  )
})

test_that("Create using dataframe", {
  expect_error(exposure(insurance_data, id="id", value="total_insurable_value"),
               'inherits(x, "sf") is not TRUE')
})

# test_that("Create using Polygon SF", {
#
# })


