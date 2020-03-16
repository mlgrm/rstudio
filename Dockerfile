FROM rocker/geospatial

RUN export ADD=shiny &&  bash /etc/cont-init.d/add

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	python \
	python3  \
	virtualenv \
	python3-virtualenv  \
	python3-venv  \
	python-dev  \
	python3-dev 
RUN Rscript -e "devtools::install_github('tidyverse/googledrive')"
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
RUN install2.r -e reticulate RDS shinydashboard
