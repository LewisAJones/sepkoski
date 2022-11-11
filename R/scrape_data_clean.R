# Load libraries
library(rvest)
library(tidyverse)

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

# Clean up data output
main$Genus[grep(pattern = "\xef", main$Genus)] <- c("Heliocïenia")
main$Genus[grep(pattern = "\xe5", main$Genus)] <- c("Såkwia")
main$Genus[grep(pattern = "\xf3", main$Genus)] <- c("Mikrocidarió")
main$Genus[grep(pattern = "\xe1", main$Genus)] <- c("Cályxhydra")
main$Genus[grep(pattern = "\xf2", main$Genus)] <- c("Còyptoporocyathus")

# Replace `uncertain` with NA
main$Genus[which(main$Genus == "uncertain")] <- NA
main$Order[which(main$Order == "uncertain")] <- NA

# Replace missing assignments with NA
main$LOS[which(main$LOS == "&nbsp")] <- NA

# Update period abbreviations
int_key <- data.frame(abbrev = c("P", "Tr", "T", "K", "J", "R", "D", "C", "O", "S", "Cm", "Q", "V"),
                      interval = c("Permian", "Triassic", "Tertiary", "Cretaceous", "Jurassic",
                                   "Recent", "Devonian", "Carboniferous", "Ordivician", "Silurian",
                                   "Cambrian", "Quaternary", "Phanerozoic"))
int_key <- list(nodata = c("?"),
                Aalenian = c("Aale"),
                Albian = c("Albi", "Albi-l", "Albi-m", "Albi-u"),
                Anisian = c("Anis", "Anis-l", "Anis-u"),
                Aptian = c("Apti", "Apti-l", "Apti-u"),
                Floian = c("Arenig", "Aren", "Aren-l", "Aren-u"),
                Hirnantian = c("Ashgill", "Ashg", "Ashg-l", "Ashg-m", "Ashg-l"),
                Asselian = c("Asse", "Asse-l", "Asse-u"),
                Stage2 = c("Atdabanian", "Atda", "Atda-l", "Atda-u"))



sort(unique(c(main$FOS, main$LOS)))

# Seperate data for processing
phylum <- main[which(main$rank == "phylum"), ]
class <- main[which(main$rank == "class"), ]

class$phylum <- NA

for (i in 1:nrow(class)) {
  phy <- phylum[which(phylum$Genus %in% class$Genus[i]), c("name")]
  class$phylum[i] <- phy
}
