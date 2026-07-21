# Sepkoski's marine animal genera compendium

This dataset is a port of [Sepkoski's
(2002)](https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up)
published compendium of fossil marine animal genera. This version of the
dataset was pulled from Shanan Peters' [online
database](http://strata.geology.wisc.edu/jack/). No changes have been
made to any taxonomic names. However, first and last appearance
intervals have been updated to stages from the [International Geological
Time Scale
2023](https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf). In
updating interval names, some interpretation was required. The
[interval_table](https://sepkoski.palaeoverse.org/reference/interval_table.md)
dataset documents the linked interval names.

## Usage

``` r
sepkoski
```

## Format

A `data.frame` with 35826 rows and 9 variables:

- phylum:

  A character denoting the phylum of the taxon.

- class:

  A character denoting the class of the taxon.

- order:

  A character denoting the order of the taxon.

- genus:

  A character denoting the genus of the taxon.

- fauna:

  A character denoting the great evolutionary fauna type of the taxon.

- interval_max:

  A character denoting the interval of first occurrence.

- interval_min:

  A character denoting the interval of last occurrence.

- max_ma:

  A numeric denoting the interval age of first occurrence.

- min_ma:

  A numeric denoting the interval age of last occurrence.

## Source

Shanan Peter's 'Sepkoski's Online Genus Database':
<http://strata.geology.wisc.edu/jack/>.

## References

Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
*Bulletins of American Paleontology*, 363, pp. 1–560.
