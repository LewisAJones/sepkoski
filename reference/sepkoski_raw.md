# Sepkoski's marine animal genera compendium (raw)

This dataset is a port of [Sepkoski's
(2002)](https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up)
published compendium of fossil marine animal genera. This version of the
dataset was pulled from Shanan Peters' [online
database](http://strata.geology.wisc.edu/jack/). No changes have been
made to any taxonomic names or first and last appearance data. The
definitions of stage/period abbreviations are provided in [Sepkoski's
(2002)](https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up),
or can be accessed via the included
[interval_table](https://sepkoski.palaeoverse.org/reference/interval_table.md)
for convenience.

## Usage

``` r
sepkoski_raw
```

## Format

A `data.frame` with 35826 rows and 8 variables:

- phylum:

  A character denoting the phylum of the taxon.

- class:

  A character denoting the class of the taxon.

- order:

  A character denoting the order of the taxon.

- genus:

  A character denoting the genus of the taxon.

- FOP:

  A character denoting the geological period of first occurrence.

- FOS:

  A character denoting the geological stage of last occurrence.

- LOP:

  A character denoting the geological period of first occurrence.

- LOS:

  A character denoting the geological stage of last occurrence.

## Source

Shanan Peter's 'Sepkoski's Online Genus Database':
<http://strata.geology.wisc.edu/jack/>.

## References

Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
*Bulletins of American Paleontology*, 363, pp. 1–560.
