#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --enable-mpi-io="yes" \
            --with-trio-flavor=netcdf \
            --with-dft-flavor=libxc \
            --with_fft_flavor=fftw3 \
            --with-fft-libs="-L${PREFIX}/lib/ -lfftw3 -lfftw3f" --with-fft-incs="-I${PREFIX}/include" \
            --with-libxc-incs="-I${PREFIX}/include" --with-libxc-libs="-L${PREFIX}/lib -lxcf90 -lxc" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3 -lxcf90 -lxc" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3 -lxcf90 -lxc" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3 -lxcf90 -lxc" 
make -j${CPU_COUNT}
make check
make install-exec
