#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-fftw3="yes" \
            --with-netcdf="yes" \
            --with-netcdf-fortran="yes" \
            --with-fft-flavor="fftw3" \
            FFT_LIBS="-lfftw3 -lfftw3f" \
            CC="mpicc" \
            FC="mpifort" \
            CXX="mpicxx" \
            CFLAGS="${CFLAGS}" \
            FFLAGS="${FFLAGS}" \
            FCFLAGS="${FCFLAGS}" \
            CPPFLAGS="${CPPFLAGS}" \
            LDFLAGS="${LDFLAGS}"
make -j${CPU_COUNT}
make check
make install-exec
