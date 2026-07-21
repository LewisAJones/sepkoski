# Interval table for linking and standardising intervals

This dataset provides the interval table used for updating the intervals
in Sepkoski's fossil marine animal genera compendium with the
[International Geological Time Scale
2023](https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf).
This table was generated based on published literature and the [GeoWhen
Database](https://timescalefoundation.org/resources/geowhen/index.html).
In the majority of cases, this was a clear conversion. However, in
several cases reasonable interpretation was required.

## Usage

``` r
interval_table
```

## Format

A `data.frame` with 302 rows and 4 variables:

- interval_max:

  A character denoting the oldest international geological stage.

- interval_min:

  A character denoting the youngest international geological stage.

- code:

  A character denoting the original interval abbreviation.

- original_interval:

  A character denoting the original interval.
