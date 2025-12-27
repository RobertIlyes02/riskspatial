

test_that("validate_exposure works for a valid exposure object", {
  expect_silent(validate_exposure(te))
})

test_that("validate_exposure errors for non-exposure input", {

  expect_error(
    validate_exposure(123),
    "Object must be of class <exposure>"
  )
})

test_that("validate_exposure errors when IDs are duplicated", {

  bad_data <- te
  bad_data$id[1] <- bad_data$id[2]

  expect_error(
    validate_exposure(bad_data),
    "Duplicate exposure IDs"
  )
})

test_that("validate_exposure warns when exposure values are negative", {

  bad_data <- te
  bad_data$total_insurable_value[1] <- -1000

  expect_warning(
    validate_exposure(bad_data),
    "negative exposure values"
  )
})

test_that("validate_exposure errors when metadata is missing", {

  bad_data <- te

  attr(bad_data, "value_col") <- NULL

  expect_error(
    validate_exposure(bad_data),
    "Exposure metadata is inconsistent"
  )
})
