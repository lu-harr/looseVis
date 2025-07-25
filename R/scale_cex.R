#' Scale value for point size (for example)
#' 
#' A function to transform a vector of numerics and return the data scaled
#' between `min_cex` and `max_cex`. Useful for scaling point sizes and, I assume, 
#' other things.
#'
#' @param from vector of numerics
#' @param trans function that takes a numeric as input, e.g., `log10`, `exp`, `sqrt`, ...
#' @param min_cex numeric, >= 0 & <= `max_cex`
#' @param max_cex numeric, >= 0 & >= `min_cex`
#'
#' @returns vector of transformed data
#' @export
#'
#' @examples 
#' x <- rexp(100)
#' scaled_cex <- scale_cex(x, log10)
scale_cex <- function(from, trans = log10, min_cex = 0.5, max_cex = 1){
  
  if (trans(0) == -Inf & min(from) <= 0){
    message("Kindly don't ask me to log things I would rather not")
    return(TRUE)
  }
  
  if (is.nan(trans(-1)) & min(from) < 0){
    message("Nup sorry no can do")
    return(TRUE)
  }
  
  to <- trans(from)
  to <- (to - min(to)) / (max(to) - min(to))
  to * (max_cex - min_cex) + min_cex
}
