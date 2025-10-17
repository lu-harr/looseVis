#' Give me map labels in a circle !
#'
#' A function to arrange map labels in a circle around a shape. For each label, finds closest point on circle. Should be called after base map is produced.
#'
#' @param sites A two-column data.frame of longitudes and latitudes of the sites to be labelled, in label order
#' @param centre A vector of length 2, giving coordinates of the middle of our fairy circle
#' @param label_radius The radius of our circle (e.g., in decimal degrees)
#' @param site_names A vector of labels to add, in label order. (e.g., 1:nrow(sites))
#' @param rank_cutoff Would you like to label not all of the sites? Either FALSE or a numeric. Defaults to FALSE.
#' @param n_toadstools A numeric indicating the number of possible locations for labels on our fairy circle. Should be greater than the number of labels. Defaults to 65.
#' @param gap A numeric between 0 and 1 indicating outer endpoint of label line, as proportion of label_radius. Defaults to 0.95.
#' @param guides Would you like some guides while you work out where to put your labels? Either TRUE or FALSE. Defaults to FALSE
#' @param line_col A valid colour. Defaults to "red".
#' @param lab_col A valid colour. Defaults to "red".
#'
#' @keywords labels
#' @export
#' @examples
#' fairy_circle_labels(sites[sel,], label_radius = (plot_box[2] - plot_box[1])/2*0.9, centre = c(112.5, 0), site_names = sel, rank_cutoff = FALSE, n_toadstools = 80)

fairy_circle_labels = function(sites, 
                               centre, 
                               label_radius,
                               site_names, 
                               rank_cutoff = FALSE, 
                               n_toadstools = 65, 
                               gap = 0.95, 
                               guides = FALSE,
                               line_col = "red", 
                               lab_col = "red",
                               lab_cex = 1,
                               line_lwd = 1){
  # possibly the most geniusest piece of code the author has ever written
  # and it's just for making my plot lables nice :')
  # would be nice to rig this for longer lables though mate - set incline to angle
  # and include clause to flip if angle in pi/2-3pi/2
  
  # impose (optional) supplied cutoff
  if (rank_cutoff){  
    sites = sites[1:rank_cutoff,]
  }
  
  angles = (1:n_toadstools)*2*pi/n_toadstools
  
  # possible set of label positions
  outer_circle_coords = data.frame(x=(label_radius)*cos(angles)+centre[1], 
                                   y=(label_radius)*sin(angles)+centre[2])
  
  # possible set of end points for the lines we're putting in
  circle_coords = data.frame(x=(label_radius*gap)*cos(angles)+centre[1], 
                             y=(label_radius*gap)*sin(angles)+centre[2])
  
  if (guides == TRUE){
    points(circle_coords)
    abline(v = centre[1])
    abline(h = centre[2])
  }
  
  # keep track of occupied positions in the circle
  taken_coords = c() 
  
  for (i in 1:nrow(sites)){
    # find distance from point to all possible label locations
    dists_to_circle = my_simple_dist(circle_coords, c(sites[i,1],
                                                      sites[i,2]))
    # find closest label
    up = which(dists_to_circle == min(dists_to_circle))
    down = up
    
    # iterate around the circle if the label is already assigned
    while(up %in% taken_coords & down %in% taken_coords){
      down = ifelse(down <= 1, n_toadstools, down - 1)
      up = ifelse(up >= n_toadstools, 1, up + 1)
    }
    
    # pick the best outta the `up` and `down` options we're left with
    if(!(up %in% taken_coords) & !(down %in% taken_coords)){
      tmp = ifelse(dists_to_circle[up,1] > dists_to_circle[down,1], down, up)
    } else {
      tmp = ifelse(up %in% taken_coords, down, up)
    }
    outpoint = circle_coords[tmp,]
    outpoint_label = outer_circle_coords[tmp,]
    taken_coords = c(taken_coords, tmp)
    
    # we're ready to add to the plot!
    text(outpoint_label, labels=site_names[i], 
         col=lab_col, cex=lab_cex)
    lines(c(sites[i,1], outpoint[1]), 
          c(sites[i,2], outpoint[2]), 
          col=line_col, lwd=line_lwd)
  }
}