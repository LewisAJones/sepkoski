# Load libraries ----------------------------------------------------------

library(tidyverse)
library(devtools)

# Load data ---------------------------------------------------------------

# Scrape
df <- readRDS("./inst/extdata/sepkoski_scrape.RDS")

# Interval key
interval_table <- read.csv("./data-raw/interval_table.csv")
# Save interval key
use_data(interval_table, internal = FALSE, overwrite = TRUE)

# Data cleaning -----------------------------------------------------------

# Clean up data scrape
df$Genus[grep(pattern = "\xef", df$Genus)] <- c("Heliocïenia")
df$Genus[grep(pattern = "\xe5", df$Genus)] <- c("Såkwia")
df$Genus[grep(pattern = "\xf3", df$Genus)] <- c("Mikrocidarió")
df$Genus[grep(pattern = "\xe1", df$Genus)] <- c("Cályxhydra")
df$Genus[grep(pattern = "\xf2", df$Genus)] <- c("Còyptoporocyathus")
df$name <- gsub(pattern = "O ", replacement = "", x = df$name)

# Replace Maas (Maes) mispelling
df$FOS <- gsub("Maes", "Maas", df$FOS)
df$LOS <- gsub("Maes", "Maas", df$LOS)

# Replace missing data with NA
df$LOS[which(df$LOS == "&nbsp")] <- NA

# Separate data for processing
phylum <- df[which(df$rank == "phylum"), ]

class <- df[which(df$rank == "class"), ]

# Update col names
colnames(class)[1] <- c("class")
colnames(phylum)[1] <- c("phylum")

# Drop rank columns
class <- class[, -which(colnames(class) == "rank")]
phylum <- phylum[, -which(colnames(phylum) == "rank")]

# Join phylum column
df <- inner_join(x = class, y = phylum, by = c("Genus", "Order", "FOP", "FOS",
                                         "LOP", "LOS"))

# Assign to new object
sepkoski_raw <- df

# Clean up raw data file
sepkoski_raw <- sepkoski_raw[, c("phylum", "class", "Order", "Genus", "FOP",
                                 "FOS", "LOP", "LOS")]

# Standardise column names
colnames(sepkoski_raw) <- c("phylum", "class", "order", "genus",
                            "FOP", "FOS", "LOP", "LOS")

# Transform to sentence case
sepkoski_raw$phylum <- str_to_sentence(sepkoski_raw$phylum)
sepkoski_raw$class <- str_to_sentence(sepkoski_raw$class)
sepkoski_raw$order <- str_to_sentence(sepkoski_raw$order)
sepkoski_raw$genus <- str_to_sentence(sepkoski_raw$genus)

# Lower case 'uncertain'
sepkoski_raw$order[which(sepkoski_raw$order == "Uncertain")] <- c("uncertain")
sepkoski_raw$genus[which(sepkoski_raw$genus == "Uncertain")] <- c("uncertain")

# Lower case 'uncertain'
sepkoski_raw$order[which(sepkoski_raw$order == "Incertae sedis")] <- c("incertae sedis")
sepkoski_raw$genus[which(sepkoski_raw$genus == "Incertae sedis")] <- c("incertae sedis")

# Order by Phylum
sepkoski_raw <- sepkoski_raw[order(sepkoski_raw$phylum), ]

# Remove row names
row.names(sepkoski_raw) <- NULL

# Save raw data
use_data(sepkoski_raw, internal = FALSE, overwrite = TRUE, compress = "xz")

# Update interval names ---------------------------------------------------

# Temp object
df <-sepkoski_raw

# Update missing stages with period assignation
df$LOS[which(is.na(df$LOS))] <- df$LOP[which(is.na(df$LOS))]

