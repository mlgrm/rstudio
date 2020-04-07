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

# jailbreak and update R packages
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com'))" >> /etc/R/Rprofile.site
RUN Rscript -e "update.packages(ask = FALSE)"

# fake timedatectl to allow fable install
RUN ln -s `which true` /usr/lib/rstudio-server/bin/timedatectl 
RUN Rscript -e "devtools::install_github('tidyverse/googledrive')"
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
RUN Rscript -e "devtools::install_github('tidyverts/tsibble')"
RUN Rscript -e "devtools::install_github('tidyverts/fable')"
RUN Rscript -e "devtools::install_github('tidyverts/feasts')"
RUN install2.r -e reticulate RDS shinydashboard request plumber shinymanager r2d3
