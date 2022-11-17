curve <- function(title = NULL, height = 0.05, cols = NULL,
                  int_lab = TRUE, fill = FALSE,
                  legend = TRUE, legend_size = 1) {

  # Base plot
  plot(x = stages$mid_ma,
       y = stages$total_counts,
       main = title,
       xlab = "Time (Ma)",
       ylab = "Number of Genera",
       xlim = c(max(stages$max_ma), 0),
       ylim = c(0, max(stages$total_counts)),

       type = "n",
       col = "blue",
       yaxt = "n",
       xaxt = "n",
       xaxs = "i")
  axis(side = 2, at = seq(0, 6000, 1000))
  axis(side = 1, at = seq(from = 500, to = 0, by = -50))
  # Add polygons
  stages$base <- 0
  # Define colours
  if (is.null(cols)) {
    cols <- c("#376795", "#72bcd5", "#ffd06f", "#ef8a47")
  }
  if (fill == FALSE) {
    periods$colour <- "white"
  }
  if (int_lab == FALSE) {
    periods$abbrev <- ""
  }
  # All
  polygon(x = c(stages$mid_ma, rev(stages$mid_ma)),
          y = c(stages$total_counts, rev(stages$base)),
          col = cols[1])
  # Modern
  polygon(x = c(stages$mid_ma, rev(stages$mid_ma)),
          y = c((stages$modern_counts + stages$paleozoic_counts + stages$cambrian_counts),
                rev(stages$base)),
          col = cols[2])
  # Paleozoic
  polygon(x = c(stages$mid_ma, rev(stages$mid_ma)),
          y = c((stages$paleozoic_counts + stages$cambrian_counts),
                rev(stages$base)),
          col = cols[3])
  # Cambrian
  polygon(x = c(stages$mid_ma, rev(stages$mid_ma)),
          y = c((stages$cambrian_counts),
                rev(stages$base)),
          col = cols[4])
  # Get user data
  ext <- par("usr")
  # Relative height
  height <- 0 - ((ext[4] - ext[3]) * height)

  # Drop Quaternary abbrev
  periods$abbrev[which(periods$abbrev == "Q")] <- ""

  # Add polygons to bottom of plot
  for (i in seq_len(nrow(periods))) {
    polygon(x = c(periods$min_ma[i], periods$min_ma[i], periods$max_ma[i], periods$max_ma[i]),
            y = rep(c(0, height, height, 0)),
            col = periods$colour[i],
            lty = 1,
            lwd = 1,
            xpd = TRUE)
    text(x = periods$mid_ma,
         y = height / 2,
         labels = periods$abbrev,
         xpd = TRUE)
  }
  # Add text
  # Add a legend
  if (legend == TRUE) {
  legend("topleft", legend = c("Unassigned", "Modern", "Paleozoic", "Cambrian"),
         col = cols, pch = 15, cex = legend_size, bty = "n")
  }
}
curve(title = "test", height = 0.05, cols = NULL, int_lab = TRUE, fill = FALSE,
      legend = TRUE, legend_size = 1)
curve()
