#' Plot Sepkoski's evolutionary fauna using base R
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
#' @param plot_args \code{list}.
#' @param axis_args \code{list}.
#' @param legend_args \code{list}.
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
#' sepkoski_curve_base()
#'
#' # Plot curve with user-defined arguments
#' sepkoski_curve_base(title = "Sepkoski's curve",
#'                col = "black",
#'                fill = TRUE,
#'                legend = FALSE)
#' @export
sepkoski_curve_base <- function(plot_args = NULL,
                                axis_args = NULL,
                                legend_args = NULL) {

  ### ERROR HANDLING ###
  if (!is.null(plot_args) && !is.list(plot_args)) {
    stop("`plot_args` should be NULL or of class list")
  }
  if (!is.null(axis_args) && !is.list(axis_args)) {
    stop("`axis_args` should be NULL or of class list")
  }
  if (!is.null(legend_args) && !is.list(legend_args)) {
    stop("`legend_args` should be NULL or of class list")
  }

  ### ARGUMENT SETUP ###
  args <- list(plot_args = NULL, axis_args = NULL, legend_args = NULL)

  ## Plotting ##
  # Set up default arguments
  default_args <- list(x = NULL,
                       y = NULL,
                       xlab = "Time (Ma)",
                       ylab = "Number of Genera",
                       xlim = c(max(stages$mid), 0),
                       ylim = c(0, max(stages$total)),
                       col = c("#FDE725FF",
                               "#35B779FF",
                               "#31688EFF",
                               "#440154FF"),
                       type = "n",
                       xaxt = "n",
                       xaxs = "i",
                       yaxs = "i")

  # Collect user_args
  user_args <- plot_args
  # Add user args
  args$plot_args <- combine_args(default = default_args, user = user_args)

  ## axis ##
  default_args <- list(intervals = "periods")
  # Collect user_args
  user_args <- axis_args
  # Add user args
  args$axis_args <- combine_args(default = default_args, user = user_args)

  ## legend ##
  default_args <- list(x = "topleft",
                       legend = c("Cambrian", "Palaeozoic",
                                  "Modern", "Unassigned"),
                       fill = args$plot_args$col,
                       border = "black",
                       cex = 0.75,
                       bty = "n")
  # Collect user_args
  user_args <- legend_args
  # Add user args
  args$legend_args <- combine_args(default = default_args, user = user_args)

  ### GENERATE PLOT ####

  # Set factor levels
  stages$group <- factor(stages$group, levels = c("Cambrian", "Palaeozoic",
                                                  "Modern", "Unassigned"))

  # Prepare data for plotting
  l <- split.data.frame(x = stages, f = stages$group)
  # Handle colours
  l$Cambrian$col <- args$plot_args$col[1]
  l$Palaeozoic$col <- args$plot_args$col[2]
  l$Modern$col <- args$plot_args$col[3]
  l$Unassigned$col <- args$plot_args$col[4]

  # Base
  do.call(plot, args$plot_args)

  # Add polygons
  y <- 0
  for (i in l) {
    i$ymin <- y
    i$ymax <- y + i$value
    y <- y + i$value
    polygon(x = c(i$mid_ma, rev(i$mid_ma)),
            y = c(i$ymin, rev(i$ymax)),
            col = i$col[1])
  }

  ### GENERATE AXIS ###
  do.call(axis_geo, args$axis_args)

  ### GENERATE LEGEND ###
  do.call(legend, args$legend_args)
}
