#' Plot Sepkoski's evolutionary fauna using ggplot
#'
#' This function plots Sepkoski's evolutionary fauna (Sepkoski, 1981), using the
#' Sepkoski (2002) fossil marine animal genera compendium (i.e. the included
#' \link[sepkoski]{sepkoski} dataset). No changes have been made to any
#' taxonomic names in this dataset. However, first and last appearance
#' intervals have been updated to stages from the
#' [International Geological Time Scale 2023](
#' https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf). As
#' such, minor differences may be observed to previously published plots. See
#' \link[sepkoski]{interval_table} for interval definitions.
#'
#' @return Function is primiarly used to plot Sepkoski's curve with ggplot2. A
#' ggplot object is returned invisibly.
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
#' @importFrom ggplot2 ggplot geom_area scale_fill_viridis_d aes element_blank
#' @importFrom ggplot2 scale_x_reverse xlab ylab theme_bw theme guides guide_legend
#' @importFrom deeptime coord_geo
#' @importFrom rlang .data
#'
#' @examples
#' # Generate default plot
#' sepkoski_curve()
#'
#' # Customise plot colours
#' library(ggplot2)
#' sepkoski_curve() +
#'   scale_fill_brewer()
#'
#' # Customise geological timescale
#' library(deeptime)
#' sepkoski_curve() +
#'   coord_geo(
#'     pos = as.list(rep("bottom", 2)),
#'     dat = list("stages", "periods"),
#'     height = list(unit(1, "lines"), unit(1, "line")),
#'     size = list(2.5, 2.5),
#'     lab = list(FALSE, TRUE))
#' @export
sepkoski_curve <- function() {
  ggplot(data = stages,
         aes(x = .data$max_ma, y = .data$value, fill = .data$group)) +
    geom_area(colour = "black") +
    scale_fill_viridis_d() +
    scale_x_reverse() +
    # Axes titles
    xlab("Time (Ma)") +
    ylab("Number of Genera") +
    guides(fill = guide_legend(reverse = TRUE)) +
    theme_bw() +
    theme(panel.grid = element_blank(),
          legend.title = element_blank(),
          legend.position = "bottom") +
    coord_geo()
}
