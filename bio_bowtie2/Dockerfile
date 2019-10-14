FROM mooreryan/bio_base:0.2.0

LABEL maintainer="moorer@udel.edu"

ARG bindir=/usr/local/bin
ARG downloads=/home/downloads
ARG workdir=/home
ARG ncpus=4
ARG imgname=bio_bowtie2

WORKDIR ${downloads}

# Get bowtie2
RUN wget -O bowtie2-2.3.5.1-linux-x86_64.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5.1/bowtie2-2.3.5.1-linux-x86_64.zip/download
RUN unzip bowtie2-2.3.5.1-linux-x86_64.zip
RUN ln -s ${PWD}/bowtie2-2.3.5.1-linux-x86_64/bowtie2 ${bindir}
RUN ln -s ${PWD}/bowtie2-2.3.5.1-linux-x86_64/bowtie2-build ${bindir}
RUN rm bowtie2-2.3.5.1-linux-x86_64.zip

# Get samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
RUN tar xjf samtools-1.9.tar.bz2
WORKDIR samtools-1.9
RUN ./configure --prefix=/usr/local && make -j ${ncpus} && make install
WORKDIR ${downloads}
RUN rm samtools-1.9.tar.bz2

# Get Picard
RUN apt-get update && apt-get install -y openjdk-8-jre
RUN wget https://github.com/broadinstitute/picard/releases/download/2.21.1/picard.jar
COPY scripts/picard ${bindir}
RUN chmod 755 ${bindir}/picard

# Update rya
RUN gem install rya

WORKDIR ${workdir}
