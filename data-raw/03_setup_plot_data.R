# Load libraries ----------------------------------------------------------

library(devtools)

# Load data ---------------------------------------------------------------

load("./data/sepkoski.rda")

# Macrostrat stage API
api <- url("https://macrostrat.org/api/v2/defs/intervals?format=csv&timescale=international%20ages")

# Get stages
stages <- read.csv(api, stringsAsFactors = FALSE)

# Macrostrat periods API
api <- url("https://macrostrat.org/api/v2/defs/intervals?format=csv&timescale=international%20periods")

# Get periods
periods <- read.csv(api, stringsAsFactors = FALSE)

# Clean up stage data
stages <- stages[, c("name", "t_age", "b_age", "abbrev", "color")]
colnames(stages) <- c("name", "min_ma", "max_ma", "abbrev", "colour")
stages$mid_ma <- (stages$max_ma + stages$min_ma) / 2
stages <- stages[, c("name", "min_ma", "mid_ma", "max_ma", "abbrev", "colour")]

# Clean up periods data
periods <- periods[, c("name", "t_age", "b_age", "abbrev", "color")]
colnames(periods) <- c("name", "min_ma", "max_ma", "abbrev", "colour")
periods$mid_ma <- (periods$max_ma + periods$min_ma) / 2
periods <- periods[, c("name", "min_ma", "mid_ma", "max_ma", "abbrev", "colour")]
periods <- periods[which(periods$max_ma < 540), ]

# Set up bins
bins <- c(stages$min_ma, stages$max_ma[nrow(stages)])

# Set up empty table
genus_counts <- table(x = cut(x = -1, breaks = bins, include.lowest = TRUE))

stages$total_counts <- 0
stages$cambrian_counts <- 0
stages$paleozoic_counts <- 0
stages$modern_counts <- 0

# Run for loop across genera
for (i in 1:nrow(sepkoski)) {
  # Calculate range sequence for genus
  range <- seq(from = sepkoski$min_ma[i], to = sepkoski$max_ma[i], by = 0.001)
  # Calculate range through
  tbl <- table(x = cut(x = range, breaks = bins, include.lowest = TRUE))
  # Convert to presence/absence
  tbl[tbl > 0] <- 1
  # Add to main df
  stages$total_counts <- stages$total_counts + as.numeric(tbl)
  # Add evolutionary fauna counts
  if (is.na(sepkoski$fauna[i])) {next}
  if (sepkoski$fauna[i] == "Cambrian") {
    stages$cambrian_counts <- stages$cambrian_counts + as.numeric(tbl)
  }
  if (sepkoski$fauna[i] == "Paleozoic") {
    stages$paleozoic_counts <- stages$paleozoic_counts + as.numeric(tbl)
  }
  if (sepkoski$fauna[i] == "Modern") {
    stages$modern_counts <- stages$modern_counts + as.numeric(tbl)
  }
}

# Save data internally
use_data(stages, periods, internal = TRUE, overwrite = TRUE)
