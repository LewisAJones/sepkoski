# Load libraries ----------------------------------------------------------
library(rvest)
library(tidyverse)

# Scrape data -------------------------------------------------------------

# Scrape links
links <- read_html("http://strata.geology.wisc.edu/jack/start.php") %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  .[grep("showgenera.*", .)]

# Generate links
links <- paste0("http://strata.geology.wisc.edu/jack/", links)

# Create empty df
main <- data.frame()

# Run for loop
for (i in links) {

  # Scrape data
  scrape <- read_html(i)

  # Get heading
  heading <- scrape %>%
    html_nodes("h2") %>%
    html_text()

  # Extract class or phylum
  name <- str_extract_all(heading, "[A-Z]+")[[1]]
  name <- print(paste(name,collapse=' '))

  ops <- c("class", "phylum")
  rank_name <- ops[sapply(ops, grepl, heading)]

  # Extract column names
  cols <- scrape %>%
    html_nodes("th") %>%
    html_text()

  # Extract table contents
  values <- scrape %>%
    html_nodes("td") %>%
    html_text()

  # Bind data
  df <- data.frame(matrix(data = values, ncol = length(cols), byrow = TRUE))

  # Assign column names
  colnames(df) <- cols

  # Add higher rank
  tmp <- data.frame(name = rep(name, nrow(df)), rank = rep(rank_name, nrow(df)))

  # Bind data
  df <- cbind.data.frame(tmp, df)

  # Bind data
  main <- rbind.data.frame(main, df)
}
# Save data
saveRDS(main, "./inst/extdata/sepkoski_scrape.RDS", compress = "xz")
