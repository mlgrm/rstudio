FROM rocker/geospatial

RUN export ADD=shiny &&  bash /etc/cont-init.d/add

RUN Rscript -e "devtools::install_github('googledrive')"
RUN Rscript -e "devtools::install_github('googlesheets4')"
