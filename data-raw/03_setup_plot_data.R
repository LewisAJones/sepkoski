# Load libraries ----------------------------------------------------------
library(devtools)
library(tidyverse)

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

# Wrangle naming of stage data
stages <- stages[, c("name", "t_age", "b_age", "abbrev", "color")]
colnames(stages) <- c("interval_name", "min_ma", "max_ma", "abbrev", "colour")
stages$mid_ma <- (stages$max_ma + stages$min_ma) / 2
stages <- stages[, c("interval_name", "min_ma", "mid_ma", "max_ma", "abbrev", "colour")]
# Add abbreviation
stages$abbrev <- abbreviate(stages$interval_name, minlength = 3)

# Clean up periods data
periods <- periods[, c("name", "t_age", "b_age", "abbrev", "color")]
colnames(periods) <- c("interval_name", "min_ma", "max_ma", "abbrev", "colour")
periods$mid_ma <- (periods$max_ma + periods$min_ma) / 2
periods <- periods[, c("interval_name", "min_ma", "mid_ma", "max_ma", "abbrev", "colour")]

# Update ages
df <- sepkoski
df <- df[, -which(colnames(df) %in% c("max_ma", "min_ma"))]

# Join stage maximum age
df <- left_join(x = df, y = stages[, c("interval_name", "max_ma")],
                by = c("interval_max" = "interval_name"))

# Join stage minimum age
df <- left_join(x = df, y = stages[, c("interval_name", "min_ma")],
                by = c("interval_min" = "interval_name"))

# Add maximum period ages for missing data
vec <- which(is.na(df$max_ma))
for (i in vec) {
  df$max_ma[i] <- periods$max_ma[which(periods$interval_name == df$interval_max[i])]
}

# Add minimum period ages for missing data
vec <- which(is.na(df$min_ma))
for (i in vec) {
  df$min_ma[i] <- periods$min_ma[which(periods$interval_name == df$interval_min[i])]
}

# Set up bins
bins <- c(stages$min_ma, stages$max_ma[nrow(stages)])

# Set up counts
stages$total <- NA
stages$unassigned <- 0
stages$cambrian <- 0
stages$palaeozoic <- 0
stages$modern <- 0

# Run for loop across genera
for (i in seq_len(nrow(df))) {
  # Calculate range sequence for genus
  range <- seq(from = df$min_ma[i], to = df$max_ma[i], by = 0.001)
  # Calculate range through
  tbl <- table(x = cut(x = range, breaks = bins, include.lowest = TRUE))
  # Convert to presence/absence
  tbl[tbl > 0] <- 1
  # Add evolutionary fauna counts
  if (is.na(df$fauna[i])) {
    stages$unassigned <- stages$unassigned + as.numeric(tbl)
    next
  }
  if (df$fauna[i] == "Cambrian") {
    stages$cambrian <- stages$cambrian + as.numeric(tbl)
    next
  }
  if (df$fauna[i] == "Paleozoic") {
    stages$palaeozoic <- stages$palaeozoic + as.numeric(tbl)
    next
  }
  if (df$fauna[i] == "Modern") {
    stages$modern <- stages$modern + as.numeric(tbl)
    next
  }
}

# Add total
stages$total <- stages$cambrian +
  stages$palaeozoic +
  stages$modern +
  stages$unassigned

# Use long format
stages <- stages %>% pivot_longer(cols = unassigned:modern,
                                  names_to = "group",
                                  values_to = "value")

# Capitalise
stages$group <- stringr::str_to_sentence(stages$group)

# Set factor levels
stages$group <- factor(stages$group, levels = c("Unassigned", "Modern",
                                                "Palaeozoic", "Cambrian"))
# Convert to data.frame
stages <- as.data.frame(stages)

# Retain Phanerozoic periods
periods <- subset(periods, max_ma <= 541)

# Save data internally
use_data(stages, periods, internal = TRUE, overwrite = TRUE)