# Combine period/stage name columns where needed
# Upper
df$FOS[which(df$FOS == "u")] <- paste0(df$FOP[which(df$FOS == "u")], "-u")
df$LOS[which(df$LOS == "u")] <- paste0(df$LOP[which(df$LOS == "u")], "-u")
# Middle
df$FOS[which(df$FOS == "m")] <- paste0(df$FOP[which(df$FOS == "m")], "-m")
df$LOS[which(df$LOS == "m")] <- paste0(df$LOP[which(df$LOS == "m")], "-m")
# Lower
df$FOS[which(df$FOS == "l")] <- paste0(df$FOP[which(df$FOS == "l")], "-l")
df$LOS[which(df$LOS == "l")] <- paste0(df$LOP[which(df$LOS == "l")], "-l")
# Cambrian assignments
# Mid-upper
df$FOS[which(df$FOS == "Mid-u")] <- paste0(df$FOP[which(df$FOS == "Mid-u")], "-Mid-u")
df$LOS[which(df$LOS == "Mid-u")] <- paste0(df$LOP[which(df$LOS == "Mid-u")], "-Mid-u")
# Upper-Mid
df$FOS[which(df$FOS == "uMid")] <- paste0(df$FOP[which(df$FOS == "uMid")], "-uMid")
df$LOS[which(df$LOS == "uMid")] <- paste0(df$LOP[which(df$LOS == "uMid")], "-uMid")
# Upper-Mid-Upper
df$FOS[which(df$FOS == "uMid-u")] <- paste0(df$FOP[which(df$FOS == "uMid-u")], "-uMid-u")
df$LOS[which(df$LOS == "uMid-u")] <- paste0(df$LOP[which(df$LOS == "uMid-u")], "-uMid-u")
# Upper-Mid-Middle
df$FOS[which(df$FOS == "uMid-m")] <- paste0(df$FOP[which(df$FOS == "uMid-m")], "-uMid-m")
df$LOS[which(df$LOS == "uMid-m")] <- paste0(df$LOP[which(df$LOS == "uMid-m")], "-uMid-m")
# Upper-Mid-lower
df$FOS[which(df$FOS == "uMid-l")] <- paste0(df$FOP[which(df$FOS == "uMid-l")], "-uMid-l")
df$LOS[which(df$LOS == "uMid-l")] <- paste0(df$LOP[which(df$LOS == "uMid-l")], "-uMid-l")
# Middle-Mid
df$FOS[which(df$FOS == "mMid")] <- paste0(df$FOP[which(df$FOS == "mMid")], "-mMid")
df$LOS[which(df$LOS == "mMid")] <- paste0(df$LOP[which(df$LOS == "mMid")], "-mMid")
# Middle-Mid-upper
df$FOS[which(df$FOS == "mMid-u")] <- paste0(df$FOP[which(df$FOS == "mMid-u")], "-mMid-u")
df$LOS[which(df$LOS == "mMid-u")] <- paste0(df$LOP[which(df$LOS == "mMid-u")], "-mMid-u")
# Middle-Mid-Mid
df$FOS[which(df$FOS == "mMid-m")] <- paste0(df$FOP[which(df$FOS == "mMid-m")], "-mMid-m")
df$LOS[which(df$LOS == "mMid-m")] <- paste0(df$LOP[which(df$LOS == "mMid-m")], "-mMid-m")
# Middle-Mid-lower
df$FOS[which(df$FOS == "mMid-l")] <- paste0(df$FOP[which(df$FOS == "mMid-l")], "-mMid-l")
df$LOS[which(df$LOS == "mMid-l")] <- paste0(df$LOP[which(df$LOS == "mMid-l")], "-mMid-l")
# Lower-Mid
df$FOS[which(df$FOS == "lMid")] <- paste0(df$FOP[which(df$FOS == "lMid")], "-lMid")
df$LOS[which(df$LOS == "lMid")] <- paste0(df$LOP[which(df$LOS == "lMid")], "-lMid")
# Lower-Mid-Upper
df$FOS[which(df$FOS == "lMid-u")] <- paste0(df$FOP[which(df$FOS == "lMid-u")], "-lMid-u")
df$LOS[which(df$LOS == "lMid-u")] <- paste0(df$LOP[which(df$LOS == "lMid-u")], "-lMid-u")
# Lower-Mid-Middle
df$FOS[which(df$FOS == "lMid-m")] <- paste0(df$FOP[which(df$FOS == "lMid-m")], "-lMid-m")
df$LOS[which(df$LOS == "lMid-m")] <- paste0(df$LOP[which(df$LOS == "lMid-m")], "-lMid-m")
# Lower-Mid-Lower
df$FOS[which(df$FOS == "lMid-l")] <- paste0(df$FOP[which(df$FOS == "lMid-l")], "-lMid-l")
df$LOS[which(df$LOS == "lMid-l")] <- paste0(df$LOP[which(df$LOS == "lMid-l")], "-lMid-l")
# Update '?' with period assignations
df$FOS[which(df$FOS == "?")] <- df$FOP[which(df$FOS == "?")]
df$LOS[which(df$LOS == "?")] <- df$LOP[which(df$LOS == "?")]

