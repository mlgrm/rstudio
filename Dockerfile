FROM rocker/geospatial

RUN export ADD=shiny &&  bash /etc/cont-init.d/add

RUN apt-get install -y python python3 python-venv python3-venv python-dev python3-dev
RUN Rscript -e "devtools::install_github('tidyverse/googledrive')"
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
RUN Rscript -e "install.packages('reticulate')"
RUN Rscript -e "install.packages('RDS')"
RUN Rscript -e "install.packages('shinydashboard')
