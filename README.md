# sepkoski <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/LewisAJones/sepkoski/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/LewisAJones/sepkoski/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/LewisAJones/sepkoski/branch/main/graph/badge.svg)](https://app.codecov.io/gh/LewisAJones/sepkoski?branch=main)
<!-- badges: end -->

## Overview

`sepkoski` is a data R package of Sepkoski's fossil marine animal genera compendium (Sepkoski, 2002).

The aim of `sepkoski` is to provide a light and easily-accessible solution to Sepkoski's compendium to support teaching exercises. The package provides access to:

- Sepkoski's raw fossil marine animal genera compendium
- Sepkoski's compendium with first and last appearance intervals updated to be consistent with international stages from the Geological Time Scale 2022
- An interval table linking intervals in Sepkoski's fossil marine animal genera compendium with the International Geological Time Scale 2022.
- A function for plotting Sepkoski's evolutionary fauna for easy reproduction in presentations, articles, etc.

*In updating interval names, some interpretation was required. The `interval_table` dataset documents the linked interval names. If you notice any issue, or disagree with any of these assignments, please feel free to raise a GitHub issue, and I will do my best to address them as soon as possible.*

## Installation

The development version of `sepkoski` can be installed via GitHub using:

```r
devtools::install_github("LewisAJones/sepkoski")
```

## Usage

```r
# Load library
library(sepkoski)
```

The only function in the `sepkoski` package at this time is the `sepkoski_curve()`. This can be used to plot Sepkoski's evolutionary fauna (Sepkoski, 1981) using the Sepkoski (2002) fossil marine animal genera compendium. 

```r
sepkoski_curve()
```
![Plot with default arguments](man/figures/example_curve.png)
