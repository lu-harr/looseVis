#' Prepare rast (stack) for ggplot
#'
#' @param ras SpatRaster
#'
#' @returns data.frame with columns "x", "y", "lyr", "val"
#' @export
#'
#' @examples
#' ras <- rast(rnorm(100))
#' df <- rast_to_df(ras)
rast_to_df <- function(ras){
  # this definitely already exists
  out <- cbind(terra::xyFromCell(ras, 
                                 cell = terra::cells(ras)), 
               terra::extract(ras, 
                              terra::cells(ras)))
  
  names(out) <- c("x", "y", names(ras))
  
  out <- out %>%
    pivot_longer(names(ras), names_to = "lyr", values_to = "val") %>%
    mutate(lyr = factor(lyr, levels = names(ras)))
  
  out
}

#' Wrap a rough shortcut from rast to ggplot
#' 
#' I guess I would terra::plot() would have been fine but at least I can add 
#' layers to the object that is returned
#'
#' @param ras SpatRaster
#'
#' @returns ggplot
#' @export
#'
#' @examples
#' ras <- rast(rnorm(100))
#' rast_plot(ras)
rast_plot <- function(ras){
  # just a shortcut no bells or whistles
  df <- rast_to_df(ras)
  
  if (length(unique(df$lyr)) > 1){
    
    ggplot(data = df) +
      geom_tile(aes(x = x, y = y, fill = val)) +
      facet_wrap(~lyr)
    
  } else {
    
    ggplot(data = df) +
      geom_tile(aes(x = x, y = y, fill = val))
    
  }
}



