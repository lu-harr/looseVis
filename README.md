### looseVis

#### A Cheeky Package To Save Me Time With Base Graphics

I would like to stop copy-pasting old code for visualisations and start writing 
new visualisations. To this end, I'm putting all of my cheat functions for plotting 
with R base graphics in one place and learning how to write an R package in one fell 
swoop. With thanks to <https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/>

Simply conjure her up with `install_github("lu-harr/looseVis")`

Now with added:

- `fairy_circle_labels()` for positioning labels in a circle around points on a map
- `subfigure_label()` for adding labels to a plot with common plotting coordinates
- `empty_plot_for_legend()` for resetting a (complicated) plotting window so you can draw things right on top of it