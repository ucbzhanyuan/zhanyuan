# Data Preparation

# importing package, functions, and data set
library(dplyr)
source("code/functions.R")
rawscores <-  read.csv("data/rawdata/rawscores.csv")

# output summary
sink("output/summary-rawscores.txt")
str(rawscores)
cat('\n', append = TRUE)
for (i in 1:ncol(rawscores)) {
  cat(names(rawscores)[i], "\n", append = TRUE)
  summary_stats(unlist(select(rawscores, i)))
  print_stats(unlist(select(rawscores, i)))
  cat('\n', append = TRUE)
}
sink()

# replace all missing values NA with zero
for (m in 1:ncol(rawscores)) {
  for (n in 1:nrow(rawscores)) {
    if (is.na(rawscores[n, m])) {
      rawscores[n, m] = 0
    }
  }
}

# rescale QZ1
for (m in 1:nrow(rawscores)) {
    rawscores[m, 11] = rescale100(rawscores[m, 11], xmin = 0, xmax = 12)
}

# rescale QZ2
for (m in 1:nrow(rawscores)) {
  rawscores[m, 12] = rescale100(rawscores[m, 12], xmin = 0, xmax = 18)
}

# rescale QZ3
for (m in 1:nrow(rawscores)) {
  rawscores[m, 13] = rescale100(rawscores[m, 13], xmin = 0, xmax = 20)
}

# rescale QZ4
for (m in 1:nrow(rawscores)) {
  rawscores[m, 14] = rescale100(rawscores[m, 14], xmin = 0, xmax = 20)
}

# add Test1 by rescaling EX1, and add Test2 by rescaling EX2
rawscores <-  mutate(rawscores, Test1 = rescale100(rawscores[ , "EX1"], xmin = 0, xmax = 80), Test2 = rescale100(rawscores[ , "EX2"], xmin = 0, xmax = 90))

# compute the homework scores and add the Homework column
aux <- c()
hw <- c()
for (m in 1:nrow(rawscores)) {
  for (n in 1:9) {
    aux[n] <- rawscores[m, n]
  }
  hw[m] <- score_homework(aux, drop = TRUE)
}
rawscores <- mutate(rawscores, Homework = hw)

# compute the quiz scores and add the Quiz column
aux <- c()
qz <- c()
for (m in 1:nrow(rawscores)) {
  for (n in 11:14) {
    aux[n - 10] <- rawscores[m, n]
  }
  qz[m] <- score_quiz(aux, drop = TRUE)
}
rawscores <- mutate(rawscores, Quiz = qz)

# rescale the lab scores and add the Lab column
lb <- c()
for (m in 1:nrow(rawscores)) {
  lb[m] <- score_lab(rawscores$ATT[m])
}
rawscores <- mutate(rawscores, Lab = lb)


# compute the overall scores 
# 10% Lab, 30% HW, 15% QZ, 20% Test1 25% Test2
sc <- c()
aux <- c()
for (m in 1:nrow(rawscores)) {
  for (n in 17:21) {
    aux[n - 16] <- rawscores[m, n]
  }
  sc[m] <- aux[1] * 0.2 + aux[2] * 0.25 + aux[3] * 0.3 + aux[4] * 0.15 + aux[5] * 0.1
}
rawscores <- mutate(rawscores, Overall = sc)

# conver scores to grades
get_grade <- function(x) {
  if (x >=95 & x <= 100) {
    return("A+")
  } else if (x < 95 & x >= 90) {
    return("A")
  } else if (x < 90 & x >= 88) {
    return("A-")
  } else if (x < 88 & x >= 86) {
    return("B+")
  } else if (x < 86 & x >= 82) {
    return("B")
  } else if (x < 82 & x >= 79.5) {
    return("B-")
  } else if (x < 79.5 & x >= 77.5) {
    return("C+")
  } else if (x < 77.5  & x >= 70) {
    return("C")
  } else if (x < 70 & x >= 60) {
    return("C-")
  } else if (x < 60 & x >= 50) {
    return("D")
  } else if (x < 50 & x >= 0) {
    return("F")
  } else {
    stop("invalid value")
  }
}

gd <- c()
for (m in 1:nrow(rawscores)) {
  gd[m] <- get_grade(rawscores$Overall[m])
}
rawscores <- mutate(rawscores, Grade = gd)

# export summary
path_names <- c("output/Test1-stats.txt", "output/Test2-stats.txt", "output/Homework-stats.txt", "output/Quiz-stats.txt", "output/Lab-stats.txt", "output/Overall-stats.txt")
for (i in 1:6) {
  sink(path_names[i])
  cat(paste0(names(rawscores)[i + 16], "\n"))
  print_stats(rawscores[ , i + 16 ])
  sink()
}

sink("output/summary-cleansores.txt")
str(rawscores)
sink()

write.csv(rawscores, file = "data/cleandata/cleanscores.csv", row.names = FALSE)
cleanscores <- read.csv("data/cleandata/cleanscores.csv")


















