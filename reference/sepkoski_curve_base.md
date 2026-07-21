# Plot Sepkoski's evolutionary fauna using base R

This function plots Sepkoski's evolutionary fauna (Sepkoski, 1981),
using the Sepkoski (2002) fossil marine animal genera compendium (i.e.
the included
[sepkoski](https://sepkoski.palaeoverse.org/reference/sepkoski.md)
dataset). No changes have been made to any taxonomic names in this
dataset. However, first and last appearance intervals have been updated
to stages from the [International Geological Time Scale
2023](https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf). As
such, minor differences may be observed to previously published plots.
See
[interval_table](https://sepkoski.palaeoverse.org/reference/interval_table.md)
for interval definitions.

## Usage

``` r
sepkoski_curve_base(plot_args = NULL, axis_args = NULL, legend_args = NULL)
```

## Arguments

- plot_args:

  `list`. A named list of optional arguments that are passed directly to
  [`graphics::plot()`](https://rdrr.io/r/graphics/plot.default.html). If
  `NULL` (default), a default list of arguments are used.

- axis_args:

  `list`. A named list of optional arguments that are passed directly to
  [`palaeoverse::axis_geo()`](https://palaeoverse.palaeoverse.org/reference/axis_geo.html).
  If `NULL` (default), a default list of arguments are used. If `FALSE`,
  no axis is added.

- legend_args:

  `list`. A named list of optional arguments that are passed directly to
  [`graphics::legend()`](https://rdrr.io/r/graphics/legend.html). If
  `NULL` (default), a default list of arguments are used. If `FALSE`, no
  legend is added.

## Value

No return value. Function is used to plot Sepkoski's curve with
user-defined arguments.

## Details

Taxa are assigned to evolutionary fauna (EF) categories as follows:

- Cambrian EF: Trilobita, Polychaeta, Tergomya ("Monoplacophora"),
  Inarticulata, and Hyolithomorpha.

- Paleozoic EF: Anthozoa, Articulata, Asteroidea, Cephalopoda,
  Crinoidea, Ostracoda, Ophiuroidea, Somasteroidea, and Stenolaemata.

- Modern EF: Bivalvia, Chondrichthyes, Demospongia, Echinoidea,
  Gastropoda, Gymnolaemata, Malacostraca, and Osteichthyes.

## References

Sepkoski, J. J. (1981). A factor analytic description of the Phanerozoic
marine fossil record. *Paleobiology*, 7(1), pp. 36–53.

Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
*Bulletins of American Paleontology*, 363, pp. 1–560.

## Examples

``` r
# Plot curve with default arguments
sepkoski_curve_base()


# Plot curve with user-defined arguments
sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve"),
                    axis_args = list(intervals = list("stages", "periods"),
                                    lab = FALSE),
                    legend_args = list(bty = "o"))
```
