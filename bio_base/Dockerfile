FROM ruby:2.6.4-stretch

LABEL maintainer="moorer@udel.edu"

ARG bindir=/usr/local/bin
ARG downloads=/home/downloads
ARG workdir=/home
ARG ncpus=4
ARG imgname=bio_base

WORKDIR ${downloads}

# Install needed packages
RUN apt-get update && \
apt-get install -y build-essential \
                   git \
                   nano \
                   less \
                   tree \
                   curl \
                   wget \
                   zlib1g-dev \
                   openssl \
                   libssl-dev \
                   libcurl4-gnutls-dev \
                   libgit2-dev \
                   pigz \
                   bsdmainutils \
                   parallel \
                   cmake

# Ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
RUN dpkg -i ripgrep_11.0.1_amd64.deb
RUN rm ripgrep_11.0.1_amd64.deb

# Some gems
RUN gem install optimist abort_if parse_fasta systemu parallel rya

# Some shell stuff

# Scroll up and down through history
RUN echo 'export PS1="[\u@bio_docker \W] -> "' >> /etc/bash.bashrc && \
echo "bind '\"\e[A\": history-search-backward'" >> /etc/bash.bashrc && \
echo "bind '\"\e[B\": history-search-forward'" >> /etc/bash.bashrc

# Some aliases
RUN echo "alias ls='ls --color'" >> /etc/bash.bashrc && \
echo "alias l='ls --color'" >> /etc/bash.bashrc && \
echo "alias ls1='ls -1 --color'" >> /etc/bash.bashrc && \
echo "alias ls2='ls -1 --color'" >> /etc/bash.bashrc && \
echo "alias lsl='ls -lah --color'" >> /etc/bash.bashrc && \
echo "alias lst='ls -laht --color'" >> /etc/bash.bashrc && \
echo "alias lss='ls -lahS --color'" >> /etc/bash.bashrc && \
echo "alias b='cd ..'" >> /etc/bash.bashrc && \
echo "alias bb='cd ../..'" >> /etc/bash.bashrc && \
echo "alias bbb='cd ../../..'" >> /etc/bash.bashrc && \
echo "alias bbbb='cd ../../../..'" >> /etc/bash.bashrc

WORKDIR ${workdir}
