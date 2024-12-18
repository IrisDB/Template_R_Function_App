test_data <- test_data("input4_move2loc_LatLon.rds")

test_that("happy path", {
  actual <- rFunction(data = test_data, sdk = "unit test", year = 2014)
  expect_equal(unique(lubridate::year(mt_time(actual))), 2014)
})

test_that("year not included", {
  actual <- rFunction(data = test_data, sdk = "unit test", year = 1900)
  expect_null(actual)
})

test_that("App creates artifact", {
  on.exit(file.remove("./data/output/plot.png"), add = TRUE)
  rFunction(data = test_data, sdk = "unit test", year = 2014)
  # Check if the file exists
  expect_true(file.exists("./data/output/plot.png"))
})
