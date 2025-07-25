# Some junk code to make my package
# https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

library(devtools)
library(roxygen2)
setwd("~/")
create("greta.gp.st.on.earth")

# add all your functions into R/ and document them with roxygen skeletons

setwd("~/greta.gp.st.on.earth")
document()

# now install!
setwd("..")
install("greta.gp.st.on.earth")
library(greta.gp)
