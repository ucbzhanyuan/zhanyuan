library(stringr)
# remove missing values
remove_missing <- function(x) {
  aux = c()
  for (i in 1:length(x)) {
    if (is.na(x[i])) {
      aux[i] = F
    } else {
      aux[i] = T
    }
  }
  return(x[aux])
}

# build a NA-detector function
na_detect <- function(x) {
  aux = c()
  if (length(x) == 0) {
    return(TRUE)
  }
  for (i in 1:length(x)) {
    if (is.na(x[i])) {
      aux[i] = TRUE
    } else {
      aux[i] = FALSE
    }
  }
  if (TRUE %in% aux) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# get the maximum
get_maximum <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x) == TRUE) {
    stop("non-numeric argument")
  }
  x = sort(x, decreasing = TRUE)
  return(x[1])
}

# get the minimum
get_minimum <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  x = sort(x)
  return(x[1])
}

# get the range
get_range <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  return((get_maximum(x) - get_minimum(x)))
}

# get the 10 percentile
get_percentile10 <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  return(quantile(x, 0.1)[[1]])
}

# get the 90 percentile
get_percentile90 <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  return(quantile(x, 0.9)[[1]])
}


# get the median
get_median <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  x = sort(x)
  if (length(x) %% 2 != 0) {
    med = (length(x) + 1) / 2
    return(x[med])
  } else {
    med_1 = length(x) / 2
    med_2 = length(x) / 2 + 1
    return((x[med_1] + x[med_2]) / 2)
  }
}

# get the average
get_average <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  total = 0
  for (i in 1:length(x)) {
    total = total + x[i]
  }
  return(total / length(x))
}

# get the standard deviation
get_stdev <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  ave = get_average(x)
  dif = 0
  if (length(x) != 1) {
    for (i in x) {
    dif = dif + (i - ave)^2
  }
  sd = sqrt(dif / (length(x) - 1))
  return(sd)
  } else if (length(x) == 1) {
    return(0)
  } else {
    stop("There is no data")
  }
}

# get the first quartile
get_quartile1 <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  return(quantile(x)[[2]])
}

# get the third quartile
get_quartile3 <- function(x, na.rm = TRUE) {
  if (na.rm == TRUE) {
    x = remove_missing(x)
  }
  if (na_detect(x)) {
    stop("non-numeric argument")
  }
  return(quantile(x)[[4]])
}

# count missing values
count_missing <- function(x) {
  count = 0
  for (i in x) {
    if (is.na(i)) {
      count = count + 1
    }
  }
  return(count)
}

# summarize stats
summary_stats <- function(x) {
  missing = count_missing(x)
  x = remove_missing(x)
  sum = list(minimum = get_minimum(x),
             percent10 = get_percentile10(x),
             quartile1 = get_quartile1(x),
             median = get_median(x),
             mean = get_average(x),
             quartile3 = get_quartile3(x),
             percent90 = get_percentile90(x),
             maximum = get_maximum(x),
             range = get_range(x),
             stdev = get_stdev(x),
             missing = missing)
  return(sum)
}

# print the summary
print_stats <- function(x) {
  stats = summary_stats(x)
  for (i in 1:length(stats)){
    stats[[i]] = sprintf("%.4f", stats[[i]])
  }
  for (i in 1:length(stats)) {
    cat(str_pad(names(stats)[i], 9, "right"), ": ", stats[[i]], "\n")
  }
}

# rescaling
rescale100 <- function(x, xmin, xmax) {
  return((x - xmin) * 100 / (xmax - xmin))
}

# drop the lowest
drop_lowest <- function(x) {
  min_position = which.min(x)
  aux = c()
  for (i in 1:length(x)) {
    if (i == min_position) {
      aux[i] = FALSE
    } else {
      aux[i] = TRUE
    }
  }
  return(x[aux])
}

# the average of the hw scores
score_homework <- function(x, drop){
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  return(get_average(x))
}

# the average of the quizzes scores
score_quiz <- function(x, drop){
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  return(get_average(x))
}

# lab score
score_lab <- function(x) {
  if (x > 12 | x < 0) {
    stop("invalid value")
  }
  x = 100 - (11 - x) * 20
  if (x > 100) {
    x = 100
  } else if (x < 0) {
    x = 0
  }
  return(x)
}