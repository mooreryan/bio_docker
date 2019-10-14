FROM mooreryan/r_dev_base:0.2.0

LABEL maintainer="moorer@udel.edu"

ARG scriptsdir=./scripts
ARG bindir=/usr/local/bin
ARG downloads=/home/downloads
ARG workdir=/home
ARG ncpus=4

WORKDIR ${downloads}

## Ruby stuff

WORKDIR ${downloads}
RUN \curl https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.4.tar.gz | tar xz
WORKDIR ruby-2.6.4
RUN ./configure && make -j${ncpus} && make install
WORKDIR ${downloads}
RUN rm -r ruby-2.6.4

# Install some Ruby gems
RUN gem install abort_if \
                bundler \
                optimist \
                parse_fasta \
                rya \
                systemu

#### R packages

# First install R devtools
RUN Rscript -e "if (!require('devtools')) install.packages('devtools', Ncpus = ${ncpus})"

# Then bioconductor
RUN Rscript -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) { install.packages("BiocManager") }; BiocManager::install()'
RUN Rscript -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) { install.packages("BiocManager") }; BiocManager::install("phyloseq")'

# A whole bunch of R packages
RUN Rscript -e "if (!require('ade4')) install.packages('ade4', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('ape')) install.packages('ape', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('compositions')) install.packages('compositions', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('doParallel')) install.packages('doParallel', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('doSNOW')) install.packages('doSNOW', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('dplyr')) install.packages('dplyr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('fastcluster')) install.packages('fastcluster', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('fastqcr')) install.packages('fastqcr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('foreach')) install.packages('foreach', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('ggplot2')) install.packages('ggplot2', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('ggrepel')) install.packages('ggrepel', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('gplots')) install.packages('gplots', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('gridExtra')) install.packages('gridExtra', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('hexbin')) install.packages('hexbin', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('igraph')) install.packages('igraph', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('knitr')) install.packages('knitr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('magrittr')) install.packages('magrittr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('MASS')) install.packages('MASS', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('mvnfast')) install.packages('mvnfast', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('parallel')) install.packages('parallel', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('PDSCE')) install.packages('PDSCE', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('peakRAM')) devtools::install_github('tpq/peakRAM', repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('profvis')) install.packages('profvis', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('propr')) install.packages('propr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('rbenchmark')) install.packages('rbenchmark', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('RcppEigen')) install.packages('RcppEigen', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('Rcpp')) install.packages('Rcpp', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('RcppParallel')) install.packages('RcppParallel', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('rmarkdown')) install.packages('rmarkdown', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('robCompositions')) install.packages('robCompositions', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('R.rsp')) install.packages('R.rsp', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('R.utils')) install.packages('R.utils', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('scales')) install.packages('scales', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('testthat')) install.packages('testthat', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('tibble')) install.packages('tibble', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('tictoc')) install.packages('tictoc', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('tidyr')) install.packages('tidyr', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('vegan')) install.packages('vegan', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('VennDiagram')) install.packages('VennDiagram', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "if (!require('zCompositions')) install.packages('zCompositions', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"

# Some packages are on GitHub only
RUN Rscript -e "if (!require('biplotr')) devtools::install_github('mooreryan/biplotr')"
RUN Rscript -e "if (!require('breakaway')) devtools::install_github('adw96/breakaway')"
RUN Rscript -e "if (!require('DivNet')) devtools::install_github('adw96/DivNet')"

# Tinylatex for kniting PDF docs
RUN Rscript -e "if (!require('tinytex')) install.packages('tinytex', Ncpus = ${ncpus}, repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "tinytex::install_tinytex()"
