FROM rocker/geospatial

RUN export ADD=shiny &&  bash /etc/cont-init.d/add

RUN Rscript -e "devtools::install_github('tidyverse/googledrive')"
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
