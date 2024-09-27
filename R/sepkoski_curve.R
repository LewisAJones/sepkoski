#' Plot Sepkoski's evolutionary fauna using ggplot
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
#' @importFrom ggplot2 ggplot geom_area scale_fill_viridis_d aes element_blank
#' @importFrom ggplot2 scale_x_reverse xlab ylab theme_bw theme
#' @importFrom deeptime coord_geo
#'
#' @examples
#' # Generate default plot
#' sepkoski_curve()
#' # Customise plot
#' sepkoski_curve() +
#'   scale_fill_brewer()
#' @export
sepkoski_curve <- function() {
  ggplot(data = stages, aes(x = mid_ma, y = value, fill = group)) +
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
