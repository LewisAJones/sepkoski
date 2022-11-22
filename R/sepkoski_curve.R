#' Plot Sepkoski's evolutionary fauna
#'
#' This function plots Sepkoski's evolutionary fauna (Sepkoski, 1981), using the
#' Sepkoski (2002) fossil marine animal genera compendium (i.e. the included
#' \link[sepkoski]{sepkoski} dataset). No changes have been made to any
#' taxonomic names in this dataset. However, first and last appearance
#' intervals have been updated to stages from the
#' [International Geological Time Scale 2022](
#' https://stratigraphy.org/ICSchart/ChronostratChart2022-02.pdf). As
#' such, minor differences may be observed to previously published plots.
#'
#' @param title \code{character}. Title of the plot. Defaults to \code{NULL}.
#' @param height \code{numeric}. Height of the Geological Time Scale relative
#' to the plot area. Defaults to 0.05.
#' @param cols \code{character}. The colours of the polygons in the plot area.
#' @param int_lab \code{logical}. Should interval labels be added? Defaults to
#' TRUE.
#' @param int_size \code{numeric}. The size of the interval labels. Defaults to
#' 1.
#' @param fill \code{logical}. Should interval boxes be plotted with the ICS
#' colour scheme? Defaults to \code{FALSE}.
#' @param legend \code{logical}. Should a legend be added to the plot? Defaults
#' to \code{TRUE}.
#' @param legend_size \code{numeric}. The size of the legend. Defaults to 1.
#'
#' @return No return value. Function is used to plot Sepkoski's curve with
#' user-defined arguments.
#'
#' @details Taxa are assigned to evolutionary fauna (EF) categories as follows:
#'
#' - Cambrian EF: Trilobita, Polychaeta, Tergomya ("Monoplacophora"),
#' Inarticulata, and Hyolithomorpha.
#' - Paleozoic EF: Anthozoa, Articulata, Asteroidea, Cephalopoda, Crinoidea,
#' Ostracoda, Ophiuroidea, Somasteroidea, and Stenolaemata.
#' - Modern EF: Bivalvia, Chondrichthyes, Demospongia, Echinoidea, Gastropoda,
#' Gymnolaemata, Malacostraca, and Osteichthyes.
#'
#' @section References:
#' Sepkoski, J. J. (1981).  A factor analytic description of the Phanerozoic
#' marine fossil record. *Paleobiology*, 7(1), pp. 36--53.
#'
#' Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
#' *Bulletins of American Paleontology*, 363, pp. 1--560.
#'
#' @importFrom graphics polygon axis par text
#'
#' @examples
#' # Plot curve with default arguments
#' sepkoski_curve()
#'
#' # Plot curve with user-defined arguments
#' sepkoski_curve(title = "Sepkoski's curve",
#'                col = "black",
#'                fill = TRUE,
#'                legend = FALSE)
#' @export
sepkoski_curve <- function(title = NULL, height = 0.05, cols = NULL,
                  int_lab = TRUE, int_size = 1, fill = FALSE,
                  legend = TRUE, legend_size = 1) {
  # Error handling
  if (!is.character(title) && !is.null(title)) {
    stop("`title` must be character (or NULL)")
  }
  if (!is.numeric(height)) {
    stop("`height` must be numeric")
  }
  if (!is.null(cols) && !is.character(cols)) {
    stop("`cols` must be character (or NULL)")
  }
  if (!is.logical(int_lab)) {
    stop("`int_lab` must be logical")
  }
  if (!is.numeric(int_size)) {
    stop("`int_size` must be numeric")
  }
  if (!is.logical(fill)) {
    stop("`fill` must be logical")
  }
  if (!is.logical(legend)) {
    stop("`legend` must be logical")
  }
  if (!is.numeric(legend_size)) {
    stop("`legend_size` must be numeric")
  }
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
          y = c((stages$modern_counts +
                 stages$paleozoic_counts +
                 stages$cambrian_counts),
                rev(stages$base)),
          col = cols[2])
  # Paleozoic
  polygon(x = c(stages$mid_ma, rev(stages$mid_ma)),
          y = c((stages$paleozoic_counts +
                 stages$cambrian_counts),
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
    polygon(x = c(periods$min_ma[i],
                  periods$min_ma[i],
                  periods$max_ma[i],
                  periods$max_ma[i]),
            y = rep(c(0, height, height, 0)),
            col = periods$colour[i],
            lty = 1,
            lwd = 1,
            xpd = TRUE)
    text(x = periods$mid_ma[i],
         y = height / 2,
         labels = periods$abbrev[i],
         cex = int_size[i],
         xpd = TRUE)
  }
  # Add text
  # Add a legend
  if (legend == TRUE) {
  legend("topleft", legend = c("Unassigned", "Modern", "Paleozoic", "Cambrian"),
         col = cols, pch = 15, cex = legend_size, bty = "n")
  }
}
