#' Plot Sepkoski's evolutionary fauna using base R
#'
#' This function plots Sepkoski's evolutionary fauna (Sepkoski, 1981), using the
#' Sepkoski (2002) fossil marine animal genera compendium (i.e. the included
#' \link[sepkoski]{sepkoski} dataset). No changes have been made to any
#' taxonomic names in this dataset. However, first and last appearance
#' intervals have been updated to stages from the
#' [International Geological Time Scale 2023](
#' https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf). As
#' such, minor differences may be observed to previously published plots. See
#' \link[interval_table]{interval_table} for interval definitions.
#'
#' @param plot_args \code{list}. A named list of optional arguments that are
#'   passed directly to [graphics::plot()]. If `NULL` (default), a default
#'   list of arguments are used.
#' @param axis_args \code{list}. A named list of optional arguments that are
#'   passed directly to [palaeoverse::axis_geo()]. If `NULL` (default), a
#'   default list of arguments are used. If `FALSE`, no axis is added.
#' @param legend_args \code{list}. A named list of optional arguments that are
#'   passed directly to [graphics::legend()]. If `NULL` (default), a default
#'   list of arguments are used. If `FALSE`, no legend is added.
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
#' @importFrom graphics plot polygon legend axis
#' @importFrom palaeoverse axis_geo
#'
#' @examples
#' # Plot curve with default arguments
#' sepkoski_curve_base()
#'
#' # Plot curve with user-defined arguments
#' sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve"),
#'                     axis_args = list(intervals = list("stages", "periods"),
#'                                     lab = FALSE),
#'                     legend_args = list(bty = "o"))
#' @export
sepkoski_curve_base <- function(plot_args = NULL,
                                axis_args = NULL,
                                legend_args = NULL) {

  ### ERROR HANDLING ###
  if (!is.null(plot_args) && !is.list(plot_args)) {
    stop("`plot_args` should be NULL or of class list")
  }
  if (!is.null(axis_args) &&
      !is.list(axis_args) &&
      !isFALSE(axis_args)) {
    stop("`axis_args` should be NULL or of class list")
  }
  if (!is.null(legend_args) &&
      !is.list(legend_args) &&
      !isFALSE(legend_args)) {
    stop("`legend_args` should be NULL, FALSE, or of class list")
  }

  ### ARGUMENT SETUP ###
  args <- list(plot_args = NULL, axis_args = NULL, legend_args = NULL)

  ## Plotting ##
  # Set up default arguments
  default_args <- list(x = NULL,
                       y = NULL,
                       xlab = NA,
                       ylab = "Number of Genera",
                       xlim = c(max(stages$max_ma), 0),
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
  # Set xlab
  args$plot_args$xlab <- NA
  # Recycle colours
  if (length(args$plot_args$col) < 4) {
    args$plot_args$col <- rep_len(args$plot_args$col, length.out = 4)
  }

  ## axis ##
  if (isFALSE(axis_args)) {
    args$axis_args <- FALSE
  } else {
    default_args <- list(intervals = "periods",
                         height = 0.075,
                         lab_size = 1,
                         lab_col = "black")
    # Collect user_args
    user_args <- axis_args
    # Add user args
    args$axis_args <- combine_args(default = default_args, user = user_args)
  }

  ## legend ##
  if (isFALSE(legend_args)) {
    args$legend_args <- FALSE
  } else {
    default_args <- list(x = "topleft",
                         legend = c("Cambrian", "Paleozoic",
                                    "Modern", "Unassigned"),
                         fill = args$plot_args$col,
                         border = "black",
                         cex = 0.75,
                         bty = "n")
    # Collect user_args
    user_args <- legend_args
    # Add user args
    args$legend_args <- combine_args(default = default_args, user = user_args)
  }

  ### GENERATE PLOT ####

  # Set factor levels
  stages$group <- factor(stages$group, levels = c("Cambrian", "Paleozoic",
                                                  "Modern", "Unassigned"))

  # Prepare data for plotting
  l <- split.data.frame(x = stages, f = stages$group)
  # Handle colours
  l$Cambrian$col <- args$plot_args$col[1]
  l$Paleozoic$col <- args$plot_args$col[2]
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
    polygon(x = c(i$max_ma, rev(i$max_ma)),
            y = c(i$ymin, rev(i$ymax)),
            col = i$col[1])
  }

  ### GENERATE AXIS ###
  if ("xlab" %in% names(plot_args)) {
    args$plot_args$xlab <- plot_args$xlab
  } else {
    args$plot_args$xlab <- "Time (Ma)"
  }

  if (!isFALSE(args$axis_args)) {
    do.call(axis_geo, args$axis_args)
    title(xlab = args$plot_args$xlab, line = 4)
  } else {
    axis(1)
  }

  ### GENERATE LEGEND ###
  if (!isFALSE(args$legend_args)) {
    do.call(legend, args$legend_args)
  }
}
