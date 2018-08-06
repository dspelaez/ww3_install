FROM ubuntu:18.04
MAINTAINER Daniel Santiago <dspelaez@gmail.com>

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
COPY install_netcdf.sh /root/libs
COPY zlib-1.2.10.tar.gz /root/libs
COPY hdf5-1.10.1.tar /root/libs
COPY netcdf-4.6.1.tar.gz /root/libs
COPY netcdf-fortran-4.4.4.tar.gz /root/libs
COPY wwatch3.v5.16.tar.gz /root/ww3


# =================================
#  === install netcdf libraries ===
# =================================
#
RUN cd /root/libs && ./install_netcdf.sh
RUN export LD_LIBRARY_PATH=/usr/local/netcdf/lib:$LD_LIBRARY_PATH
RUN echo export LD_LIBRARY_PATH=/usr/local/netcdf/lib:'$LD_LIBRARY_PATH' >> /root/.bashrc


# ===========================================
# === install wavewatch iii interactively ===
# ===========================================

# untar and run instalation script
RUN cd /root/ww3 && \
    tar -xvf wwatch3.v5.16.tar.gz && \
    chmod 755 ./install_ww3_tar && \
    printf "y\nL\ny\ny\nprinter\ngfortran\ngcc\n/root/ww3/tmp\nyes\nyes\ny\ny" > answers && \
    ./install_ww3_tar < answers

# copy gnu link script to link file
RUN cp /root/ww3/bin/link.gnu /root/ww3/bin/link

# copy gnu scipt to comp replacing O3 by O0
RUN sed 's/O3/O0/g' /root/ww3/bin/comp.gnu > /root/ww3/bin/comp

# copy switch file
COPY switch /root/ww3/bin

# compile the entire code
RUN /root/ww3/bin/w3_clean && /root/ww3/bin/w3_new && /root/ww3/bin/w3_make

# delete unnecessary files
RUN rm -rf /root/ww3/README_manual_reference /root/ww3/manual.v5.16.pdf        \
           /root/ww3/arc /root/ww3/regtests /root/ww3/cases /root/ww3/smc_docs \
           /root/libs

# set working directory
WORKDIR /root/ww3/work

# ---  end of file ---
