#' Reset the plotting window
#' 
#' Give me an empty plot on top of my *existing* plot so that I can add a legend or other additional annotations. 
#' For example, if I have a multi-panel plot and for some reason can't add subfigure labels to each of them.
#' The extent of the new plot is c(0,1,0,1)
#'
#' @return TRUE
#' @export
#'
#' @examples empty_plot_for_legend()
empty_plot_for_legend = function(){
  plot(0, type="n", xaxt="n", yaxt="n", xlab="", ylab="", bty="n", xlim=c(0,1), ylim=c(0,1))
}