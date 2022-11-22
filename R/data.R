#' Sepkoski's marine animal genera compendium
#'
#' This dataset is a port of [Sepkoski's (2002)](
#' https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up)
#' published compendium of fossil marine animal genera.
#' This version of the dataset was pulled from Shanan Peters' [online database](
#' http://strata.geology.wisc.edu/jack/). No changes have been made to any
#' taxonomic names. However, first and last appearance intervals have been
#' updated to stages from the [International Geological Time Scale 2022](
#' https://stratigraphy.org/ICSchart/ChronostratChart2022-02.pdf). In
#' updating interval names, some interpretation was required. The
#' \link[sepkoski]{interval_table} dataset documents the linked interval names.
#'
#' @format A \code{data.frame} with 35826 rows and 9 variables:
#' \describe{
#'   \item{phylum}{A character denoting the phylum of the taxon.}
#'   \item{class}{A character denoting the class of the taxon.}
#'   \item{order}{A character denoting the order of the taxon.}
#'   \item{genus}{A character denoting the genus of the taxon.}
#'   \item{fauna}{A character denoting the great evolutionary fauna type of
#'   the taxon.}
#'   \item{interval_max}{A character denoting the interval of first occurrence.}
#'   \item{interval_min}{A character denoting the interval of last occurrence.}
#'   \item{max_ma}{A numeric denoting the interval age of first occurrence.}
#'   \item{min_ma}{A numeric denoting the interval age of last occurrence.}
#' }
#' @section References:
#' Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
#' *Bulletins of American Paleontology*, 363, pp. 1--560.
#' @source {Shanan Peter's 'Sepkoski's Online Genus Database':}
#' \url{http://strata.geology.wisc.edu/jack/}.
"sepkoski"

#' Sepkoski's marine animal genera compendium (raw)
#'
#' This dataset is a port of [Sepkoski's (2002)](
#' https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up)
#' published compendium of fossil marine animal genera.
#' This version of the dataset was pulled from Shanan Peters' [online database](
#' http://strata.geology.wisc.edu/jack/). No changes have been made to any
#' taxonomic names or first and last appearance data. The definitions of
#' stage/period abbreviations are provided in [Sepkoski's (2002)](
#' https://www.biodiversitylibrary.org/page/27980221#page/113/mode/1up), or can
#' be accessed via the included \link[sepkoski]{interval_table} for convenience.
#'
#' @format A \code{data.frame} with 35826 rows and 8 variables:
#' \describe{
#'   \item{phylum}{A character denoting the phylum of the taxon.}
#'   \item{class}{A character denoting the class of the taxon.}
#'   \item{order}{A character denoting the order of the taxon.}
#'   \item{genus}{A character denoting the genus of the taxon.}
#'   \item{FOP}{A character denoting the geological period of first occurrence.}
#'   \item{FOS}{A character denoting the geological stage of last occurrence.}
#'   \item{LOP}{A character denoting the geological period of first occurrence.}
#'   \item{LOS}{A character denoting the geological stage of last occurrence.}
#' }
#' @section References:
#' Sepkoski, J. J. (2002). A compendium of fossil marine animal genera.
#' *Bulletins of American Paleontology*, 363, pp. 1--560.
#' @source {Shanan Peter's 'Sepkoski's Online Genus Database':}
#' \url{http://strata.geology.wisc.edu/jack/}.
"sepkoski_raw"

#' Interval table for linking and standardising intervals
#'
#' This dataset provides the interval table used for updating the intervals
#' in Sepkoski's fossil marine animal genera compendium with the
#' [International Geological Time Scale 2022](
#' https://stratigraphy.org/ICSchart/ChronostratChart2022-02.pdf). This table
#' was generated based on published literature and the [GeoWhen Database](
#' https://timescalefoundation.org/resources/geowhen/index.html). In the
#' majority of cases, this was a clear conversion. However, in several cases
#' reasonable interpretation was required.
#'
#' @format A \code{data.frame} with 302 rows and 4 variables:
#' \describe{
#'   \item{interval_max}{A character denoting the oldest international
#'   geological stage.}
#'   \item{interval_min}{A character denoting the youngest international
#'   geological stage.}
#'   \item{code}{A character denoting the original interval abbreviation.}
#'   \item{original_interval}{A character denoting the original interval.}
#' }
"interval_table"
