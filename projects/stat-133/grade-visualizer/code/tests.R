# import testthat
library(testthat)
# import stringr
library(stringr)
# import functions
source("functions.R")

context("test remove_missing")
test_that("remove missing value", {
  expect_equal(remove_missing(c(1, 2, 3, 4)), c(1, 2, 3, 4))
  expect_equal(remove_missing(c(1, 2, NA, 4)), c(1, 2, 4))
  expect_equal(remove_missing(c(1, NA, NA, 4)), c(1, 4))
  expect_equal(remove_missing(c(NA, NA, NA, NA)), logical(0))
})

context("test na_detect")
test_that("detect NA values", {
  expect_equal(na_detect(c(1, 2, 3, 4)), FALSE)
  expect_equal(na_detect(c(1, 2, NA, 4)), TRUE)
  expect_equal(na_detect(c()), TRUE)
  expect_equal(na_detect(c(1, 2, "NA")), FALSE)
})

context("test get_minimum")
test_that("get the minimum", {
  expect_equal(get_minimum(c(1, 2, 3, 4)), 1)
  expect_equal(get_minimum(c(1, 2, 3, NA), na.rm = TRUE), 1)
  expect_error(get_minimum(c(1, 1, 2, NA, 3), na.rm = FALSE), "non-numeric argument")
  expect_error(get_minimum(c(NA, NA)))
})

context("test get_maximum")
test_that("get the maximum", {
  expect_equal(get_maximum(c(1, 2, 3, 4)), 4)
  expect_equal(get_maximum(c(1, 2, 3, NA), na.rm = TRUE), 3)
  expect_error(get_maximum(c(1, 1, 2, NA, 3), na.rm = FALSE), "non-numeric argument")
  expect_error(get_maximum(c(NA, NA)))
})

context("test get_range")
test_that("get the range", {
  expect_equal(get_range(c(1, 2, 3, 4)), 3)
  expect_equal(get_range(c(1, 2, NA, 3)), 2)
  expect_error(get_range(c(1, 2, NA, NA), na.rm = FALSE), "non-numeric argument")
  expect_error(get_range(c(NA, NA, NA)))
})

context("test get_percentile10")
test_that("get the 10 percentile", {
  expect_equal(get_percentile10(c(1, 4, 7, 10)), 1.9)
  expect_equal(get_percentile10(c(1, 4, 7, NA, 10), na.rm = TRUE), 1.9)
  expect_error(get_percentile10(c(1, NA), na.rm = FALSE))
  expect_error(get_percentile10(c(NA, NA)))
})

context("test get_percentile90")
test_that("get the 10 percentile", {
  expect_equal(get_percentile90(c(1, 4, 7, 10)), 9.1)
  expect_equal(get_percentile90(c(1, 4, NA, 7, 10), na.rm = TRUE), 9.1)
  expect_error(get_percentile90(c(1, NA), na.rm = FALSE))
  expect_error(get_percentile90(c(NA, NA), na.rm = TRUE))
})

context("test get_median")
test_that("get the median", {
  expect_equal(get_median(c(1, 4, 7, 10)), 5.5)
  expect_equal(get_median(c(1, 4, 7, NA, 10), na.rm = TRUE), 5.5)
  expect_error(get_median(c(1, NA), na.rm = FALSE))
  expect_error(get_median(c(NA, NA), na.rm = TRUE))
})

context("test get_average")
test_that("get the average", {
  expect_equal(get_average(c(1, 4, 7, 10)), 5.5)
  expect_equal(get_average(c(1, 4, 7, NA, 10), na.rm = TRUE), 5.5)
  expect_error(get_average(c(1, NA), na.rm = FALSE))
  expect_error(get_average(c(NA, NA), na.rm = TRUE))
})

context("test get_stdev")
test_that("get the standard deviation", {
  expect_equal(get_stdev(c(1, 4, 7, 10)), sd(c(1, 4, 7, 10)))
  expect_equal(get_stdev(c(1, 4, 7, NA, 10), na.rm = TRUE), sd(c(1, 4, 7, 10)))
  expect_error(get_stdev(c(1, NA), na.rm = FALSE))
  expect_error(get_stdev(c(NA, NA)))
})

