#!/bin/bash
set -ex

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-fftw3="yes" \
            --with-netcdf=$(nc-config --prefix) \
            --with-netcdf_fortran=$(nf-config --prefix) \
            --with-fft-flavor="fftw3" \
            CC="mpicc" \
            FC="mpifort" \
            CXX="mpicxx" \
            CFLAGS="${CFLAGS}" \
            FFLAGS="${FFLAGS}" \
            FCFLAGS="${FCFLAGS}" \
            CPPFLAGS="${CPPFLAGS}" \
            LDFLAGS="${LDFLAGS} -lfftw3f"
cat config.log

make -j${CPU_COUNT}
make check
make install-exec
