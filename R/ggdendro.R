
#' Radar / Star / Tree ring plot
#'
#' Unsure if this will be useful but I'd like the option ......
#'
#' @param data data.frame
#' @param axes vector of strings: names of columns in `data` to include as axes
#' @param id NULL or string: name of column in `data` indicating row IDs
#' @param axis_range NULL or vector of 2 numerics: common axis range
#' @param scale_axes Boolean. Scale axes to [0,1]?
#'
#' @returns ggplot object
#' @export
#'
#' @examples
#' 
#' dat = data.frame(x = rnorm(5), y = rnorm(5), z = rnorm(5), a = rnorm(5)) + 2
#' ggdendro(axes = c("x", "y", "z", "a"), data = dat)
#' 
ggdendro <- function(data, # must be specified .......
                     axes = NULL,
                     id = NULL,
                     axis_range = NULL,
                     scale_axes = FALSE){
  # I really did spend 5 mins trying to work out how to work this into its own
  # geom but alas
  
  # because I don't really understand the anatomy of the mapping argument, 
  # I'll be silly and poke essential arguments outside it
  
  AXIS_EXT <- 1.05
  LAB_EXT <- 1.1
  
  if (length(intersect(axes, names(data))) < length(axes)){
    warning("Some `axes` are not in `names(data)`")
  }
  
  naxes <- length(axes)
  
  if (naxes < 3){warning("3 or more `axes` please")}
  
  # determine angle each of the axes
  theta <- data.frame(axis = axes,
                      theta = 1:length(axes) / length(axes) * pi * 2)
  
  # scale each of the axes to common radius:
  if (scale_axes){
    data <- data %>%
      dplyr::select(all_of(axes)) %>%
      # get everyone above zero
      mutate(across(all_of(axes), function(x){(x - min(x)) / (max(x) - min(x))}))
    
    axis_range <- c(0, 1)
  }

  # if axis range is specified
  if (!is.null(axis_range)){
    if (!is.numeric(axis_range) | length(axis_range) != 2){
      warning("axis range must be numeric of length 2")
    }
    
    if (any(axis_range < 0)){
      warning("Ya probably want your axis limits to be greater than zero")
    }
    
    data <- mutate(data, across(all_of(axes), function(x){
      x * (max(axis_range) - min(axis_range)) + min(axis_range)
    }))
  } else {
    axis_range <- range(unlist(data %>% dplyr::select(all_of(axes))))
  }
  
  # (assuming common radius in both graph space and interpretation space)
  
  # for colour scale:
  if (!is.null(id)){
    ids <- data %>% 
      dplyr::select(all_of(id)) %>%
      unlist()
  } else {
    ids <- as.factor(1:nrow(data))
  }
  
  # this all feels rather inefficient:
  coords <- bind_rows(
    theta %>%
      mutate(radius = max(axis_range) * LAB_EXT,
             categ = "axis_lab"),
    bind_rows(
      theta %>%
        mutate(radius = max(axis_range) * AXIS_EXT),
      theta %>%
        mutate(radius = 0)) %>%
      mutate(categ = "axis_line"),
    data %>%
      mutate(id = ids,
             categ = "data") %>%
      pivot_longer(cols = all_of(axes), 
                   names_to = "axis", 
                   values_to = "radius") %>%
      left_join(theta)) %>%
    mutate(cart_x = radius * cos(theta),
           cart_y = radius * sin(theta)) %>%
    arrange(axis)
  
  box_lims <- c(-max(axis_range), max(axis_range)) * LAB_EXT
  
  ggplot(data = coords, aes(x = cart_x, y = cart_y)) +
    geom_line(data = . %>% filter(categ == "axis_line"), 
              aes(group = axis)) +
    geom_text(data = . %>% filter(categ == "axis_lab"),
              aes(label = axis)) +
    # here comes the data:
    geom_point(data = . %>% filter(categ == "data"),
               aes(col = id)) +
    geom_polygon(data = . %>% filter(categ == "data"),
                 aes(col = id, group = id),
                 fill = NA) +
    xlim(min(box_lims), max(box_lims)) +
    ylim(min(box_lims), max(box_lims)) +
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank()) +
    theme_void()
    
}










