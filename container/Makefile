#
# Makefile
# Daniel Santiago, 2018-08-03 13:47
# vim:ft=make
#

# get data
getdata:
	wget -nc https://zlib.net/fossils/zlib-1.2.10.tar.gz
	wget -nc https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.8.17/src/hdf5-1.10.1.tar 
	wget -nc ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.6.1.tar.gz
	wget -nc ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz

# build the container
build:
	docker build -t ww3-docker .

# run bash inside container
run:
	docker run -it --rm --name=ww3 ww3-docker

# run ww3_grid
aliases:
	alias ww3_grid="docker run -it --rm --name=ww3_grid -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_grid"
	alias ww3_strt="docker run -it --rm --name=ww3_strt -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_strt"
	alias ww3_prep="docker run -it --rm --name=ww3_prep -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_prep"
	alias ww3_prnc="docker run -it --rm --name=ww3_prnc -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_prnc"
	alias ww3_shel="docker run -it --rm --name=ww3_shel -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_shel"
	alias ww3_mult="docker run -it --rm --name=ww3_mult -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_multi"
	alias ww3_outp="docker run -it --rm --name=ww3_outp -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_outp"
	alias ww3_outf="docker run -it --rm --name=ww3_outf -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_outf"
	alias ww3_ounp="docker run -it --rm --name=ww3_ounp -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_ounp"
	alias ww3_ounf="docker run -it --rm --name=ww3_ounf -v $(pwd):/root/ww3/work ww3-docker /root/ww3/exe/ww3_ounf"
