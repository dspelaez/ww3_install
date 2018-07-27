#!/bin/sh
#
# install_netcdf.sh
# Copyright (C) 2018 Daniel Santiago <dpelaez@cicese.edu.mx>
#
# Distributed under terms of the GNU/GPL license.
#
set -e


# =========================================
# Instalación de biblioteca NetCDF4-Fortran
# -----------------------------------------
# Daniel Santiago
# github/dspelaez
# =========================================

## GCC
# MacOS
#     En este momento estoy usando la versión de `gfortran 8.1` de Homebrew
#     y la versión 8.0 de gcc nativo de apple.
#
# Ubuntu
#     Funcinó con la versión `gfortran 7.0` y `gcc 7.0` del sistema.


## ruta donde estan los tar.gz
export TARDIR=`pwd`
cd ${TARDIR}
echo "Entrando al directorio --->" ${TARDIR}
echo ""

## ruta donde estan los compiladores
read -p "C compiler [/usr/bin/gcc]: " CC; CC=${CC:-/usr/bin/gcc}
read -p "Fortran compiler [/usr/bin/local/gfortran]: " FC; FC=${FC:-/usr/bin/local/gfortran}

export CC=/usr/bin/gcc
export FC=/usr/local/bin/gfortran
export F90=${FC}
export F77=${FC}


# versiones de las bibliotecas
ZLTAG="1.2.8"
H5TAG="1.8.17"
NCTAG="4.4.1"
NFTAG="4.4.4"

## descargar los codigos fuente de las dependencias
wget -nc https://zlib.net/fossils/zlib-$ZLTAG.tar.gz
wget -nc https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-$H5TAG/src/hdf5-$H5TAG.tar 
wget -nc ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$NCTAG.tar.gz
wget -nc ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-$NFTAG.tar.gz


## Zlib 
tar -xf zlib-$ZLTAG.tar.gz
cd zlib-$ZLTAG/
ZDIR=/usr/local/netcdf
./configure --prefix=${ZDIR}
make -j4
make install
cd ..
rm -rf zlib-$ZLTAG

## HDF5
tar -xf hdf5-$H5TAG.tar
cd hdf5-$H5TAG/
H5DIR=/usr/local/netcdf
./configure --with-zlib=${ZDIR} --prefix=${H5DIR}
make -j4
make install
cd ..
rm -rf hdf5-$H5TAG

## NetCDF4-C
tar -xf netcdf-$NCTAG.tar.gz
cd netcdf-$NCTAG/
NCDIR=/usr/local/netcdf
CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR}
make -j4
make install
cd ..
rm -rf netcdf-$NCTAG


## NetCDF4-Fortran
tar -xf netcdf-fortran-$NFTAG.tar.gz
cd netcdf-fortran-$NFTAG/
CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NCDIR}
make -j4
make install
cd ..
rm -rf netcdf-fortran-$NFTAG

## mostrar opciones del nc-config
$NCDIR/bin/nf-config --all

echo ""
echo ===============================================================================
echo "Finalmente se debe agregar esto al .profile (o .bashrc o .zshrc)"
echo "  Linux --\>" export LD_LIBRARY_PATH=$NCDIR/lib:'$LD_LIBRARY_PATH'
echo "  OSX   --\>" export DYLD_LIBRARY_PATH=$NCDIR/lib:'$DYLD_LIBRARY_PATH'
echo ===============================================================================
echo ""
