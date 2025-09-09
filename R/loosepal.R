#' loose palettes
#'
#' Palettes for looseVis
#'
#' @format ## `pals`
#' An object of class `palettes_palette` with `r length(pals)`
#' colour palettes. Use `names(pals)` to return all palette names.
#' @source <https://github.com/lu-harr/looseVis>
#' @author [Lucinda Harrison](https://github.com/lu-harr)
#' @seealso [pal_palette()], [pal_colour()]
#' @examples
#' # Get all palettes by name.
#' names(pals)
#'
#' # Plot all palettes.
#' plot(pals)
"pals"

# a collection of special hexes
library(palettes)

# Discrete palettes -----------------------------------------------------------
pals <- pal_palette(
  loosepal = c(brat = "#8ACE00",
                   apple = "#6DCD59FF",
                   berry = "#c23375",
                   purp = "#8612ff",
                   iddu = "#27aae1",
                   orange = "orange")
)

usethis::use_data(pals, overwrite = TRUE)

