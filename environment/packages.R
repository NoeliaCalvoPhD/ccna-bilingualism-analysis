required_packages <- c(
  "tidyverse",
  "mice",
  "lavaan",
  "semPlot",
  "caret",
  "car"
)

installed <- rownames(installed.packages())

for(pkg in required_packages){
  if(!(pkg %in% installed)){
    install.packages(pkg)
  }
}