#!/bin/sh
#
# install_netcdf.sh
# Copyright (C) 2018 Daniel Santiago <dpelaez@cicese.edu.mx>
#
# Distributed under terms of the GNU/GPL license.
#
set -e


# ====================================
# NetCDF4-Fortran liberies instalation
# ------------------------------------
# Daniel Santiago
# github/dspelaez
# ====================================

## GCC 6.1
# En este momento estoy usando la versión de `gfortran 6.1` que viene
# pre-compilada en la pagina web https://gcc.gnu.org/wiki/GFortranBinaries#MacOS
# de GNU/GCC para el sistema operativo OS X El Capitán (10.11).


## ruta donde estan los tar.gz
export TARDIR=`pwd`
cd ${TARDIR}
echo "Entrando al directorio --->" ${TARDIR}
echo ""

## ruta donde estan los compiladores
export CC=/usr/bin/gcc
export FC=/usr/local/bin/gfortran
export F90=/usr/local/bin/gfortran
export F77=/usr/local/bin/gfortran

## Zlib 1.2.8
tar -xf zlib-1.2.8.tar.gz
cd zlib-1.2.8/
ZDIR=/usr/local/netcdf
./configure --prefix=${ZDIR}
make -j4
make install
cd ..
rm -rf zlib-1.2.8

## HDF5 1.8.17
tar -xf hdf5-1.8.17.tar
cd hdf5-1.8.17/
H5DIR=/usr/local/netcdf
./configure --with-zlib=${ZDIR} --prefix=${H5DIR}
make -j4
make install
cd ..
rm -rf hdf5-1.8.17

## NetCDF4-C 4.4.1
tar -xf netcdf-4.4.1.tar.gz
cd netcdf-4.4.1/
NCDIR=/usr/local/netcdf
CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR}
make -j4
make install
cd ..
rm -rf netcdf-4.4.1


## NetCDF4-Fortran 4.4.4
tar -xf netcdf-fortran-4.4.4.tar.gz
cd netcdf-fortran-4.4.4/
CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NCDIR}
make -j4
make install
cd ..
rm -rf netcdf-fortran-4.4.4

## mostrar opciones del nc-config
$NCDIR/bin/nf-config --all
