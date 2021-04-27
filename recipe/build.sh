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

#if [[ "$mpi" == "openmpi" ]]; then
#    export OMPI_MCA_plm_rsh_agent=sh
#fi

make -j${CPU_COUNT}

make check
make test_v1
./tests/runtests.py v1 -j${CPU_COUNT} -o1 -n1
./tests/runtests.py paral mpiio -n4 -o1

make install-exec
