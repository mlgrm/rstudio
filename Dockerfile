FROM rocker/geospatial

# RUN export ADD=shiny &&  bash /etc/cont-init.d/add

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	python \
	python3  \
	virtualenv \
	python3-virtualenv  \
	python3-venv  \
	python-dev  \
	python3-dev \
	curl \
	gettext-base

# jailbreak and update R packages
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com'))" >> /etc/R/Rprofile.site
RUN Rscript -e "update.packages(ask = FALSE)"

# fake timedatectl to allow fable install
RUN ln -s `which true` /usr/lib/rstudio-server/bin/timedatectl 
RUN Rscript -e "devtools::install_github('tidyverse/googledrive')"
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
# RUN Rscript -e "devtools::install_github('tidyverts/tsibble')"
# RUN Rscript -e "devtools::install_github('tidyverts/fable')"
# RUN Rscript -e "devtools::install_github('tidyverts/feasts')"
RUN install2.r -e reticulate RDS shinydashboard request plumber shinymanager shinythemes ggplotify
RUN install2.r -e plotly
RUN apt-get install -y ffmpeg
# RUN apt-get install -y grass

# google cloud sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
	tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
	apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN apt-get update && apt-get install -y libsecret-1-dev

RUN curl https://rclone.org/install.sh | bash

RUN install2.r -e RODBC

RUN install2.r -e here fs
RUN Rscript -e "devtools::install_github('erikor/timeR')"

RUN install2.r -e tidymodels tidygraph sfnetworks dotwhisker
RUN install2.r -e skimr

RUN install2.r -e multidplyr bench

RUN install2.r -e gganimate gifski png
