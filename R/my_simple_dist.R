#' My simple (Euclidean) dist
#'
#' @param pos1 vector of length 2
#' @param pos2 vector of length 2
#'
#' @return numeric distance
#' @export
#'
#' @examples my_simple_dist(c(0,0), c(1,1))
my_simple_dist = function(pos1, pos2){
  # this was quicker than googling it :)))
  # for plotting only - distHaversine should be used where geographical 
  # distance is important
  return((pos1[1] - pos2[1])**2 + (pos1[2] - pos2[2])**2)
}