#!/bin/bash

export VERSION="${PKG_VERSION}"

echo $VERSION > .version && echo $VERSION > .tarball-version && ./autogen.sh

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-fftw3="yes" \
            --with-netcdf="yes" \
            --with-netcdf-fortran="yes" \
            --with-fft-flavor="fftw3" \
            FFTW3_LIBS="-lfftw3 -lfftw3f" \
            CC="mpicc" \
            FC="mpifort" \
            CXX="mpicxx" \
            CFLAGS="${CFLAGS}" \
            FFLAGS="${FFLAGS}" \
            FCFLAGS="${FCFLAGS}" \
            FCFLAGS_EXTRA="-fallow-argument-mismatch" \
            CPPFLAGS="${CPPFLAGS}" \
            LDFLAGS="${LDFLAGS}"
make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
    make check
fi
make install-exec
