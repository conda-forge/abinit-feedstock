#!/bin/bash
./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            SCALAPACK_LIBS="-L${PREFIX}/lib -lscalapack" \
            LAPACK_LIBS="-L${PREFIX}/lib -llapack" \
            BLAS_LIBS="-L${PREFIX}/lib -lblas" \
            FFT_LIBS="-L${PREFIX}/lib -lfftw3" \
            CC="mpicc" \
            FC="mpif90" \
            LD="mpif90 -fopenmp" \
            CFLAGS="${CFLAGS}" \
            FFLAGS="${FFLAGS}" \
            CPPFLAGS="${CPPFLAGS}"
make -j${CPU_COUNT}
make check
make install-exec