## Interval linking -------------------------------------------------------

# Add interval names
df$interval_max <- NA
df$interval_min <- NA

# Run for loop to assign interval names
for (i in 1:nrow(interval_table)) {
  df$interval_min[which(df$LOS == interval_table$code[i])] <- interval_table$interval_min[i]
  df$interval_max[which(df$FOS == interval_table$code[i])] <- interval_table$interval_max[i]
}

# Macrostrat stage API
api <- url("https://macrostrat.org/api/v2/defs/intervals?format=csv&timescale=international%20ages")
# Get stages
stages <- read.csv(api, stringsAsFactors = FALSE)

# Clean up stage data
stages <- stages[, c("name", "t_age", "b_age", "color")]
colnames(stages) <- c("name", "min_ma", "max_ma", "colour")

# Add ages
df$max_ma <- NA
df$min_ma <- NA

# Run for loop to add ages
for (i in 1:nrow(stages)) {
  df$min_ma[which(df$interval_min == stages$name[i])] <- stages$min_ma[i]
  df$max_ma[which(df$interval_max == stages$name[i])] <- stages$max_ma[i]
}

# Macrostrat period API
api <- url("https://macrostrat.org/api/v2/defs/intervals?format=csv&timescale=international%20periods")
# Get periods
periods <- read.csv(api, stringsAsFactors = FALSE)

# Clean up period data
periods <- periods[, c("name", "t_age", "b_age", "color")]
colnames(periods) <- c("name", "min_ma", "max_ma", "colour")

# Assign period level ages (Ediacaran)
for (i in 1:nrow(periods)) {
  df$min_ma[which(df$interval_min == periods$name[i])] <- periods$min_ma[i]
  df$max_ma[which(df$interval_max == periods$name[i])] <- periods$max_ma[i]
}

# Assign great evolutionary fauna categories
df$fauna <- NA
cambrian <- c("Trilobita",
              "Polychaeta",
              "Monoplacophora",
              "Inarticulata",
              "Hyolitha")

paleozoic <- c("Anthozoa",
               "Articulata",
               "Cephalopoda",
               "Crinoidea",
               "Ostracoda",
               "Stelleroidea",
               "Stenolaemata")

modern <- c("Bivalvia",
            "Chondrichthyes",
            "Demospongia",
            "Echinoidea",
            "Gastropoda",
            "Gymnolaemata",
            "Malacostraca",
            "Osteichthyes")

df$fauna[which(df$class %in% cambrian)] <- "Cambrian"
df$fauna[which(df$class %in% paleozoic)] <- "Paleozoic"
df$fauna[which(df$class %in% modern)] <- "Modern"


# Clean-up ----------------------------------------------------------------
# Data clean
df <- df[, c("phylum", "class", "order", "genus", "fauna", "interval_max",
             "interval_min", "max_ma", "min_ma")]

# Generate sepkoski object
sepkoski <- df

# Save data
use_data(sepkoski, internal = FALSE, overwrite = TRUE)
