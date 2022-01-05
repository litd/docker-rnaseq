# % Last Change: Wed Jan 05 02:39:08 PM 2022 CST
# Base Image
FROM continuumio/miniconda3:4.10.3

# File Author / Maintainer
LABEL Author="Tiandao Li <litd99@gmail.com>"

ENV PATH /opt/conda/bin:$PATH

# Installation
RUN conda install -c conda-forge r-base=4.1.2 && \
    conda install -c bioconda -c conda-forge cutadapt=3.5 && \
    conda install -c bioconda fastqc=0.11.9 && \
    conda install -c bioconda -c conda-forge multiqc=1.11 && \
    conda install -c bioconda picard=2.26.9 && \
    conda install -c bioconda -c conda-forge rsem=1.3.3 && \ 
    conda install -c bioconda -c conda-forge rseqc=4.0.0 && \
    conda install -c bioconda samtools=1.12 && \
    conda install -c bioconda star=2.7.9a && \
    conda install -c bioconda subread=2.0.1 && \
    conda install -c bioconda -c conda-forge ucsc-bedsort && \
    conda install -c conda-forge unzip=6.0 && \
    conda clean --all --yes

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    bc \
    curl \
    g++ \
    jq \
    rename \
    zlib1g-dev && \
    curl -fsSL https://github.com/smithlabcode/preseq/releases/download/v3.1.2/preseq-3.1.2.tar.gz -o /opt/preseq-3.1.2.tar.gz && \
    tar -zxvf /opt/preseq-3.1.2.tar.gz -C /opt/ && \
    rm /opt/preseq-3.1.2.tar.gz && \
    cd /opt/preseq-3.1.2/ && \
    mkdir build && cd build && \
    ../configure && \ 
    make && make install && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

