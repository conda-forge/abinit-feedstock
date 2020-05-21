#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --enable-mpi-io="yes" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude -I${SRC_DIR}/S3DE/iotk/include/" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lscalapack -lblas -lfftw3" 
make -j${CPU_COUNT}
make check
make install-exe
