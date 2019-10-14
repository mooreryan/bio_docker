FROM mooreryan/r_dev_base:0.2.0

LABEL maintainer="moorer@udel.edu"

ARG scriptsdir=./scripts
ARG bindir=/usr/local/bin
ARG downloads=/home/downloads
ARG workdir=/home
ARG ncpus=4

WORKDIR ${downloads}

# NCBI taxonomy dump
WORKDIR ncbi_taxonomy_dump
RUN wget 'ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump/new_taxdump.tar.gz'
RUN tar xzf new_taxdump.tar.gz
WORKDIR keep
RUN mv ../names.dmp ../nodes.dmp .
RUN pigz names.dmp nodes.dmp
WORKDIR ..
RUN rm -r new_taxdump.tar.gz *.dmp
RUN mv keep/* .
RUN rm -r keep

## Ruby stuff

WORKDIR ${downloads}
RUN curl https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.4.tar.gz | tar xz
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

# Install cutadapt
WORKDIR ${downloads}
RUN apt-get update && apt-get install -y python3-pip
RUN python3 -m pip install cutadapt

# Install grep ids progam
WORKDIR ${downloads}
RUN git clone https://github.com/mooreryan/grep_seqs.git
WORKDIR grep_seqs
RUN gcc grep_ids.c vendor/*.c -I./vendor -lz -Wall -g -O3 -o ${bindir}/grep_ids

# Install some length utilities
WORKDIR ${downloads}
RUN wget https://raw.githubusercontent.com/mooreryan/fresh_balloon/441c0876b2f77c8d75933571d1a1b4b27831eb51/length/seq_lengths.c
RUN wget https://raw.githubusercontent.com/mooreryan/fresh_balloon/441c0876b2f77c8d75933571d1a1b4b27831eb51/length/filter_length.c
RUN wget https://raw.githubusercontent.com/mooreryan/fresh_balloon/441c0876b2f77c8d75933571d1a1b4b27831eb51/length/kseq.h
RUN gcc -O3 -Wall seq_lengths.c -o ${bindir}/seq_lengths -lz
RUN gcc -O3 -Wall filter_length.c -o ${bindir}/filter_length -lz
RUN rm seq_lengths.c filter_length.c kseq.h

# Install VSEARCH
WORKDIR ${downloads}
RUN wget https://github.com/torognes/vsearch/releases/download/v2.13.4/vsearch-2.13.4-linux-x86_64.tar.gz
RUN tar xzf vsearch-2.13.4-linux-x86_64.tar.gz
RUN mv vsearch-2.13.4-linux-x86_64/bin/vsearch ${bindir}
RUN rm -r vsearch-2.13.4-linux-x86_64 && rm vsearch-2.13.4-linux-x86_64.tar.gz

# Install FLASh (used for RI samples)
WORKDIR ${downloads}
RUN wget 'http://ccb.jhu.edu/software/FLASH/FLASH-1.2.11-Linux-x86_64.tar.gz'
RUN tar xzf FLASH-1.2.11-Linux-x86_64.tar.gz
RUN ln -s $(pwd)/FLASH-1.2.11-Linux-x86_64/flash ${bindir}/flash
RUN rm FLASH-1.2.11-Linux-x86_64.tar.gz

# Install fastp for read processing
WORKDIR ${downloads}
RUN git clone https://github.com/OpenGene/fastp.git
WORKDIR fastp
RUN make -j4
RUN make install
RUN rm -r fastp

# Add the SILVA LTP
WORKDIR ${downloads}
WORKDIR silva_ltp
RUN wget 'https://www.arb-silva.de/fileadmin/silva_databases/living_tree/LTP_release_132/LTPs132_SSU.csv'
RUN wget 'https://www.arb-silva.de/fileadmin/silva_databases/living_tree/LTP_release_132/LTPs132_datasets.fasta.tar.gz'
RUN tar xzf LTPs132_datasets.fasta.tar.gz
RUN pigz LTPs132_SSU.csv LTPs132_SSU_compressed.fasta
RUN rm *.fasta *.tar.gz

# Install make_silva_sintax_db
WORKDIR ${downloads}
RUN wget 'https://raw.githubusercontent.com/mooreryan/ncbi_taxonomy_lookup/d7147dcf4dcc84252bc3a8464602e5eb919280bb/make_silva_sintax_db.rb'
RUN chmod 755 make_silva_sintax_db.rb
RUN mv make_silva_sintax_db.rb ${bindir}/make_silva_sintax_db

# Install make_taxonomy_table
WORKDIR ${downloads}
ADD ${scriptsdir}/make_taxonomy_table.rb ${bindir}/make_taxonomy_table
RUN chmod 755 ${bindir}/make_taxonomy_table

# Install hexbin R package.  Change repo as the cloud repo was down when I built this.
RUN Rscript -e "if (!require('hexbin')) install.packages('hexbin', repos = 'http://lib.stat.cmu.edu/R/CRAN/', Ncpus = ${ncpus})"

# Switch the working directory
WORKDIR ${workdir}
