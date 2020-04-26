FROM ubuntu:20.04
MAINTAINER Daniel Santiago <@dspelaez>

# =========================
# === preration of data ===
# =========================

# set home variable
ENV HOME /root
ENV TERM xterm

RUN apt-get update
RUN apt-get -yq install build-essential m4 \
                        gcc gfortran g++ \
                        curl libcurl4-gnutls-dev wget \
                        git tar vim

# set environmental variables
ENV NCDIR /usr/local/netcdf
ENV WWATCH3_NETCDF NC4
ENV NETCDF_CONFIG /usr/local/netcdf/bin/nf-config

# create folders to put libs and ww3 source in
RUN mkdir -p /root/libs /root/ww3


# =================================
#  === install netcdf libraries ===
# =================================
#
ADD https://raw.githubusercontent.com/dspelaez/install-netcdf-fortran/master/install_netcdf.sh /root/libs
WORKDIR /root/libs
RUN chmod 755 ./install_netcdf.sh && \
    CC=gcc FC=gfortran MAINDIR=/usr/local/netcdf ./install_netcdf.sh && \
    export LD_LIBRARY_PATH=/usr/local/netcdf/lib:$LD_LIBRARY_PATH && \
    echo export LD_LIBRARY_PATH=/usr/local/netcdf/lib:'$LD_LIBRARY_PATH' >> /root/.bashrc


# ===========================================
# === install wavewatch iii interactively ===
# ===========================================

# get tar file from repository
WORKDIR /root/ww3
RUN wget https://github.com/NOAA-EMC/WW3/releases/download/6.07/wwatch3.v6.07.tar.gz

# untar and run instalation script
RUN tar -xvf wwatch3.v6.07.tar.gz && \
    chmod 755 ./install_ww3_tar && \
    printf "y\nL\ny\ny\nprinter\ngfortran\ngcc\n/root/ww3/model/tmp\nyes\nyes\ny\ny" > answers && \
    ./install_ww3_tar < answers

# copy switch file
COPY switch /root/ww3/model/bin
RUN cp /root/ww3/model/bin/link.Gnu /root/ww3/model/bin/link
RUN cp /root/ww3/model/bin/comp.Gnu /root/ww3/model/bin/comp

# compile the entire code
RUN /root/ww3/model/bin/w3_clean && \
    /root/ww3/model/bin/w3_new   && \
    /root/ww3/model/bin/w3_make

# delete unnecessary files
RUN rm -rf /root/ww3/README_manual_reference /root/ww3/manual.*.pdf \
           /root/ww3/arc /root/ww3/regtests /root/ww3/smc_docs \
           /root/libs

# set working directory
WORKDIR /root/ww3/model/work

# ---  end of file ---