context("test get_quartile1")
test_that("get the first quartile", {
  expect_equal(get_quartile1(c(1, 4, 7, 10)), 3.25)
  expect_equal(get_quartile1(c(1, 4, 7, NA, 10)), 3.25)
  expect_error(get_quartile1(c(1, NA), na.rm = FALSE))
  expect_error(get_quartile1(c(NA, NA)))
})

context("test get_quartile3")
test_that("get the third quartile", {
  expect_equal(get_quartile3(c(1, 4, 7, 10)), 7.75)
  expect_equal(get_quartile3(c(1, 4, 7, NA, 10)), 7.75)
  expect_error(get_quartile3(c(1, NA), na.rm = FALSE))
  expect_error(get_quartile3(c(NA, NA)))
})

context("test count_missing")
test_that("get the number of missing value", {
  expect_equal(count_missing(c(1, 4, 7, NA, 10)), 1)
  expect_equal(count_missing(c(1, 4, 7, 10)), 0)
  expect_equal(count_missing(remove_missing(c(1, 4, 7, NA, 10))), 0)
  expect_equal(count_missing(c(NA, NA)), 2)
})

context("test summary_stats")
test_that("get the summary", {
  a = c(1, 4, 7, NA, 10)
  expect_equal(length(summary_stats(a)), 11)
  expect_equal(summary_stats(a)$missing, count_missing(a))
  expect_equal(summary_stats(a)$stdev, get_stdev(a))
  expect_equal(names(summary_stats(a)), c("minimum", "percent10", "quartile1", "median", "mean", "quartile3", "percent90", "maximum", "range", "stdev", "missing"))
})

context("test print_stat")
test_that("print out the stat", {
  expect_error(print_stats(c(1, 4, 7, NA, "A")))
  expect_output(print_stats(c(1, 4, 7, NA)), "\\d")
  expect_output(print_stats(c(1, 4, 7, NA)), "\\w")
  expect_output(print_stats(c(1, 4, 7, NA)), "min")
})

context("test rescale100")
test_that("rescale", {
  expect_equal(rescale100(1:10, xmin = 0, xmax = 100), 1:10)
  expect_equal(rescale100(c(18, 15, 16, 4, 17, 9), xmin = 0, xmax = 20), c(90, 75, 80, 20, 85, 45))
  expect_error(rescale100(c(1, 2, "ERROR"), xmin = 0, xmax = 2))
  expect_equal(rescale100(c(NA, NA), xmin = 0, xmax = 10), c(NA_integer_, NA_integer_))
})

context("test drop_lowest")
test_that("drop the lowest score", {
  expect_equal(drop_lowest(c(1, 2, "3")), c("2", "3"))
  expect_equal(drop_lowest(c(1, 2, 3)), c(2, 3))
  expect_equal(drop_lowest(c(1, 1, 2, 3, 4)), c(1, 2, 3, 4))
  expect_equal(drop_lowest(c(1, 2, 1, 3, 4)), c(2, 1, 3, 4))
})

context("test score_homework")
test_that("compute the homework scores", {
  hws = c(100, 80, 30, 70, 75, 85)
  expect_equal(score_homework(hws, drop = TRUE), 82)
  expect_equal(score_homework(hws, drop = FALSE), 73.333333)
  expect_equal(score_homework(c(100, 80, 30, 30, 70, 75, 85), drop = TRUE), score_homework(hws, drop = FALSE))
  expect_error(score_homework(c(1, 2, 'A')))
})

context("test score_quiz")
test_that("compute the quiz scores", {
  quizzes = c(100, 80, 70, 0)
  expect_equal(score_quiz(quizzes, drop = TRUE), 83.333333)
  expect_equal(score_quiz(quizzes, drop = FALSE), 62.5)
  expect_equal(score_quiz(c(100, 80, 70, 0, 0), drop = TRUE), score_quiz(quizzes, drop = FALSE))
  expect_error(score_quiz(c(1, 2, 'A')))
})

context("test score_lab")
test_that("compute the lab scores", {
  expect_error(score_lab(13))
  expect_error(score_lab(-2))
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(6), 0)
})