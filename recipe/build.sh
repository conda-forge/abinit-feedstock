#!/bin/bash

# FFTW3
FFT_FLAVOR="none"

# Open BLAS
LINALG_FLAVOR="custom"
LINALG_LIBS="-L${PREFIX}/lib -lscalapack -llapack -lblas -lpthread"

NC_INCS="-I${PREFIX}/include"
NC_LIBS="-L${PREFIX}/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5"

# LibXC library 
XC_INCS="-I${PREFIX}/include"
XC_LIBS="-L${PREFIX}/lib -lxcf90 -lxc"

CC=mpicc
FC=mpif90

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-trio-flavor=netcdf \
            --with-linalg-flavor=${LINALG_FLAVOR} --with-linalg-libs="${LINALG_LIBS}" \
            --with-netcdf-incs="${NC_INCS}" --with-netcdf-libs="${NC_LIBS}" \
            --with-libxc-incs="${XC_INCS}" --with-libxc-libs="${XC_LIBS}"
make -j${CPU_COUNT}
make check
make install-exec
