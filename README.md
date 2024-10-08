# sepkoski <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/LewisAJones/sepkoski/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/LewisAJones/sepkoski/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/LewisAJones/sepkoski/branch/main/graph/badge.svg?token=47HS5IX7M1)](https://app.codecov.io/gh/LewisAJones/sepkoski?branch=main)
[![CRAN status](https://www.r-pkg.org/badges/version/sepkoski)](https://CRAN.R-project.org/package=sepkoski)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/sepkoski)](https://cran.r-project.org/package=sepkoski)
[![DOI](https://zenodo.org/badge/564230284.svg)](https://zenodo.org/badge/latestdoi/564230284)
[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/LewisAlanJones.svg?style=social&label=Follow%20%40LewisAlanJones)](https://twitter.com/LewisAlanJones)
<!-- badges: end -->

## Overview

`sepkoski` is a data R package of Sepkoski's fossil marine animal genera compendium (Sepkoski, 2002), ported from Shanan Peters' [online database](http://strata.geology.wisc.edu/jack/).

The aim of `sepkoski` is to provide a light and easily-accessible solution to working with Sepkoski's compendium to support teaching exercises. The package provides access to:

- `sepkoski_raw` Sepkoski's raw fossil marine animal genera compendium (Sepkoski, 2002).
- `sepkoski` Sepkoski's compendium with first and last appearance intervals updated to be consistent with stages from the [International Geological Time Scale 2023](https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf).
- `interval_table` A table linking intervals in Sepkoski's compendium with the [International Geological Time Scale 2023](https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf).
- A function (`sepkoski_curve()`) for plotting Sepkoski's evolutionary fauna with ggplot for easy reproduction in presentations, articles, etc.
- A function (`sepkoski_curve_base()`) for plotting Sepkoski's evolutionary fauna with base R for easy reproduction in presentations, articles, etc.

Note: In updating interval names, some interpretation was required. The `interval_table` dataset documents the linked interval names. If you notice any issue, or disagree with any of these assignments, please feel free to raise a GitHub issue, and I will do my best to address them as soon as possible.

## Installation

The stable version of `sepkoski` can be installed via the CRAN using:

```r
# Install stable version of the package
install.packages("sepkoski")
```

The development version of `sepkoski` can be installed via GitHub using:

```r
# Install development version of the package
devtools::install_github("LewisAJones/sepkoski")
```

## Usage

```r
# Load library
library(sepkoski)
```

The datasets in `sepkoski` can be easily accessed via:

```r
# Raw dataset
data("sepkoski_raw")
# Updated interval dataset
data("sepkoski")
# Interval table
data("interval_table")
```

The only two functions in the `sepkoski` package at this time are `sepkoski_curve()` and `sepkoski_curve_base()`. These can be used to plot--with base R or ggplot2--Sepkoski's evolutionary fauna (Sepkoski, 1981) using the Sepkoski (2002) fossil marine animal genera compendium. Users may provide their own values to function arguments or add layers to customise the appearance, or simply use the default arguments:

## Base R

```r
sepkoski_curve_base()
```
![Plot with default arguments](man/figures/sepkoski_curve_base.png)
Default Phanerozoic plot of Sepkoski's three great evolutionary fauna. Number of genera are counted per international geological stage bin.

```r
sepkoski_curve_base(plot_args = list(main = "Sepkoski's Curve",
                                     xlab = "Age (Ma)",
                                     col = c("#2171b5",
                                             "#6baed6",
                                             "#bdd7e7", 
                                             "#eff3ff")),
                    axis_args = list(intervals = list("stages", "periods"),
                                     lab = list(FALSE, TRUE),
                                     height = 0.04))
```
![Plot with default arguments](man/figures/sepkoski_curve_base_custom.png)
Custom Phanerozoic plot of Sepkoski's three great evolutionary fauna. Number of genera are counted per international geological stage bin.

## ggplot2

```r
sepkoski_curve()
```
![Plot with default arguments](man/figures/sepkoski_curve.png)
Default Phanerozoic plot of Sepkoski's three great evolutionary fauna. Number of genera are counted per international geological stage bin.

```r
library(ggplot2)
library(deeptime)
sepkoski_curve() +
  scale_fill_brewer() +
  coord_geo(
    pos = as.list(rep("bottom", 2)),
    dat = list("stages", "periods"),
    height = list(unit(2, "lines"), unit(2, "line")),
    size = list(4, 4),
    lab = list(FALSE, TRUE))
```
![Plot with default arguments](man/figures/sepkoski_curve_custom.png)
Custom Phanerozoic plot of Sepkoski's three great evolutionary fauna. Number of genera are counted per international geological stage bin.

## References

> Sepkoski, J. J. (1981). A factor analytic description of the Phanerozoic marine fossil record. *Paleobiology*, 7(1), pp. 36-53.

> Sepkoski, J. J. (2002). A compendium of fossil marine animal genera. *Bulletins of American paleontology*, 363, pp. 1-560.

> Peters, S. (2022). [Sepkoski's Online Genus Database](http://strata.geology.wisc.edu/jack/). 

