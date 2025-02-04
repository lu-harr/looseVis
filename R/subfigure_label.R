#' Give me a subfigure label
#'
#' @param plot_region coordinates of plotting region, e.g. par()$usr
#' @param x_displacement numeric between 0 and 1 indicating proportional x displacement (0 for far left, 1 for far right)
#' @param y_displacement numeric between 0 and 1 indicating proportional y displacement (0 for bottom, 1 for top)
#' @param label character vector to add to plot
#' @param cex.label numeric to control label size. Defaults to 1.
#'
#' @return TRUE
#' @export
#'
#' @examples subfigure_label(par()$usr, 0.1, 0.9, "(a)", 1.3)
subfigure_label = function(plot_region, x_displacement, y_displacement, label,
                           cex.label=1){
  # gives me an (a)
  text(plot_region[1] + (plot_region[2] - plot_region[1])*x_displacement, 
       plot_region[3] + (plot_region[4] - plot_region[3])*y_displacement,
       label, cex=cex.label)
}