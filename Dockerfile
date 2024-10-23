FROM rocker/shiny-verse
COPY . /workdir

COPY . ./app

RUN Rscript -e "install.packages(c('rhino'), repos='http://cran.rstudio.com')"
# expose port
EXPOSE 4040

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 4040)"]
